//
//  RootViewController.h
//  iBricks
//
//  Created by 向 文品 on 13-8-28.
//  Copyright (c) 2013年 Demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
@interface RootViewController : UIViewController{
    
    SLComposeViewController *slComposerSheet;
}
-(IBAction)twitterButtonClick:(id)sender;
-(IBAction)facebookButtonClick:(id)sender;
@end
