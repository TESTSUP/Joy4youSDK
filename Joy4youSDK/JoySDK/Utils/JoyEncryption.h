//
//  EncryptionManager.h
//  DecDemo
//
//  Created by 孙永刚 on 15/11/9.
//  Copyright © 2015年 chukong. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JoyEncryption : NSObject

//解密
+ (NSString *)DESDecryptString:(NSString *)dataStr WithKey:(NSString *)key;

//加密
+ (NSString *)DESEncryptString:(NSString *)dataStr WithKey:(NSString *)key;
+ (NSString *)DESEncryptDictionary:(NSDictionary *)param WithKey:(NSString *)key;

@end
