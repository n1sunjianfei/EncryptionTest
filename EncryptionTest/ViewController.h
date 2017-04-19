//
//  ViewController.h
//  EncryptionTest
//
//  Created by JianF.Sun on 17/4/18.
//  Copyright © 2017年 sjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Security/Security.h>
#import "SecKeyTools.h"
#import "NSData+JYRSA.h"
#import "NSData+JYSignVerify.h"
#import "NSData+JYAES.h"
@interface ViewController : UIViewController{
    SecKeyRef publicRef;
    SecKeyRef privateRef;
}


@end

