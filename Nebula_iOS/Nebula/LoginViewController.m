//
//  LoginViewController.m
//  成都体质
//
//  Created by Demo on 13-7-26.
//  Copyright (c) 2013年 usetc. All rights reserved.
//

#import "LoginViewController.h"
#import "myDefine.h"
#import "MainViewController.h"
#import "HandViewController.h"

#import "HistoryViewController.h"
@interface LoginViewController ()
{
    UIImageView *loadImageView;
    UIImageView *headImageView;
 
    UIImageView *penImageView;
    UIImageView *logoImageView;
    
    UIButton *shareButton;
    UIButton *historyButton;
}
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除所注册的通知
    [super dealloc];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self performSelector:@selector(setViewAnimation) withObject:nil afterDelay:0.3];
//    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];
//    NSArray *names=@[@"10",@"1000",@"12",@"21",@"23",@"25"];
//    NSArray *keys=[[dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
//    for (int i=0; i<keys.count; i++) {
//        NSDictionary *d=[dic objectForKey:[keys objectAtIndex:i]];
//        BOOL isAdd=YES;
//        for (NSString *s in names) {
//            if(![[d objectForKey:s] isEqualToString:@""]&&[d objectForKey:s]!=nil){
//                isAdd=NO;
//                break;
//            }
//        }
//        if(isAdd){
//            [dic removeObjectForKey:[keys objectAtIndex:i]];
//        }
//    }
//    NSArray *myPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *myDocPath=[myPaths objectAtIndex:0];
//    NSString *filename=[myDocPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",@"data"]];
//    [dic writeToFile:filename atomically:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//
//    NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"allDescribe" ofType:@"plist"]];
//    NSMutableString *sss=[[NSMutableString alloc] init];
//    for (NSString *key in [dic allKeys]) {
//        NSDictionary *d=[dic objectForKey:key];
//        
//        for (NSString *k in [d allKeys]) {
//            NSString *str=[d objectForKey:k];
//            [sss appendString:[NSString stringWithFormat:@"%@***",str]];
//        }
//        [sss appendString:@"\n"];
//    }
//    NSArray *myPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *myDocPath=[myPaths objectAtIndex:0];
//    NSString *filename=[myDocPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",@"describe"]];
//    [sss writeToFile:filename atomically:NO encoding:NSUTF8StringEncoding error:nil];
//    return;
    //添加背景
    UIImageView *backImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 820, 408)];
    backImageView.image=imageWithPath(@"moodback", @"jpg");
    [self.view addSubview:backImageView];
    [backImageView release];
    
    //天机logo窗口
    logoImageView=[[UIImageView alloc] initWithFrame:CGRectMake(-200, 20, 200, 100)];
    logoImageView.image=imageWithPath(@"menuButton", @"png");
    [self.view addSubview:logoImageView];
    [logoImageView release];
    
    //添加历史记录按钮
    historyButton=[[UIButton alloc] initWithFrame:CGRectMake(350, 5, 55, 1.2/0.9*50)];
    historyButton.center=CGPointMake(440, 140);
    //[historyButton setTitle:@"History" forState:UIControlStateNormal];
    [historyButton setBackgroundImage:imageWithPath(@"history", @"png") forState:UIControlStateNormal];
    historyButton.alpha=0;
    [historyButton addTarget:self action:@selector(historyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:historyButton];
    [historyButton release];
    
    UILabel *logoLab=[[UILabel alloc] initWithFrame:CGRectMake(40, 0, 190, 100)];
    logoLab.backgroundColor=[UIColor clearColor];
    logoLab.textAlignment=NSTextAlignmentCenter;
    logoLab.text=@"Nebula";
    logoLab.font=[UIFont boldSystemFontOfSize:20];
    logoLab.textColor=[UIColor whiteColor];
    logoLab.numberOfLines=0;
    [logoImageView addSubview:logoLab];
    [logoLab release];
    
    UIImageView *logo=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 70)];
    logo.image=imageWithPath(@"igem", @"png");
    logo.layer.masksToBounds=YES;
    logo.layer.cornerRadius=40;
    [logoImageView addSubview:logo];
    [logo release];
    
    //添加开始视图
	UIImage *loadImage=imageWithPath(@"menpai", @"png");
    float height=300*loadImage.size.height/loadImage.size.width;
    loadImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300,height )];
    loadImageView.image=loadImage;
    loadImageView.center=CGPointMake(468/2, -loadImageView.frame.size.height/2);
    loadImageView.userInteractionEnabled=YES;
    [self.view addSubview:loadImageView];
    
    [loadImageView release];
    
    //添加头像
    UIImage *headImage=imageWithPath(@"logo", @"png");
    headImageView=[[UIImageView alloc] initWithFrame:CGRectMake(20, height-120, 50, 50*headImage.size.height/headImage.size.width)];
    headImageView.layer.masksToBounds=YES;
    headImageView.layer.cornerRadius=25;
    headImageView.image=headImage;
    [loadImageView addSubview:headImageView];
    [headImageView release];
   
    
    //添加登录按钮
    UIImage *buttonImage=imageWithPath(@"buttonback", @"png");
    UIButton *loadButton=[[UIButton alloc] initWithFrame:CGRectMake(80, height-130, 30*buttonImage.size.width/buttonImage.size.height, 30)];
    loadButton.layer.masksToBounds=YES;
    loadButton.layer.cornerRadius=15;
    [loadButton setTitle:@"Auto Mode" forState:UIControlStateNormal];
    loadButton.titleLabel.font=[UIFont systemFontOfSize:20];
    [loadButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [loadButton addTarget:self action:@selector(loadButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [loadImageView addSubview:loadButton];
    [loadButton release];
    
    
    UIButton *handButton=[[UIButton alloc] initWithFrame:CGRectMake(80, height-80, 30*buttonImage.size.width/buttonImage.size.height, 30)];
    handButton.layer.masksToBounds=YES;
    handButton.layer.cornerRadius=15;
    [handButton setTitle:@"Manual Mode" forState:UIControlStateNormal];
    handButton.titleLabel.font=[UIFont systemFontOfSize:20];
    [handButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [handButton addTarget:self action:@selector(handButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [loadImageView addSubview:handButton];
    [handButton release];
    
    shareButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 1.2/0.9*50)];
    shareButton.alpha=0;
    shareButton.center=CGPointMake(440, 240);
    
    [shareButton setBackgroundImage:imageWithPath(@"twitter", @"png") forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
    [shareButton release];
    
    
    //添加笔图片
    UIImage *penImage=imageWithPath(@"pen", @"png");
    penImageView=[[UIImageView alloc] initWithFrame:CGRectMake(480, 50, 20, 20*penImage.size.height/penImage.size.width)];
    penImageView.image=penImage;
    //penImageView.transform=CGAffineTransformMakeRotation(M_PI_2/3);
    [self.view addSubview:penImageView];
    [penImageView release];
    
}
-(void)historyButtonClick
{
    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:historyButton cache:YES];
        historyButton.alpha=0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:shareButton cache:YES];
            shareButton.alpha=0;
        } completion:^(BOOL finished) {
            CGRect penFrame=penImageView.frame;
            penFrame.origin.x=480;
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                penImageView.frame=penFrame;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    loadImageView.center=CGPointMake(480/2, -loadImageView.frame.size.height/2);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        [logoImageView setFrame:CGRectMake(-200, 20, 200, 100)];
                    } completion:^(BOOL finished) {
                        HistoryViewController *historyVC=[[HistoryViewController alloc] init];
                        historyVC.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
                        [self presentViewController:historyVC animated:YES completion:nil];
                            [historyVC release];
                    }];
                }];
            }];
        }];
    }];
}

//开始按钮事件
-(void)loadButtonClick{
    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:historyButton cache:YES];
        historyButton.alpha=0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:shareButton cache:YES];
            shareButton.alpha=0;
        } completion:^(BOOL finished) {
            CGRect penFrame=penImageView.frame;
            penFrame.origin.x=480;
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                penImageView.frame=penFrame;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    loadImageView.center=CGPointMake(480/2, -loadImageView.frame.size.height/2);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        [logoImageView setFrame:CGRectMake(-200, 20, 200, 100)];
                    } completion:^(BOOL finished) {
                        MainViewController *mainVC=[[MainViewController alloc] init];
                        [self presentViewController:mainVC animated:YES completion:^{
                            self.view=nil;
                        }];
                        [mainVC release];
                    }];
                }];
            }];
        }];
    }];
}
-(void)handButtonClick
{
    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:historyButton cache:YES];
            historyButton.alpha=0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:shareButton cache:YES];
                shareButton.alpha=0;
        } completion:^(BOOL finished) {
            CGRect penFrame=penImageView.frame;
            penFrame.origin.x=480;
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                penImageView.frame=penFrame;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    loadImageView.center=CGPointMake(480/2, -loadImageView.frame.size.height/2);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        [logoImageView setFrame:CGRectMake(-200, 20, 200, 100)];
                    } completion:^(BOOL finished) {
                        HandViewController *handVC=[[HandViewController alloc] init];
                        [self presentViewController:handVC animated:YES completion:^{
                            self.view=nil;
                        }];
                        [handVC release];
                    }];
                }];
            }];
        }];
    }];  
}
-(void)shareButtonClick
{
    
    int currentver = [[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue];
    //ios5
    if (currentver==5 ) {
        // Set up the built-in twitter composition view controller.
        TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
        // Set the initial tweet text. See the framework for additional properties that can be set.
        [tweetViewController setInitialText:@"@I'm using Nebula to design my own sequence. Take a look!!!"];
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
        [slComposerSheet setInitialText:@"I'm using Nebula to design my own sequence. Take a look!!!"];
        [slComposerSheet addImage:[UIImage imageNamed:@"shareImage.png"]];
        [slComposerSheet addURL:[NSURL URLWithString:@"http://www.twitter.com/"]];
        if(slComposerSheet==nil){
            return;
        }
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
-(void)setViewAnimation
{
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [logoImageView setFrame:CGRectMake(10, 20, 200, 100)];
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            loadImageView.center=CGPointMake(468/2, loadImageView.frame.size.height/2-90);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                loadImageView.center=CGPointMake(468/2, loadImageView.frame.size.height/2-100);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    loadImageView.center=CGPointMake(468/2, loadImageView.frame.size.height/2-90);
                } completion:^(BOOL finished) {
                    
                    CGRect penFrame=penImageView.frame;
                    penFrame.origin.x=370;
                    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        penImageView.frame=penFrame;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.8 animations:^{
                            [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:historyButton cache:YES];
                            historyButton.alpha=1;
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.8 animations:^{
                                [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:shareButton cache:YES];
                                shareButton.alpha=1;
                            } completion:nil];
                        }];
                    }];
                }];
            }];
        }];
    }];
  
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
