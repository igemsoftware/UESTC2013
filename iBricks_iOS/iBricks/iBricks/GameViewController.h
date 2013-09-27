//
//  GameViewController.h
//  iBricks
//
//  Created by 向 文品 on 13-8-29.
//  Copyright (c) 2013年 Demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VirusImageView.h"
@interface GameViewController : UIViewController<UIAlertViewDelegate,VirusCutLifePower>
@property (nonatomic,strong) IBOutlet UIImageView *cellImageView;
@property (nonatomic,strong) IBOutlet UILabel *bloodLab;
@property (nonatomic,strong) IBOutlet UILabel *clockLab;
@property (nonatomic,strong) IBOutlet UILabel *magicLab;
@property (nonatomic,strong) IBOutlet UILabel *scoreLab;
-(IBAction)backButtonClick:(id)sender;
-(IBAction)usePower:(id)sender;
-(IBAction)reStart:(id)sender;
@end
