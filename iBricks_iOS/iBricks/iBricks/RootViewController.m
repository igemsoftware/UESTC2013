//
//  RootViewController.m
//  iBricks
//
//  Created by 向 文品 on 13-8-28.
//  Copyright (c) 2013年 Demo. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIImage *image=[UIImage imageNamed:@"1.png"];
    UIImageView *headImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200*image.size.height/image.size.width)];
    headImageView.center=CGPointMake(160, 150);
    headImageView.image=image;
    [self.view addSubview:headImageView];
    
    NSMutableArray *imagesArray=[NSMutableArray array];
    for (int i=1; i<7; i++) {
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]];
        [imagesArray addObject:image];
    }
    [headImageView setAnimationImages:imagesArray];
    [headImageView setAnimationDuration:3];
    [headImageView startAnimating];

}
-(IBAction)twitterButtonClick:(id)sender
{
    int currentver = [[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue];
    //ios5
    if (currentver==5 ) {
        // Set up the built-in twitter composition view controller.
        TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
        // Set the initial tweet text. See the framework for additional properties that can be set.
        [tweetViewController setInitialText:@"I have just played iBricks. It is cool!"];
        // Create the completion handler block.
        [tweetViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
            // Dismiss the tweet composition view controller.
            [self dismissModalViewControllerAnimated:YES];
        }];
        
        // Present the tweet composition view controller modally.
        [self presentModalViewController:tweetViewController animated:YES];
        //ios6
    }else if (currentver==6) {
        //        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        //        {
        slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [slComposerSheet setInitialText:@"I have just played iBricks. It is cool!"];
        //[slComposerSheet addImage:[UIImage imageNamed:@"ios6.jpg"]];
        [slComposerSheet addURL:[NSURL URLWithString:@"http://www.twitter.com/"]];
        [self presentViewController:slComposerSheet animated:YES completion:nil];
        //        }
        
        [slComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            NSLog(@"start completion block");
            NSString *output;
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    output = @"Action Cancelled";
                    break;
                case SLComposeViewControllerResultDone:
                    output = @"Post Successfull";
                    break;
                default:
                    break;
            }
            if (result != SLComposeViewControllerResultCancelled)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter Message" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            }
        }];
        
        
        
        
        
    }else{//ios5 以下
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com"]];
    }
    
}

//分享到facebook
-(IBAction)facebookButtonClick:(id)sender {
    if ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=6) {
        //  if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        //{
        slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [slComposerSheet setInitialText:@"I have just played iBricks. It is cool!"];
        //[slComposerSheet addImage:[UIImage imageNamed:@"ios6.jpg"]];
        [slComposerSheet addURL:[NSURL URLWithString:@"http://www.facebook.com/"]];
        [self presentViewController:slComposerSheet animated:YES completion:nil];
        // }
        
        [slComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            NSLog(@"start completion block");
            NSString *output;
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    output = @"Action Cancelled";
                    break;
                case SLComposeViewControllerResultDone:
                    output = @"Post Successfull";
                    break;
                default:
                    break;
            }
            if (result != SLComposeViewControllerResultCancelled)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook Message" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            }
        }];
        
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com"]];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
