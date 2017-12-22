#include <openssl/evp.h>
#include <openssl/ec.h>

#include "libavutil/opt.h"
#include "libavformat/avc.h"

#include "bsf.h"

#define CURVE           NID_secp521r1
#define PRIVATE_BIN     66
#define PUBLIC_BIN      67
#define PUBLIC_BIN_BUF	69
#define PRIVATE_KEY     88
#define PUBLIC_KEY      92

typedef struct EncryptContext {
    const AVClass *class;
    char *key;

    EC_GROUP *group;
    EC_POINT *public;
    EVP_CIPHER_CTX *cipher;
    
    EC_KEY *temp;
    BIGNUM *pub;
} EncryptContext;

static int encrypt_init(AVBSFContext *ctx)
{
    EncryptContext *s = ctx->priv_data;
    char public[PUBLIC_BIN_BUF];
    int ret;
    
    s->group = EC_GROUP_new_by_curve_name(CURVE);
    s->public = EC_POINT_new(s->group);
    
    ret = EVP_DecodeBlock(public, s->key, PUBLIC_KEY);
    
	s->pub = BN_new();

    s->pub = BN_bin2bn(public, PUBLIC_BIN, s->pub);
    
    s->public = EC_POINT_bn2point(s->group, s->pub, s->public, 0);
      
    s->cipher = EVP_CIPHER_CTX_new();
    
    s->temp = EC_KEY_new();
    
    ret = EC_KEY_set_group(s->temp, s->group);
    
    return 0;
}

static int encrypt_filter(AVBSFContext *ctx, AVPacket *out)
{
    EncryptContext *s = ctx->priv_data;

    AVPacket *in;
    uint8_t unit_type;
    uint32_t offset;
	uint8_t nal_header_size;
    int ret = 0;
    
    ret = ff_bsf_get_packet(ctx, &in);
    if (ret < 0)
        return ret;
    
    const uint8_t *p = in->data;
    const uint8_t *end = p + in->size;
    const uint8_t *nal_start, *nal_end;
    
    int size = 0;
    nal_start = ff_avc_find_startcode(p, end);
    for (;;) {
		const uint8_t *sc = nal_start;
        while (nal_start < end && !*(nal_start++));
        if (nal_start == end)
            break;
        
        nal_end = ff_avc_find_startcode(nal_start, end);
        
        unit_type = *nal_start & 0x1f;
        
		offset = out->size;
		nal_header_size = nal_start - sc;
		size = nal_header_size + nal_end - nal_start;

		switch (unit_type) {
		case 0:
		case 1:
		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
		case 7:
		case 8:
		case 9:
		case 16:
		case 17:
		case 18:
		case 19:
		case 20:
		case 21: {
			ret = av_grow_packet(out, size + PUBLIC_BIN);
			if (ret < 0)
				goto fail;

			memcpy(out->data + offset, nal_start - nal_header_size, nal_header_size + 1);

			ret = EC_KEY_generate_key(s->temp);

			const EC_POINT *public = EC_KEY_get0_public_key(s->temp);

			s->pub = EC_POINT_point2bn(s->group, public, POINT_CONVERSION_COMPRESSED, s->pub, 0);

			ret = BN_bn2bin(s->pub, out->data + offset + nal_header_size + 1);

			char key[PRIVATE_BIN];

			ret = ECDH_compute_key(key, sizeof(key), s->public, s->temp, 0);

			ret = EVP_EncryptInit(s->cipher, EVP_aes_256_ctr(), key, 0);

			ret = EVP_EncryptUpdate(s->cipher, out->data + offset + nal_header_size + 1 + PUBLIC_BIN, &ret,
				nal_start + 1, nal_end - nal_start - 1);

			break;
		} default:
			ret = av_grow_packet(out, size);
			if (ret < 0)
				goto fail;
			
			memcpy(out->data + offset, nal_start - nal_header_size, size);
			break;
		}

        nal_start = nal_end;
    }
    
	ret = av_packet_copy_props(out, in);
	if (ret < 0)
		goto fail;

fail:
	if (ret < 0)
		av_packet_unref(out);
    av_packet_free(&in);
    
    return ret;
}

static void encrypt_close(AVBSFContext *ctx)
{
    EncryptContext *s = ctx->priv_data;
    
    BN_free(s->pub);
    EC_KEY_free(s->temp);
    
    EVP_CIPHER_CTX_free(s->cipher);
    EC_POINT_free(s->public);
    EC_GROUP_free(s->group);
}

static const enum AVCodecID codec_ids[] = {
    AV_CODEC_ID_HEVC, AV_CODEC_ID_H264, AV_CODEC_ID_NONE,
};

#define OFFSET(x) offsetof(EncryptContext, x)
static const AVOption options[] = {
    { "key", NULL, OFFSET(key), AV_OPT_TYPE_STRING },
    { NULL },  
};

static const AVClass encrypt_class = {
    .class_name = "encrypt bsf",
    .item_name  = av_default_item_name,
    .option     = options,
    .version    = 0,
};

const AVBitStreamFilter ff_encrypt_bsf = {
    .name           = "encrypt",
    .codec_ids      = codec_ids,
    .priv_class     = &encrypt_class,
    .priv_data_size = sizeof(EncryptContext),
    .init           = encrypt_init,
    .filter         = encrypt_filter,
    .close          = encrypt_close
};
