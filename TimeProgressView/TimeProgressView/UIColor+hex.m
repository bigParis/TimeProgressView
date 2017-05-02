//
//  UIColor+hex.m
//  MakeFriends
//
//  Created by duowan on 15/4/28.
//
//

#import "UIColor+hex.h"

@implementation UIColor (hex)

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    return [[self class] colorWithHexString:hexString alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    
    if('#' != [hexString characterAtIndex:0]) {
        hexString          = [NSString stringWithFormat:@"#%@", hexString];
    }
    
//    assert(7 == hexString.length || 4 == hexString.length);
    
    hexString          = [[self class] hexStringTransformFromThreeCharacters:hexString];
    
    NSString *redHex   = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(1, 2)]];
    unsigned redInt    = [[self class] hexValueToUnsigned:redHex];
    
    NSString *greenHex = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(3, 2)]];
    unsigned greenInt  = [[self class] hexValueToUnsigned:greenHex];
    
    NSString *blueHex  = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(5, 2)]];
    unsigned blueInt   = [[self class] hexValueToUnsigned:blueHex];
    
    UIColor *color     = [UIColor colorWith8BitRed:redInt green:greenInt blue:blueInt alpha:alpha];
    
    return color;
}

+ (UIColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue {
    return [[self class] colorWith8BitRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha {
    
    UIColor *color = [UIColor colorWithRed:(float)red/255 green:(float)green/255 blue:(float)blue/255 alpha:alpha];
    return color;
}

+ (NSString *)hexStringTransformFromThreeCharacters:(NSString *)hexString {
    if(hexString.length == 4) {
        hexString = [NSString stringWithFormat:@"#%@%@%@%@%@%@",
                     [hexString substringWithRange:NSMakeRange(1, 1)],[hexString substringWithRange:NSMakeRange(1, 1)],
                     [hexString substringWithRange:NSMakeRange(2, 1)],[hexString substringWithRange:NSMakeRange(2, 1)],
                     [hexString substringWithRange:NSMakeRange(3, 1)],[hexString substringWithRange:NSMakeRange(3, 1)]];
    }
    
    return hexString;
}

+ (unsigned)hexValueToUnsigned:(NSString *)hexValue {
    unsigned value = 0;
    
    NSScanner *hexValueScanner = [NSScanner scannerWithString:hexValue];
    [hexValueScanner scanHexInt:&value];
    
    return value;
}

+ (UIColor*) colorWithValue:(UInt32)value {
    return [UIColor colorWithValue:value alpha:1.0f];
}

+ (UIColor *)colorWithValue:(UInt32)value alpha:(CGFloat)alpha
{
    UInt8 *val = (UInt8 *)&value;
    return [UIColor colorWithRed:*(val+2)/ 255.0 green:*(val+1)/255.0 blue:*(val)/255.0 alpha:alpha];
}

+ (UIColor *)colorWithNumber:(NSNumber *)value
{
    long b = value.unsignedIntValue % 256;
    long g = value.unsignedIntValue / 256 % 256;
    long r = value.unsignedIntValue / 256 / 256 % 256;
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}
- (UInt32) toValue {
    const CGFloat* reds = CGColorGetComponents(self.CGColor);
    if (CGColorGetNumberOfComponents(self.CGColor) >= 4) {
        UInt8 r = reds[0] * 255;
        UInt8 g = reds[1] * 255;
        UInt8 b = reds[2] * 255;
        UInt8 a = reds[3] * 255;
        
        UInt32 value = 0;
        UInt8 *val = (UInt8*)&value;
        *val = b;
        *(val+1) = g;
        *(val+2) = r;
        *(val+3) = a;

        return value;
    }
    return 0;
}

+ (UIColor *)colorWithARGB:(NSString *)argbString
{
    if(argbString.length == 8){
        
        NSString *aplhaString = [argbString substringWithRange:NSMakeRange(0, 2)];
        NSString *colorString = [argbString substringWithRange:NSMakeRange(2, 6)];
   
        NSString *aplhaHex  = [NSString stringWithFormat:@"0x%@", aplhaString];
        unsigned aplhaInt   = [[self class] hexValueToUnsigned:aplhaHex];

        CGFloat aplha = aplhaInt % 255;
        return [UIColor colorWithHexString:colorString alpha:aplha];
    }
    
    return [UIColor colorWithHexString:argbString];
}


@end
