//
//  CCObjectGenerateFromClassString.m
//  iweather
//
//  Created by zhengxu on 2023/1/7.
//

#import "CCObjectGenerateFromClassString.h"

@implementation CCObjectGenerateFromClassString
+ (id)createObjectGenerateFromClassString:(NSString *)classString
{
    return [[NSClassFromString(classString) alloc] init];
}

@end
