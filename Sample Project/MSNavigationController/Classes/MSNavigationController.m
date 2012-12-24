//
//  MSNavigationController.m
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


#import "MSNavigationController.h"
#import "MSNavigationBar.h"

@implementation MSNavigationController

#pragma mark - UINavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithNavigationBarClass:[MSNavigationBar class] toolbarClass:nil]) {

        if ([rootViewController.view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *rootScrollView = (UIScrollView *)rootViewController.view;
            rootScrollView.contentSize = CGSizeMake(200, 600);
            [rootScrollView addObserver:self
                             forKeyPath:@"contentOffset"
                                options:NSKeyValueObservingOptionOld
                                context:nil];
        }
        
        [self setViewControllers:@[rootViewController]];
    }
    return self;
}

#pragma mark - Observers

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        UIScrollView *scrollView = object;

        NSValue *oldValue = change[@"old"];
        CGPoint oldOffset = [oldValue CGPointValue];
        
        if (scrollView.contentOffset.y <= 0 && oldOffset.y > 0) {
            [(MSNavigationBar *)self.navigationBar hideShadow];
        }
        else if (scrollView.contentOffset.y > 0 && oldOffset.y <= 0) {
            [(MSNavigationBar *)self.navigationBar showShadow];
        }
    }
}

@end
