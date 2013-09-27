//
//  DetailImageViewController.m
//  Auto Circuit
//
//  Created by Demo on 13-8-6.
//  Copyright (c) 2013年 usetc. All rights reserved.
//

#import "DetailImageViewController.h"
#import "myDefine.h"
#import <QuartzCore/QuartzCore.h>
@interface DetailImageViewController ()
{
    UILabel *currentNameLab;
    UIButton *lastButton;
    UIActionSheet *detailActionSheet;
    
    
    UITextView *detailLab;
    UITextView *detailTextView;
    UILabel *detailNameLab;
}
@end

@implementation DetailImageViewController

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
    [detailActionSheet release];
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
    
    UIScrollView *dataScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(20, 40, 440, 240)];
    [self.view addSubview:dataScrollView];
    [dataScrollView release];
    
    NSDictionary  *dataDic=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"datass" ofType:@"plist"]];
	NSArray *cellArray=[self.infoStr componentsSeparatedByString:@"-"];
    NSDictionary *nameDic=[NSDictionary dictionaryWithObjects:@[@"Reporter",@"CDS",@"Generator",@"Promoter",@"RBS",@"Terminator"] forKeys:@[@"reporter",@"cds",@"gen",@"pro",@"rbs",@"ter"]];
    float posiX=0;
    float cellBorX=0;
    for (int i=0;i<cellArray.count ;i++) {
        NSDictionary *dic=[dataDic objectForKey:[cellArray objectAtIndex:i]];
        NSArray *cArray=[[dic objectForKey:@"structure"] componentsSeparatedByString:@"_"];
        for (int j=0; j<cArray.count; j++) {
            NSString *cellName=[[cArray objectAtIndex:j] lowercaseString];
            UIImage *cellImage=imageWithPath(cellName, @"png");
            UIImageView *cellImageView=[[UIImageView alloc] initWithFrame:CGRectMake(posiX, 100, 50*cellImage.size.width/cellImage.size.height, 50)];
            cellImageView.image=cellImage;
            [dataScrollView addSubview:cellImageView];
            [cellImageView release];
            
            UILabel *nameLab=[[UILabel alloc] initWithFrame:CGRectMake(posiX, 150, 50*cellImage.size.width/cellImage.size.height, 20)];
            nameLab.textColor=[UIColor whiteColor];
            nameLab.textAlignment=NSTextAlignmentCenter;
            nameLab.text=[nameDic objectForKey: cellName];
            nameLab.backgroundColor=[UIColor clearColor];
            nameLab.font=[UIFont systemFontOfSize:10];
            [dataScrollView addSubview:nameLab];
            [nameLab release];
            
            posiX+=50*cellImage.size.width/cellImage.size.height-5;
        }
        
        UIButton *borImageView=[[UIButton alloc] initWithFrame:CGRectMake(cellBorX, 90, posiX-cellBorX, 90)];
        borImageView.layer.cornerRadius=5;
        borImageView.layer.borderWidth=3;
        borImageView.layer.borderColor=[[UIColor grayColor] CGColor];
        borImageView.tag=i;
        [borImageView addTarget:self action:@selector(borButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        if(i==0){
            borImageView.layer.borderColor=[[UIColor redColor] CGColor];
            lastButton=borImageView;
        }
        [dataScrollView addSubview:borImageView];
        [borImageView release];
        
        cellBorX=posiX;
    }
    [dataScrollView setContentSize:CGSizeMake(posiX, 240)];
    
    currentNameLab=[[UILabel alloc] initWithFrame:CGRectMake(80, 50, 300, 50)];
    currentNameLab.text=[[self.infoStr componentsSeparatedByString:@"-"] objectAtIndex:lastButton.tag];
    currentNameLab.font=[UIFont boldSystemFontOfSize:40];
    currentNameLab.backgroundColor=[UIColor clearColor];
    currentNameLab.textAlignment=NSTextAlignmentCenter;
    currentNameLab.textColor=[UIColor redColor];
    currentNameLab.layer.borderColor=[[UIColor grayColor] CGColor];
    currentNameLab.layer.borderWidth=3;
    currentNameLab.layer.cornerRadius=5;
    [self.view addSubview:currentNameLab];
    [currentNameLab release];
    
    
    UIButton *viewDetailButton=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [viewDetailButton addTarget:self action:@selector(viewDetailButtonClick) forControlEvents:UIControlEventTouchUpInside];
    viewDetailButton.center=CGPointMake(380, 75);
    [self.view addSubview:viewDetailButton];
    
    
    detailActionSheet=[[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n\n" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    UIImageView *paperImageView2=[[UIImageView alloc] initWithFrame:CGRectMake(0, -5, 480, 450)];
    paperImageView2.image=imageWithPath(@"paper1", @"png");
    [detailActionSheet addSubview:paperImageView2];
    [paperImageView2 release];
    
    UIImage *cancelImage=imageWithPath(@"cancel", @"png");
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
    
  
    
}
-(void)detailButtonClick
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://parts.igem.org/wiki/index.php?title=Part:%@",detailNameLab.text]]];
}
-(void)viewDetailButtonClick
{
    
    detailNameLab.text=currentNameLab.text;
    NSDictionary *dic=[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"allDescribe" ofType:@"plist"]] objectForKey:currentNameLab.text];
    detailTextView.text=[dic objectForKey:@"sequences/seq_data"];
    detailLab.text=[dic objectForKey:@"part_short_desc"];
    [detailActionSheet showInView:self.view];
    
}
-(void)cancelButton2Click
{
    [detailActionSheet dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)borButtonClick:(UIButton *)button
{
    lastButton.layer.borderColor=[[UIColor grayColor] CGColor];
    lastButton=button;
    button.layer.borderColor=[[UIColor redColor] CGColor];
    currentNameLab.text=[[self.infoStr componentsSeparatedByString:@"-"] objectAtIndex:lastButton.tag];
    
}
-(void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
