//
//  SecKeyTools.h
//  EncryptionTest
//
//  Created by JianF.Sun on 17/4/19.
//  Copyright © 2017年 sjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecKeyTools : NSObject
/**
 从x509 cer证书中读取公钥
 */
+ (SecKeyRef )publicKeyFromCer:(NSString *)cerFile;


/**
 从 p12 文件中读取私钥，一般p12都有密码
 */
+ (SecKeyRef )privateKeyFromP12:(NSString *)p12File password:(NSString *)pwd;


/**
 iOS 10 上可用如下接口SecKeyCreateWithData 从pem文件中读取私钥或公钥
 */
+ (SecKeyRef )publicKeyFromPem:(NSString *)pemFile keySize:(size_t )size;

+ (SecKeyRef )privaKeyFromPem:(NSString *)pemFile keySize:(size_t )size;
/*
 使用公钥私钥字符串加密解密，注意：私钥字符串需要进行pkcs8转码
 */
+ (SecKeyRef)PublicKey:(NSString *)key;
+ (SecKeyRef)PrivateKey:(NSString *)key;
@end
