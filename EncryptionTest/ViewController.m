//
//  ViewController.m
//  EncryptionTest
//
//  Created by JianF.Sun on 17/4/18.
//  Copyright © 2017年 sjf. All rights reserved.
//

#import "ViewController.h"

#define private_key_string @"MIICXQIBAAKBgQC5/xOHGoG/8Zj0YLb42G1nnNolunW1+B+NUZx+h7eFFo921Gllt9XhmtKBOIhPUvdu0Ju8AMpTI3Kh1nvLaO2Rqlw1XG2/taRkIvChefHkJpQzZ9aNpo8o3q3krbAv5YPe6bna8k06jhvqE9Ea/Mu+f8qhwLe8LFRkqNxLoqu70QIDAQABAoGATWhOLT0n4MVgvdv+amRQa/3IgEkwshHYt8zOT46WHyp7fJ38W1v+BI2VrDfl6vWBiroBBmZhzeYD0DzeepJpxC6p/WAQaAOLSeN3FGBl04toIwTeZdJhXzLXlzkNLvqeZIytF0Mg6+gITGCmaCrae8oq+1wp8VuSqo/uGrzkGVECQQDsN8cLwMUVMfnZJiBdUH4lR/16Cfg/Dp36KoCzMoKWpiJEe4FMTF+NKu6KLMmVvkMK2LTOLsVSCI+To06H2mANAkEAyZKch93jXA78iDK1OigTuelh96jpKBlBPVV2/P4+mnmw8M2lIxZZTPJBVOLF+2/4wJQgolRtNDGpyiN/hYvV1QJBAJGfaTQTqOwCHTcDTBx6zOmK0fb0QngNONLKdQED+IGK9cEmKnWw9479koTYS4Xm/0mmgwBA0SBbarfnizgxJdkCQQCtTpOssVcYwH3ZMBfm/6wuLP2hLKYCZuxTqpaaYJI8yKIb+AOijkWLRcJsFGn6i8QI95KzXvlhZc3A0RKEJL1dAkAiP+rJbKTwiIbDDa45WeoA5ahVLgZWEg23jnClXIPigjYSPgJSbuJMT8iS2DCjBmHpUK/kZQpxn7K0I2VeIs6T"

#define private_key_string_pkcs8 @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALn/E4cagb/xmPRgtvjYbWec2iW6dbX4H41RnH6Ht4UWj3bUaWW31eGa0oE4iE9S927Qm7wAylMjcqHWe8to7ZGqXDVcbb+1pGQi8KF58eQmlDNn1o2mjyjereStsC/lg97pudryTTqOG+oT0Rr8y75/yqHAt7wsVGSo3Euiq7vRAgMBAAECgYBNaE4tPSfgxWC92/5qZFBr/ciASTCyEdi3zM5PjpYfKnt8nfxbW/4EjZWsN+Xq9YGKugEGZmHN5gPQPN56kmnELqn9YBBoA4tJ43cUYGXTi2gjBN5l0mFfMteXOQ0u+p5kjK0XQyDr6AhMYKZoKtp7yir7XCnxW5Kqj+4avOQZUQJBAOw3xwvAxRUx+dkmIF1QfiVH/XoJ+D8OnfoqgLMygpamIkR7gUxMX40q7oosyZW+QwrYtM4uxVIIj5OjTofaYA0CQQDJkpyH3eNcDvyIMrU6KBO56WH3qOkoGUE9VXb8/j6aebDwzaUjFllM8kFU4sX7b/jAlCCiVG00ManKI3+Fi9XVAkEAkZ9pNBOo7AIdNwNMHHrM6YrR9vRCeA040sp1AQP4gYr1wSYqdbD3jv2ShNhLheb/SaaDAEDRIFtqt+eLODEl2QJBAK1Ok6yxVxjAfdkwF+b/rC4s/aEspgJm7FOqlppgkjzIohv4A6KORYtFwmwUafqLxAj3krNe+WFlzcDREoQkvV0CQCI/6slspPCIhsMNrjlZ6gDlqFUuBlYSDbeOcKVcg+KCNhI+AlJu4kxPyJLYMKMGYelQr+RlCnGfsrQjZV4izpM="

#define public_key_string @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC5/xOHGoG/8Zj0YLb42G1nnNolunW1+B+NUZx+h7eFFo921Gllt9XhmtKBOIhPUvdu0Ju8AMpTI3Kh1nvLaO2Rqlw1XG2/taRkIvChefHkJpQzZ9aNpo8o3q3krbAv5YPe6bna8k06jhvqE9Ea/Mu+f8qhwLe8LFRkqNxLoqu70QIDAQAB"

#define Oringin_Str @"江津渡blog"

@interface ViewController ()

@end

@implementation ViewController
//
static NSString *base64_encode_data(NSData *data){
    data = [data base64EncodedDataWithOptions:0];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}
//
//static NSData *base64_decode(NSString *str){
//    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    return data;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadRef];
    
}
#pragma mark - SecKeyRef

-(void)loadRef{
    //读取文件获取seckeyref
//    NSString *publicPath=[[NSBundle mainBundle]pathForResource:@"rsa_public_key" ofType:@"pem"];
//    NSString *privatePath=[[NSBundle mainBundle]pathForResource:@"rsa_private_key" ofType:@"pem"];
//    publicRef=[SecKeyTools publicKeyFromPem:publicPath keySize:[NSData dataWithContentsOfFile:publicPath].length];
//    privateRef=[SecKeyTools privaKeyFromPem:privatePath keySize:[NSData dataWithContentsOfFile:privatePath].length];
    
    //公钥私钥字符串生成seckeyref，注意：私钥需要pkcs8转码
    publicRef=[SecKeyTools PublicKey:public_key_string];
    privateRef=[SecKeyTools PrivateKey:private_key_string_pkcs8];
}

#pragma mark - click

- (IBAction)RSAEncry:(UIButton *)sender {
  
    
    NSData *data=[Oringin_Str dataUsingEncoding:NSUTF8StringEncoding];
    NSData *enData=[data RSAEncryptWith:publicRef paddingType:RSAPaddingPKCS1];
    NSData *deData=[enData RSADecryptWith:privateRef paddingType:RSAPaddingPKCS1];
    
//    NSString *enStr=[enData base64EncodedStringWithOptions:0];
    NSString *enStr=base64_encode_data(enData);//加密后data转换成字符串的时候使用base64编码否则会为空
    NSString *deStr=[[NSString alloc]initWithData:deData encoding:NSUTF8StringEncoding];
    NSLog(@"\n原文：%@\n加密：%@\n解密：%@\n",Oringin_Str,enStr,deStr);
}

- (IBAction)AESEcry:(UIButton *)sender {
    NSData *key16 = [@"0123456789123456" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *key24 = [@"012345678901234567891234" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *key32 = [@"01234567890123456789012345678912" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *iv16 = [@"0123456789654321" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *srcData = [@"测试数据" dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",srcData);

    //用key16，和iv16加密srcData
    NSData *en16=[srcData AES_CBC_EncryptWith:key16 iv:iv16];
    //用key16，和iv16解密en16
    NSData *de16=[en16 AES_CBC_DecryptWith:key16 iv:iv16];
    
    NSLog(@"iv16...%@",srcData);
    NSLog(@"de16...%@",[[NSString alloc]initWithData:de16 encoding:NSUTF8StringEncoding]);
    
    //用key24,加密srcData
    NSData *en24ecb=[srcData AES_ECB_EncryptWith:key24];
    //用key24,解密en24ecb
    NSData *de24ecb=[en24ecb AES_ECB_DecryptWith:key24];
    
    NSLog(@"de24...%@",[[NSString alloc]initWithData:de24ecb encoding:NSUTF8StringEncoding]);

}
- (IBAction)RSASign:(UIButton *)sender {
    NSData *data=[Oringin_Str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *signData = [data signDataWith:privateRef algorithm:SEC_PKCS1SHA256];
    if (signData) {
        NSLog(@"签名成功");
        BOOL isVer=[data verifySignWith:publicRef signData:signData algorithm:SEC_PKCS1SHA256];
        if (isVer) {
            NSLog(@"签名验证成功");
        }else{
            NSLog(@"签名验证失败");
        }
    }else{
        NSLog(@"签名失败");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
