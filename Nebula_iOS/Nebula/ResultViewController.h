//
//  ResultViewController.h
//  Auto Circuit
//
//  Created by Demo on 13-7-29.
//  Copyright (c) 2013年 usetc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Twitter/Twitter.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
@interface ResultViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
{
    
    SLComposeViewController *slComposerSheet;
}
@property (nonatomic,strong) NSArray *resultArray;
@property (nonatomic,assign) BOOL isHand;
@property (nonatomic,strong) UIButton *addHistoryButton;
@end
