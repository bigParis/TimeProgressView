//
//  UIColor+hex.h
//  MakeFriends
//
//  Created by duowan on 15/4/28.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (hex)
/**
 *  使用十六进制创建颜色值
 *
 *  @param hexString 十六进制字符串  for example @"#F1F1F1" OR @"F1F1F1" OR @"000" OR @"#000"
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;
/**
 *  使用十六进制创建颜色值
 *
 *  @param hexString 十六进制字符串  for example @"#F1F1F1"
 *  @param alpha     alpha
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

/**
 *  使用0-255之间的数字创建 可以使用 RGBACOLOR 宏
 *
 *  @param red   0-255
 *  @param green 0-255
 *  @param blue  0-255
 *
 *  @return 颜色
 */
+ (UIColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;
+ (UIColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;

+ (UIColor *)colorWithValue:(UInt32)value;
+ (UIColor *)colorWithValue:(UInt32)value alpha:(CGFloat)alpha;

+ (UIColor *)colorWithNumber:(NSNumber *)value;

- (UInt32) toValue;

+ (UIColor *)colorWithARGB:(NSString *)argbString;

@end
