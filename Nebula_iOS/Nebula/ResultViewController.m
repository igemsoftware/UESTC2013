//
//  ResultViewController.m
//  Auto Circuit
//
//  Created by Demo on 13-7-29.
//  Copyright (c) 2013年 usetc. All rights reserved.
//

#import "ResultViewController.h"
#import "ResultDataView.h"
#import "myDefine.h"
#import "DetailImageViewController.h"
@interface ResultViewController ()
{
    UIScrollView *dataScrollView;
    NSMutableArray *selectArray;
    UIActionSheet *selectActionSheet;
    UIActionSheet *detailActionSheet;
    NSMutableArray *terminatorArray;
    NSMutableArray *numArray;
    NSMutableArray *numLabArray;
    
    UITextView *detailLab;
    UITextView *detailTextView;
    UILabel *detailNameLab;

    UIImageView *shareImageView;
}
@end

@implementation ResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)dealloc
{
    self.resultArray=nil;
    [selectActionSheet release];
    [detailActionSheet release];
    [selectArray release];
    [terminatorArray release];

    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    terminatorArray=[[NSMutableArray alloc] init];
	//添加背景
    UIImageView *backImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
    backImageView.image=imageWithPath(@"huaban", @"png");
    [self.view addSubview:backImageView];
    [backImageView release];
    
    shareImageView=[[UIImageView alloc] initWithFrame:CGRectMake(30, 30,0,0)];
    
    [self.view addSubview:shareImageView];
    [shareImageView release];
    //添加返回按钮
    UIImage *backImage=imageWithPath(@"backButton", @"png");
    UIButton *backButton=[[UIButton alloc ] initWithFrame:CGRectMake(5, 0, 25*backImage.size.width/backImage.size.height, 25)];
    [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
    [backButton addTarget: self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton release];
    
    
    
    //添加路径图片
    dataScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(20, 30, 440, 300-40)];
    //dataScrollView.backgroundColor=[UIColor grayColor];
    dataScrollView.pagingEnabled=YES;
    //dataScrollView.clipsToBounds=NO;
    [self.view addSubview:dataScrollView];
    [dataScrollView release];
    NSLog(@"%@",self.resultArray);
    NSDictionary *datas=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];
   
    selectArray=[[NSMutableArray alloc] init];
    NSArray *keys=[datas allKeys];
    for (NSString *key in keys) {
        if([[[[[[datas objectForKey:key] objectForKey:@"type"] componentsSeparatedByString:@"_"] objectAtIndex:0] uppercaseString] isEqualToString:[@"terminator" uppercaseString]]){
            [selectArray addObject:[datas objectForKey:key]];
        }
    }
    numArray=[[NSMutableArray alloc] init];
    numLabArray=[[NSMutableArray alloc] init];
    for (int i=0; i<self.resultArray.count; i++) {

        UIScrollView *bodyScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(440*i, 20, 440, 300-50)];
       // [bodyScrollView setBackgroundColor:[UIColor grayColor]];
        [dataScrollView addSubview:bodyScrollView];
        bodyScrollView.clipsToBounds=NO;
        [bodyScrollView release];
        
        
        float posiX=62.5;
        float posiY=45;
        NSArray *sArray=[[self.resultArray objectAtIndex:i] componentsSeparatedByString:@"-"];
        float num=0;
        BOOL isForward=YES;
        
        for (NSString *str in sArray) {
            
            NSLog(@"%f",posiX);
            NSString *type=[[[[datas objectForKey:str] objectForKey:@"type"] componentsSeparatedByString:@"_"] objectAtIndex:0];
            ResultDataView *resultV=[[ResultDataView alloc] init];
            NSString *imageName=[NSString stringWithFormat:@"%@mini",[type lowercaseString]];
            resultV.headImageView.image=imageWithPath(imageName, @"png");
            resultV.center=CGPointMake(posiX, posiY);
            resultV.clipsToBounds=NO;
            resultV.nameLab.text=[NSString stringWithFormat:@"%@\n%@",str,type];
            [bodyScrollView addSubview:resultV];
            [resultV release];
            

            if (isForward) {
                if(posiX<377.5){
                    resultV.rightLab.alpha=1;
                    posiX+=105;
                }else{
                    resultV.bottomLab.alpha=1;
                    isForward=NO;
                    posiY+=80;
                }
                
            }else{
                if(posiX>62.5){
                    resultV.LeftLab.alpha=1;
                    posiX-=105;
                }else{
                    resultV.bottomLab.alpha=1;
                    isForward=YES;
                    posiY+=80;
                }
            }
            float a1=[[[datas objectForKey:str] objectForKey:@"scores"] floatValue];
            num+=log10f(a1);
            if(self.isHand){
                if([str isEqualToString:[sArray lastObject]]){
                    resultV.LeftLab.alpha=0;
                    resultV.rightLab.alpha=0;
                    resultV.bottomLab.alpha=0;
                }
            }
            
        }
        [numArray addObject:[NSNumber numberWithFloat:num]];
        if(self.isHand){
            
        }else{
            ResultDataView *resultV=[[ResultDataView alloc] init];
           resultV.headImageView.image=imageWithPath(@"terminatormini", @"png");
            resultV.center=CGPointMake(posiX, posiY);
            resultV.clipsToBounds=NO;
            resultV.nameLab.text=@"terminator\nclick to select";
            [bodyScrollView addSubview:resultV];
            
            [resultV release];
            [terminatorArray addObject:resultV];
        
            CGRect frame=resultV.frame;
            frame.size.width=100;
            resultV.frame=frame;
        
            UIButton *terButton=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [terButton addTarget:self action:@selector(terButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            terButton.center=CGPointMake(85, 25);
            [resultV addSubview:terButton];
        
        }
        [bodyScrollView setContentSize:CGSizeMake(440, posiY+60)];
        
        
        UILabel *numLab=[[UILabel alloc] initWithFrame:CGRectMake(0, -15, 240, 30)];
        numLab.textColor=[UIColor redColor];
        numLab.font=[UIFont boldSystemFontOfSize:17];
        numLab.backgroundColor=[UIColor clearColor];
        numLab.textAlignment=NSTextAlignmentLeft;
        numLab.text=[NSString stringWithFormat:@"Index of Stability:%.2f",-1/num];;
        [bodyScrollView addSubview:numLab];
        [numLab release];
        [numLabArray addObject:numLab];
    }
    
    [dataScrollView setContentSize:CGSizeMake(440*self.resultArray.count,240)];
    //添加选择区域
    selectActionSheet=[[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n\n" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    UIImageView *paperImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, -5, 480, 450)];
    paperImageView.image=imageWithPath(@"paper1", @"png");
    [selectActionSheet addSubview:paperImageView];
    [paperImageView release];
    
    //添加data列表
    UITableView *dataTableView=[[UITableView alloc] initWithFrame:CGRectMake(20, 50, 440, 205)];
    dataTableView.delegate=self;
    dataTableView.dataSource=self;
    dataTableView.backgroundColor=[UIColor clearColor];
    dataTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [selectActionSheet addSubview:dataTableView];
    [dataTableView release];
    
    UIImage *cancelImage=imageWithPath(@"cancel", @"png");
    UIButton *cancelButton=[[UIButton alloc] initWithFrame:CGRectMake(405, 5, 50, 50*cancelImage.size.height/cancelImage.size.width)];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setBackgroundImage:cancelImage forState:UIControlStateNormal];
    [selectActionSheet addSubview:cancelButton];
    [cancelButton release];
    
    
    detailActionSheet=[[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n\n" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    UIImageView *paperImageView2=[[UIImageView alloc] initWithFrame:CGRectMake(0, -5, 480, 450)];
    paperImageView2.image=imageWithPath(@"paper1", @"png");
    [detailActionSheet addSubview:paperImageView2];
    [paperImageView2 release];
    
    
    UIButton *cancelButton2=[[UIButton alloc] initWithFrame:CGRectMake(405, 5, 50, 50*cancelImage.size.height/cancelImage.size.width)];
    [cancelButton2 addTarget:self action:@selector(cancelButton2Click) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton2 setBackgroundImage:cancelImage forState:UIControlStateNormal];
    
    [detailActionSheet addSubview:cancelButton2];
    [cancelButton2 release];
    
    detailNameLab=[[UILabel alloc] initWithFrame:CGRectMake(130, 20, 320, 50)];
    detailNameLab.textAlignment=NSTextAlignmentCenter;
    detailNameLab.center=CGPointMake(240, 50);
    detailNameLab.numberOfLines=0;
    detailNameLab.font=[UIFont systemFontOfSize:30];
    detailNameLab.backgroundColor=[UIColor clearColor];
    [detailActionSheet addSubview:detailNameLab];
    [detailNameLab release];
    
    detailLab=[[UITextView alloc] initWithFrame:CGRectMake(30, 65, 420, 50)];
    detailLab.font=[UIFont systemFontOfSize:15];
    detailLab.backgroundColor=[UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.2];
    detailLab.layer.cornerRadius=5;
    detailLab.editable=NO;
    [detailActionSheet addSubview:detailLab];
    [detailLab release];
    
    detailTextView=[[UITextView alloc] initWithFrame:CGRectMake(30, 120, 420, 130)];
    detailTextView.backgroundColor=[UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.2];
    detailTextView.layer.cornerRadius=5;
    detailTextView.font=[UIFont systemFontOfSize:15];
    detailTextView.editable=NO;
    [detailActionSheet addSubview:detailTextView];
    [detailTextView release];
    
    UIButton *detailButton=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [detailButton addTarget:self action:@selector(detailButtonClick) forControlEvents:UIControlEventTouchUpInside];
    detailButton.center=CGPointMake(460, 230);
    [detailActionSheet addSubview:detailButton];
    
    
    UIButton *moreButton=[[UIButton alloc] initWithFrame:CGRectMake(380, 0, 100, 30)];
    [moreButton setTitle:@"Detail" forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
    moreButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    [self.view addSubview:moreButton];
    [moreButton release];
    
    
    self.addHistoryButton=[UIButton buttonWithType:UIButtonTypeContactAdd];
    self.addHistoryButton.center=CGPointMake(30, 280);
    [self.addHistoryButton addTarget:self action:@selector(addHistoryButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addHistoryButton];
}
//截取当前屏幕
-(UIImage *) imageFromViewandRcct:(CGRect) rect
{
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(void)addHistoryButtonClick
{
    
    if(!self.isHand){
        
        NSString *addStr=[[[[[terminatorArray objectAtIndex:dataScrollView.contentOffset.x/440] nameLab] text] componentsSeparatedByString:@"\n"] objectAtIndex:0];
        if([addStr isEqualToString:@"terminator"]){
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Haven't selected a terminator" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            [alert release];
            return;
        }
    }
    shareImageView.image=[self imageFromViewandRcct:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    UIActionSheet *shearSheet=[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Share To Twitter",@"Add History List", nil];
    [shearSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [self shareButtonClick];
    
    }else if(buttonIndex==1){
        NSArray *myPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *myDocPath=[myPaths objectAtIndex:0];
        NSString *filename=[myDocPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",@"historydata"]];
        NSMutableArray *dataDic=[NSMutableArray arrayWithContentsOfFile:filename];
        if(dataDic==nil){
            dataDic=[NSMutableArray array];
        }
        NSMutableDictionary *dic=[[[NSMutableDictionary alloc] init] autorelease];
        NSDate *date=[NSDate date];
        NSCalendar *calendar=[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
        //NSDateComponents *comps=[[[NSDateComponents alloc] init] autorelease];
        NSInteger unitFlags=NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
        NSDateComponents *comps=[calendar components:unitFlags fromDate:date];
        [dic setValue:[NSString stringWithFormat:@"%d",[comps year]] forKey:@"year"];
        [dic setValue:[NSString stringWithFormat:@"%d",[comps week]] forKey:@"week"];
        [dic setValue:[NSString stringWithFormat:@"%d",[comps month]] forKey:@"month"];
        [dic setValue:[NSString stringWithFormat:@"%d",[comps day]] forKey:@"day"];
        [dic setValue:[NSString stringWithFormat:@"%d",[comps year]] forKey:@"year"];
       
        if(self.isHand){
            [dic setValue:[self.resultArray objectAtIndex:dataScrollView.contentOffset.x/440] forKey:@"data"];
        }else{
            NSString *addStr=[[[[[terminatorArray objectAtIndex:dataScrollView.contentOffset.x/440] nameLab] text] componentsSeparatedByString:@"\n"] objectAtIndex:0];
            [dic setValue:[NSString stringWithFormat:@"%@-%@",[self.resultArray objectAtIndex:dataScrollView.contentOffset.x/440],addStr] forKey:@"data"];
        }
        [dataDic addObject:dic];
        [dataDic writeToFile:filename atomically:YES];
      
    }
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
        [slComposerSheet addImage:shareImageView.image];
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
-(void)moreButtonClick
{
    int index=dataScrollView.contentOffset.x/440;
    DetailImageViewController *detailVC=[[[DetailImageViewController alloc] init] autorelease];
    if(self.isHand){
        detailVC.infoStr=[self.resultArray objectAtIndex:index];
        detailVC.isHand=YES;
    }else{
        NSString *addStr=[[[[[terminatorArray objectAtIndex:dataScrollView.contentOffset.x/440] nameLab] text] componentsSeparatedByString:@"\n"] objectAtIndex:0];
        if([addStr isEqualToString:@"terminator"]){
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Haven't selected a terminator" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            [alert release];
            return;
        }
        detailVC.infoStr=[NSString stringWithFormat:@"%@-%@",[self.resultArray objectAtIndex:index],addStr];
        detailVC.isHand=NO;
    }
    detailVC.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:detailVC animated:YES completion:nil];
}
-(void)terButtonClick:(UIButton *)button
{
    
    [selectActionSheet showInView:self.view];
}
-(void)cancelButtonClick
{
    [selectActionSheet dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)cancelButton2Click
{
    [detailActionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [selectArray count];
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"allDescribe" ofType:@"plist"]] objectForKey:[[selectArray objectAtIndex:indexPath.row] objectForKey:@"ID"]];
    detailNameLab.text=[[selectArray objectAtIndex:indexPath.row] objectForKey:@"ID"];
    detailTextView.text=[dic objectForKey:@"sequences/seq_data"];
    detailLab.text=[dic objectForKey:@"part_short_desc"];
    
    [detailActionSheet showInView:self.view];
}
-(void)detailButtonClick
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://parts.igem.org/wiki/index.php?title=Part:%@",detailNameLab.text]]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *Cell=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Cell];
    if(cell==nil){
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Cell] autorelease];
        
    }
    cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    cell.selectionStyle=UITableViewCellEditingStyleNone;
    NSDictionary *dic=[selectArray objectAtIndex:indexPath.row];
    cell.textLabel.text=[dic objectForKey:@"ID"];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"scores:%@",[dic objectForKey:@"scores"]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResultDataView *resultV=[terminatorArray objectAtIndex:dataScrollView.contentOffset.x/440];
    NSDictionary *dic=[selectArray objectAtIndex:indexPath.row];
    int index=dataScrollView.contentOffset.x/440;
    resultV.nameLab.text=[NSString stringWithFormat:@"%@\n%@",[dic objectForKey:@"ID"],[[[dic objectForKey:@"type"] componentsSeparatedByString:@"_"] objectAtIndex:0]];
    float lastNum=[[numArray objectAtIndex:index] floatValue];
    UILabel *currentLab=[numLabArray objectAtIndex:index];
    float currentNum=-1/(lastNum+log10f([[dic objectForKey:@"scores"] floatValue]));
    currentLab.text=[NSString stringWithFormat:@"Index of Stability:%.2f",currentNum];
    [selectActionSheet dismissWithClickedButtonIndex:0 animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
