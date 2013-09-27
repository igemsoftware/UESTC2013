//
//  HistoryViewController.m
//  Auto Circuit
//
//  Created by igem on 8/7/13.
//  Copyright (c) 2013 usetc. All rights reserved.
//

#import "HistoryViewController.h"
#import "myDefine.h"
#import "HistoryCell.h"
#import <QuartzCore/QuartzCore.h>
#import "ResultViewController.h"
@interface HistoryViewController ()
{
    NSArray *dataDic;
}
@end

@implementation HistoryViewController

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
    [dataDic release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    //添加背景
    UIImageView *backImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 350)];
    backImageView.image=imageWithPath(@"huaban", @"png");
    [self.view addSubview:backImageView];
    [backImageView release];
    //添加返回按钮
    UIImage *backImage=imageWithPath(@"backButton", @"png");
    UIButton *backButton=[[UIButton alloc ] initWithFrame:CGRectMake(5, 0, 25*backImage.size.width/backImage.size.height, 25)];
    [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
    [backButton addTarget: self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton release];
    
    
    NSArray *myPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *myDocPath=[myPaths objectAtIndex:0];
    NSString *filename=[myDocPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",@"historydata"]];
    dataDic=[[NSArray alloc] initWithContentsOfFile:filename];
    
    
    
    if (dataDic==nil) {
        dataDic=[[NSArray alloc] init];
    }
    
    UITableView *dataTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 50, 480, 250)];
    dataTableView.delegate=self;
    dataTableView.dataSource=self;
    [dataTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    dataTableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:dataTableView];
    [dataTableView release];
}
-(void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataDic count]+1;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==[dataDic count]){
        return 250;
    }else{
        return 150;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *Cell;
    
    if(indexPath.row==[dataDic count]){
        Cell=@"LastCell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Cell];
        if(cell==nil){
            cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell] autorelease];
            UILabel *imView=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 250)];
            imView.layer.borderWidth=1;
            imView.layer.borderColor=[[UIColor blackColor] CGColor];
            imView.layer.cornerRadius=75;
            //imView.textColor=[UIColor whiteColor];
            imView.textAlignment=NSTextAlignmentCenter;
            imView.text=@"Nebula";
            imView.font=[UIFont boldSystemFontOfSize:30];
            imView.center=CGPointMake(240, 125);
            imView.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:imView];
            [imView release];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        Cell=@"Cell";
        HistoryCell *cell=[tableView dequeueReusableCellWithIdentifier:Cell];
        if(cell==nil){
            cell=[[[HistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell] autorelease];
        }
        NSDictionary *dic=[dataDic objectAtIndex:indexPath.row];
        CGRect frame=cell.bodyLab.frame;
        CGRect treeFrame=cell.treeImageView.frame;
        if(indexPath.row%2==0){
            frame.origin.x=20;
            treeFrame.origin.x=240-75;
        }else{
            frame.origin.x=315;
            treeFrame.origin.x=315-20;
        }
        cell.bodyLab.frame=frame;
        cell.treeImageView.frame=treeFrame;
        cell.titleLab.text=[NSString stringWithFormat:@"%@.%@\n%@",[dic objectForKey:@"year"],[dic objectForKey:@"month"],[dic objectForKey:@"day"]];
        cell.bodyLab.text=[dic objectForKey:@"data"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResultViewController *resultVC=[[ResultViewController alloc] init];
    resultVC.resultArray=@[[[dataDic objectAtIndex:indexPath.row] objectForKey:@"data"]];
    resultVC.isHand=YES;
    
    [self presentViewController:resultVC animated:YES completion:nil];
    resultVC.addHistoryButton.alpha=0;
    [resultVC release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
