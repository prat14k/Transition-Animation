//
//  MenuController.m
//  ObjectiveTransition
//
//  Created by DEN on 07/08/17.
//  Copyright © 2017 14K. All rights reserved.
//

#import "MenuController.h"

@interface MenuController ()

@property (weak, nonatomic) IBOutlet UIButton *closeMenuBtn;

@end

@implementation MenuController
- (IBAction)closeController:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.closeMenuBtn.layer.cornerRadius = self.closeMenuBtn.frame.size.height/2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
