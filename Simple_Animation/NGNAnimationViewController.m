//
//  NGNAnimationViewController.m
//  Simple_Animation
//
//  Created by Stafeyev Alexei on 17/08/2017.
//  Copyright © 2017 Stafeyev Alexei. All rights reserved.
//

#import "NGNAnimationViewController.h"
#import <DCAnimationKit/UIView+DCAnimationKit.h>

#import <QuartzCore/QuartzCore.h>


@interface NGNAnimationViewController ()

@property (assign, nonatomic, getter=isAnimating) BOOL animating;

@property (strong, nonatomic) IBOutlet UIButton *animationButton;
@property (strong, nonatomic) IBOutlet UILabel *animationlabel;

@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIGravityBehavior *gravity;
@property (strong, nonatomic) UICollisionBehavior *collider;

- (IBAction)animationButtonTapped:(UIButton *)sender;

@end

@implementation NGNAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backArrow"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(back:)];
    back.tintColor = [UIColor blackColor];
    [self.navigationItem setLeftBarButtonItem:back];
    
    self.animationButton.layer.borderWidth = 2;
    self.animationButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    self.gravity = [[UIGravityBehavior alloc] init];
    self.gravity.magnitude = 0.8;
    self.collider = [[UICollisionBehavior alloc] init];
    self.collider.translatesReferenceBoundsIntoBoundary = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.3
                          delay:0
                        options:0
                     animations:^(){
                         [self.animationlabel snapIntoView:self.view direction:DCAnimationDirectionTop];
                         [self.animationButton snapIntoView:self.view direction:DCAnimationDirectionLeft];
                     }
                     completion:^(BOOL finished){}];
}

- (IBAction)animationButtonTapped:(UIButton *)sender {
        
        switch (self.currentAnimationModule) {

            case 0:{
                if (!self.isAnimating) {
                    [UIView animateWithDuration:3.
                                          delay:0
                                        options:(UIViewAnimationOptionAutoreverse |
                                                 UIViewAnimationOptionCurveEaseInOut |
                                                 UIViewAnimationOptionRepeat |
                                                 UIViewAnimationOptionAllowUserInteraction)
                                     animations:^(){
                                         sender.alpha = 0.;
                                     }
                                     completion:^(BOOL finished){}];
                    
                    [self runSpinAnimationOnView:self.animationlabel duration:6. rotations:1 repeat:1];
                    self.animating = YES;
                }
            }
                break;
            case 1:{
                [UIView animateWithDuration:0.5
                                      delay:0
                                    options:(UIViewAnimationOptionAllowUserInteraction)
                                 animations:^(){
                                     [self.animationlabel bounce:NULL];
                                     [self.animationButton tada:NULL];
                                 }
                                 completion:^(BOOL finished){}];
            }
                break;
                
            case 2:{
                UIDynamicItemBehavior *basicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.animationButton, self.animationlabel]];
                basicBehavior.density = 0.6;
                basicBehavior.elasticity = 0.8;
                [self.animator addBehavior:basicBehavior];
                
                [self.animator addBehavior:self.gravity];
                [self.gravity addItem:self.animationButton];
                [self.gravity addItem:self.animationlabel];
                
                [self.animator addBehavior:self.collider];
                [self.collider addItem:self.animationButton];
                [self.collider addItem:self.animationlabel];
            }
                break;
                
        }
        

}

- (IBAction) back:(id)sender {
    if (self.currentAnimationModule != 2) {
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^(){
                             [self.animationlabel hinge:NULL];
                             [self.animationButton hinge:NULL];
                         }
                         completion:^(BOOL finished){
                             
                         }];
    }

    [UIView animateWithDuration:0.3
                          delay:0.3
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^(){
                         if (self.currentAnimationModule != 2) {
                             self.animationlabel.center = CGPointMake(CGRectGetMaxX(self.animationlabel.bounds), self.view.bounds.size.height);
                             self.animationButton.center = CGPointMake(CGRectGetMaxX(self.animationButton.bounds), self.view.bounds.size.height);
                         }
                     }
                     completion:^(BOOL finished){
                         [UIView transitionWithView:self.navigationController.view
                                           duration:1
                                            options:(UIViewAnimationOptionTransitionCurlUp | UIViewAnimationOptionShowHideTransitionViews)
                                         animations:^{}
                                         completion:^(BOOL finished){
                                             [self.navigationController popViewControllerAnimated:NO];
                                         }];
                     }];
}

- (void)runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat ? HUGE_VALF : 0;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end
