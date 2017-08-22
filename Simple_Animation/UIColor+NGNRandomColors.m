//
//  UIColor+NGNRandomColors.m
//  Simple_Animation
//
//  Created by Stafeyev Alexei on 17/08/2017.
//  Copyright © 2017 Stafeyev Alexei. All rights reserved.
//

#import "UIColor+NGNRandomColors.h"

@implementation UIColor (NGNRandomColors)

+ (UIColor *)randomColor {
    CGFloat hueRand = (arc4random() % 256 / 256.0);  //  0.0 to 1.0
    CGFloat saturationRand = (arc4random() % 128 / 256.0) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightnessRand = (arc4random() % 128 / 256.0) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hueRand saturation:saturationRand brightness:brightnessRand alpha:1];
}

@end
