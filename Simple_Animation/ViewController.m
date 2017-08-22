//
//  ViewController.m
//  Simple_Animation
//
//  Created by Stafeyev Alexei on 17/08/2017.
//  Copyright © 2017 Stafeyev Alexei. All rights reserved.
//

#import "ViewController.h"
#import "NGNAnimationViewController.h"
#import "UIColor+NGNRandomColors.h"

#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIButton *firstAnimationButton;
@property (strong, nonatomic) IBOutlet UIButton *secondAnimationButton;
@property (strong, nonatomic) IBOutlet UIButton *thirdAnimationButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (UIButton *button in self.view.subviews) {
        button.layer.shadowColor = [UIColor blackColor].CGColor;
        button.layer.shadowOffset = CGSizeMake(5, 5);
        button.layer.shadowOpacity = 0.5;
        button.layer.shadowRadius = 1.0;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:3.
                          delay:0.
                        options:(UIViewAnimationOptionAutoreverse |
                                 UIViewAnimationOptionCurveEaseInOut |
                                 UIViewAnimationOptionRepeat |
                                 UIViewAnimationOptionAllowUserInteraction)
                     animations:^(){
                         self.firstAnimationButton.backgroundColor = [UIColor randomColor];
                     }
                     completion:^(BOOL finished){}];
    
    [UIView animateWithDuration:3.
                          delay:1.
                        options:(UIViewAnimationOptionAutoreverse |
                                 UIViewAnimationOptionCurveEaseInOut |
                                 UIViewAnimationOptionRepeat |
                                 UIViewAnimationOptionAllowUserInteraction)
                     animations:^(){
                         self.secondAnimationButton.backgroundColor = [UIColor randomColor];
                     }
                     completion:^(BOOL finished){}];
    
    [UIView animateWithDuration:3.
                          delay:2.
                        options:(UIViewAnimationOptionAutoreverse |
                                 UIViewAnimationOptionCurveEaseInOut |
                                 UIViewAnimationOptionRepeat |
                                 UIViewAnimationOptionAllowUserInteraction)
                     animations:^(){

                         self.thirdAnimationButton.backgroundColor = [UIColor randomColor];
                     }
                     completion:^(BOOL finished){}];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NGNAnimationViewController *destinationController = [segue destinationViewController];
    UIButton *currentSender = (UIButton *)sender;
    NSString *currentTitle = nil;
    switch (currentSender.tag) {
        case 0:
            currentTitle = @"First animation";
            destinationController.currentAnimationModule = 0;
            break;
        case 1:
            currentTitle = @"Second animation";
            destinationController.currentAnimationModule = 1;
            break;
        case 2:
            currentTitle = @"Third animation";
            destinationController.currentAnimationModule = 2;
            break;
    }
    destinationController.navigationItem.title = currentTitle;
}


@end
