//
//  NSData+JYRSA.m
//  EncryptionTest
//
//  Created by JianF.Sun on 17/4/19.
//  Copyright © 2017年 sjf. All rights reserved.
//

#import "NSData+JYRSA.h"

@implementation NSData (JYRSA)

/**
 公钥加密
 */
- (NSData *)RSAEncryptWith:(SecKeyRef )publicKey paddingType:(RSAPaddingTYPE )pdType
{
    if (!publicKey || self.length <1) {
        return nil;
    }
    OSStatus ret;
    NSData *retData = nil;
    size_t blockSize = SecKeyGetBlockSize(publicKey);
    uint8_t *encData = malloc(blockSize);
    bzero(encData, blockSize);
    
    SecPadding rsaPdd;
    switch (pdType) {
        case RSAPaddingNONE:
            rsaPdd = kSecPaddingNone;
            break;
        case RSAPaddingPKCS1:
            rsaPdd = kSecPaddingPKCS1;
            break;
        case RSAPaddingOAEP:
            rsaPdd = kSecPaddingOAEP;
            break;
            
        default:
            rsaPdd = kSecPaddingPKCS1;
            break;
    }
    
    ret = SecKeyEncrypt(publicKey, rsaPdd, self.bytes, self.length, encData, &blockSize);
    if (ret==errSecSuccess) {
        retData = [NSData dataWithBytes:encData length:blockSize];
    }
    free(encData);
    encData = NULL;
    
    return retData;
}

/**
 私钥解密
 */
- (NSData *)RSADecryptWith:(SecKeyRef )privateKey paddingType:(RSAPaddingTYPE )pdType
{
    if (!privateKey || self.length <1) {
        return nil;
    }
    NSData *retData = nil;
    OSStatus ret;
    size_t blockSize = SecKeyGetBlockSize(privateKey);
    uint8_t *decData = malloc(blockSize);
    bzero(decData, blockSize);
    SecPadding rsaPdd;
    switch (pdType) {
        case RSAPaddingNONE:
            rsaPdd = kSecPaddingNone;
            break;
        case RSAPaddingPKCS1:
            rsaPdd = kSecPaddingPKCS1;
            break;
        case RSAPaddingOAEP:
            rsaPdd = kSecPaddingOAEP;
            break;
            
        default:
            rsaPdd = kSecPaddingPKCS1;
            break;
    }
    
    ret = SecKeyDecrypt(privateKey, rsaPdd, self.bytes, self.length, decData, &blockSize);
    if (ret==errSecSuccess) {
        retData = [NSData dataWithBytes:decData length:blockSize];
    }
    free(decData);
    decData = NULL;
    return retData;
}

@end
