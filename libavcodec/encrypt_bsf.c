#include "bsf.h"

#include <openssl/evp.h>
#include <openssl/ec.h>

#include "libavutil/opt.h"

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
    char public[33];
    int ret;
    
    s->group = EC_GROUP_new_by_curve_name(NID_secp256k1);
    s->public = EC_POINT_new(s->group);
    
    ret = EVP_DecodeBlock(public, s->key, 44);
    
    s->pub = BN_new();

    s->pub = BN_bin2bn(public, 33, s->pub);
    
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
    int ret = 0;
    
    ret = ff_bsf_get_packet(ctx, &in);
    if (ret < 0)
        return ret;
    
    if (1) {
        ret = av_new_packet(out, in->size + 33);
        if (ret < 0)
            goto fail;
        
        ret = av_packet_copy_props(out, in);
        if (ret < 0) {
            av_packet_unref(out);
            goto fail;
        }
        
        ret = EC_KEY_generate_key(s->temp);
        
        const EC_POINT *public = EC_KEY_get0_public_key(s->temp);
        
        s->pub = EC_POINT_point2bn(s->group, public, POINT_CONVERSION_COMPRESSED, s->pub, 0);
        
        ret = BN_bn2bin(s->pub, out->data);
              
        char key[32];
        
        ret = ECDH_compute_key(key, 32, s->public, s->temp, 0);
        
        ret = EVP_EncryptInit(s->cipher, EVP_aes_128_ctr(), key, 0);
    
        ret = EVP_EncryptUpdate(s->cipher, out->data + 33, &ret, in->data, in->size);
        
        ret = 0;
    } else {
        av_packet_move_ref(out, in);
    }
    
fail:
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

#define OFFSET(x) offsetof(EncryptContext, x)
static const AVOption options[] = {
    { "key", NULL, OFFSET(key), AV_OPT_TYPE_STRING},
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
    .priv_class     = &encrypt_class,
    .priv_data_size = sizeof(EncryptContext),
    .init           = encrypt_init,
    .filter         = encrypt_filter,
    .close          = encrypt_close
};
