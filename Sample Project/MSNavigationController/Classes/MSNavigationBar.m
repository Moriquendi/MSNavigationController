//
//  MSNavigationBar.m
//  MSNavigationController
//
//  Created by Michał Śmiałko on 23.12.2012.
//  Copyright (c) 2012 MS. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following
// conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//

#import "MSNavigationBar.h"
#import <QuartzCore/QuartzCore.h>

NSString *kAnimFadeIn = @"AnimFadeIn";
NSString *kAnimFadeOut = @"AnimFadeOut";

@interface MSNavigationBar ()

@property (nonatomic, strong) CAGradientLayer *shadowLayer;
@property (nonatomic, strong) UIColor *gradientStartColor;
@property (nonatomic, strong) UIColor *gradientEndColor;

@end

@implementation MSNavigationBar

#pragma mark - UIView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Draw gradient
    [self drawLinearGradientInContext:context
                               inRect:rect
                           startColor:[self.gradientStartColor CGColor]
                             endColor:[self.gradientEndColor CGColor]];
    
    // Update shadow frame
    CGRect shadowFrame = self.layer.frame;
    shadowFrame.origin.y = self.layer.frame.size.height;
    shadowFrame.size.height = 5;
    self.shadowLayer.frame = shadowFrame;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Load shadow layer
        self.shadowLayer = [[CAGradientLayer alloc] init];
        self.shadowLayer.colors = @[(id)[[UIColor lightGrayColor] CGColor],
                                    (id)[[UIColor clearColor] CGColor]];
        self.shadowLayer.startPoint = CGPointMake(0, -3); // TODO: Stupid hack. Figure why even if start point is (0,0), gradient is "both-sided"
        self.shadowLayer.endPoint = CGPointMake(0, 1);
        self.shadowLayer.opacity = 0.0;
        
        [self.layer addSublayer:self.shadowLayer];
        
        // Cache colors
        self.gradientStartColor = [UIColor colorWithRed:225./255.
                                                  green:225./255.
                                                   blue:225./255.
                                                  alpha:1.0];
        self.gradientEndColor = [UIColor colorWithRed:200./255.
                                                green:200./255.
                                                 blue:200./255.
                                                alpha:1.0];
    }
    return self;
}

#pragma mark - MSNavigationBar

- (void)showShadow
{
    [self animateShadowWithAnimationType:kAnimFadeIn];
}

- (void)hideShadow
{
    [self animateShadowWithAnimationType:kAnimFadeOut];
}

- (void)animateShadowWithAnimationType:(NSString *)animationType
{
    // First, checks if animation is already running
    __block BOOL animationInProgress = NO;
    [self.shadowLayer.animationKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isEqualToString:animationType]) {
            animationInProgress = YES;
        }
    }];
    
    CGFloat toValue = [animationType isEqualToString:kAnimFadeIn] ? 1.0 : 0.0;
    
    if (animationInProgress == YES || self.shadowLayer.opacity == toValue) {
        return; // Animation is already running, or there's nothing to animate
    }
    
    // Start fade in/out animation
    [self.shadowLayer removeAllAnimations];
    CABasicAnimation *basicAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    basicAnim.fromValue = @(self.shadowLayer.opacity);
    basicAnim.toValue = @(toValue);
    basicAnim.duration = 0.2;
    self.shadowLayer.opacity = toValue;
    [self.shadowLayer addAnimation:basicAnim forKey:animationType];
}

#pragma mark - Drawing helps methods

- (void)drawLinearGradientInContext:(CGContextRef) context
                             inRect:(CGRect)rect
                         startColor:(CGColorRef)startColor
                           endColor:(CGColorRef)endColor
{
    // Thanks Ray wenderlich
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = [NSArray arrayWithObjects:(__bridge id)startColor, (__bridge id)endColor, nil];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,
                                                        (__bridge CFArrayRef) colors, locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

@end
