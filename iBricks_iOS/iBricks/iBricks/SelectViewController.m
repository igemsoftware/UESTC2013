//
//  SelectViewController.m
//  iBricks
//
//  Created by 向 文品 on 13-8-28.
//  Copyright (c) 2013年 Demo. All rights reserved.
//

#import "SelectViewController.h"

@interface SelectViewController ()

@end

@implementation SelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(IBAction)cellClick:(UIButton *)sender
{
    
    NSUserDefaults *myUserDefaults=[NSUserDefaults standardUserDefaults];
    [myUserDefaults setInteger:sender.tag forKey:@"selectTag"];
    [myUserDefaults synchronize];
}
-(IBAction)backButtonClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
