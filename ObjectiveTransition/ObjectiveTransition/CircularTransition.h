//
//  CircularTransition.h
//  ObjectiveTransition
//
//  Created by DEN on 07/08/17.
//  Copyright © 2017 14K. All rights reserved.
//

#import <UIKit/UIKit.h>

enum TransitionMode{
    present,
    dismiss,
    pop
};


@interface CircularTransition : NSObject

@property (assign,nonatomic) CGPoint startingPoint;
@property (strong,nonatomic) UIColor *circleColor;

@property (assign,nonatomic) enum TransitionMode transitionMode;
@end
