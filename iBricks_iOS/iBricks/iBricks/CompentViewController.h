//
//  CompentViewController.h
//  iBricks
//
//  Created by 向 文品 on 13-8-29.
//  Copyright (c) 2013年 Demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) IBOutlet UILabel *bloodLab;
@property (nonatomic,strong) IBOutlet UILabel *clockLab;
@property (nonatomic,strong) IBOutlet UILabel *magicLab;
@property (nonatomic,strong) IBOutlet UITableView *dataTableView;
-(IBAction)backButtonClick:(id)sender;
-(IBAction)cellButtonClick:(UIButton *)sender;

@end
