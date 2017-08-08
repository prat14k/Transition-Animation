//
//  CircularTransition.m
//  ObjectiveTransition
//
//  Created by DEN on 07/08/17.
//  Copyright © 2017 14K. All rights reserved.
//

#import "CircularTransition.h"



@interface CircularTransition() <UIViewControllerAnimatedTransitioning>

@property (assign,nonatomic) double duration;
@property (strong,nonatomic) UIView *circle;

@end

@implementation CircularTransition


- (instancetype)init{
    self = [super init];
    
    self.duration = 0.5;
    self.circle = [[UIView alloc] init];
    self.transitionMode = present;
    self.circleColor = [UIColor whiteColor];
    self.startingPoint = CGPointZero;
    
    
    return self;
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *containerView = transitionContext.containerView;
    
    if(self.transitionMode == present){
        
        UIView *presentedView;
        
        if((presentedView = [transitionContext viewForKey:UITransitionContextToViewKey])){
            
            CGPoint viewCenter = presentedView.center;
            CGSize viewSize = presentedView.frame.size;
            
            self.circle = [[UIView alloc] init];
            
            self.circle.frame = [self frameForCircleWithCenter:viewCenter size:viewSize startPoint:self.startingPoint];
            
            self.circle.layer.cornerRadius = self.circle.frame.size.height/2.0;
            
            self.circle.center = self.startingPoint;
            self.circle.backgroundColor = self.circleColor;
            
            self.circle.transform = CGAffineTransformMakeScale(0.001, 0.001);
            [containerView addSubview:self.circle];
            
            presentedView.center = self.startingPoint;
            presentedView.transform = CGAffineTransformMakeScale(0.001, 0.001);
            presentedView.alpha = 0.0;
            
            [containerView addSubview:presentedView];
            
            [UIView animateWithDuration:self.duration animations:^{
                
                self.circle.transform = CGAffineTransformIdentity;
                presentedView.transform = CGAffineTransformIdentity;
                presentedView.center = viewCenter;
                presentedView.alpha = 1.0;
                
            } completion:^(BOOL finished){
                [transitionContext completeTransition:finished];
            }];
            
        }
        
    }
    else{
        UITransitionContextViewKey transitionModeKey = (self.transitionMode == pop) ? UITransitionContextToViewKey : UITransitionContextFromViewKey;
        
        UIView *returningView;
        if((returningView = [transitionContext viewForKey:transitionModeKey])){
            CGPoint viewCenter = returningView.center;
            CGSize viewSize = returningView.frame.size;
            
            self.circle.frame = [self frameForCircleWithCenter:viewCenter size:viewSize startPoint:self.startingPoint];
             
            self.circle.layer.cornerRadius = self.circle.frame.size.height/2.0;
            
            self.circle.center = self.startingPoint;
            
            [UIView animateWithDuration:self.duration animations:^{
                
                self.circle.transform = CGAffineTransformMakeScale(0.001, 0.001);
                
                returningView.transform  = CGAffineTransformMakeScale(0.001, 0.001);
                returningView.center = self.startingPoint;
                returningView.alpha = 0.0;
                
                if(self.transitionMode == pop){
                    [containerView insertSubview:returningView belowSubview:returningView];
                    [containerView insertSubview:self.circle belowSubview:returningView];
                }
                
            
            } completion:^(BOOL finished){
                returningView.center = viewCenter;
                [returningView removeFromSuperview];
                [self.circle removeFromSuperview];
                [transitionContext completeTransition:finished];
            }];
            
        }
        
        
    }
    
}


- (CGRect)frameForCircleWithCenter:(CGPoint)center size:(CGSize)size startPoint:(CGPoint)startingPoint{
    
    
    CGFloat xLength = fmax(startingPoint.x, size.width - startingPoint.x);
    CGFloat yLength = fmax(startingPoint.y, size.height - startingPoint.y);
    
    CGFloat offsetVector = sqrt(xLength*xLength + yLength*yLength)*2;
    
    return CGRectMake(CGPointZero.x, CGPointZero.y, offsetVector, offsetVector);
    
}



- (double)duration{
    if((!_duration)||(_duration == 0)){
        _duration = 0.5;
    }
    
    return _duration;
}






@end
