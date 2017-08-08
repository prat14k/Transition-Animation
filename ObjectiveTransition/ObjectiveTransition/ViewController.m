//
//  ViewController.m
//  ObjectiveTransition
//
//  Created by DEN on 07/08/17.
//  Copyright © 2017 14K. All rights reserved.
//

#import "ViewController.h"
#import "CircularTransition.h"
#import "MenuController.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UIButton *menuBtn;

@property (strong, nonatomic) CircularTransition *transition;

@end

@implementation ViewController


- (CircularTransition *)transition{
    if(!_transition){
        _transition = [[CircularTransition alloc] init];
    }
    return _transition;
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    
    self.transition.transitionMode = present;
    self.transition.startingPoint = self.menuBtn.center;
    self.transition.circleColor = self.menuBtn.backgroundColor;

    return self.transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    self.transition.transitionMode = dismiss;
    self.transition.startingPoint = self.menuBtn.center;
    self.transition.circleColor = self.menuBtn.backgroundColor;
    
    return self.transition;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    MenuController *contr = segue.destinationViewController;
    contr.transitioningDelegate = self;
    contr.modalPresentationStyle = UIModalPresentationCustom;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.menuBtn.layer.cornerRadius = self.menuBtn.frame.size.height/2;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
