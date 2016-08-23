//
//  UIImage+ZHCMessages.m
//  ZHChat
//
//  Created by aimoke on 16/8/8.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "UIImage+ZHCMessages.h"
#import "NSBundle+ZHCMessages.h"

@implementation UIImage (ZHCMessages)

- (UIImage *)zhc_imageMaskedWithColor:(UIColor *)maskColor
{
    NSParameterAssert(maskColor != nil);
    
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextScaleCTM(context, 1.0f, -1.0f);
        CGContextTranslateCTM(context, 0.0f, -(imageRect.size.height));
        
        CGContextClipToMask(context, imageRect, self.CGImage);
        CGContextSetFillColorWithColor(context, maskColor.CGColor);
        CGContextFillRect(context, imageRect);
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)zhc_getBubbleCommpactImage
{
    return [UIImage zhc_bubbleImageFromBundleWithName:@"bubble_min"];
}


+ (UIImage *)zhc_bubbleImageFromBundleWithName:(NSString *)name
{
    NSBundle *bundle = [NSBundle zhc_getmessagesAssetBundle];
    NSAssert(bundle != Nil, @"MessagesBundle Can Not is Nil");
    NSString *path = [bundle pathForResource:name ofType:@"png" inDirectory:@"Images"];
    return [UIImage imageWithContentsOfFile:path];
}


+ (UIImage *)zhc_defaultTypingIndicatorImage
{
    return [UIImage zhc_bubbleImageFromBundleWithName:@"typing"];
}

+ (UIImage *)zhc_defaultPlayImage
{
    return [UIImage zhc_bubbleImageFromBundleWithName:@"play"];
}

+ (UIImage *)zhc_defaultPauseImage
{
    return [UIImage zhc_bubbleImageFromBundleWithName:@"pause"];
}


+ (UIImage *)zhc_defaultAccessoryImage
{
    return [UIImage zhc_bubbleImageFromBundleWithName:@"clip"];
}


@end
