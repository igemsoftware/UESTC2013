//
//  MainViewController.m
//  Auto Circuit
//
//  Created by Demo on 13-7-28.
//  Copyright (c) 2013年 usetc. All rights reserved.
//

#import "MainViewController.h"
#import "ResultViewController.h"
#import "myDefine.h"


@interface MainViewController ()
{
    UILabel *inputLab;
    UILabel *outputLab;
    UIImageView *macImageView;
    UITableView *dataTableView;
    NSString *currentCell;
    UIActionSheet *selectActionSheet;
    UIActivityIndicatorView *codeActivity;
    NSTimer *timer;
    
    UIImageView *keyboardImageView;
    BOOL isOut;
    NSDictionary *inArray;
    NSDictionary *outArray;
    
    NSMutableArray *inResultArray;
    NSMutableArray *outResultArray;
    NSArray *lastResultArray;
    NSMutableArray *resultArray;
}
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)dealloc{
    [selectActionSheet release];
    [inArray release];
    [outArray release];
    [inResultArray release];
    [outResultArray release];
    [resultArray release];
    [super dealloc];
}
-(void)viewDidAppear:(BOOL)animated
{
    CGRect frame=keyboardImageView.frame;
    frame.origin.x=130;
    [UIView animateWithDuration:0.5 animations:^{
        keyboardImageView.frame=frame;
    }];
    self.view.userInteractionEnabled=YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    isOut=YES;
    self.view.clipsToBounds=YES;
    inResultArray=[[NSMutableArray alloc] init];
    outResultArray=[[NSMutableArray alloc] init];
    resultArray=[[NSMutableArray alloc] init];
    inArray=[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"input+" ofType:@"plist"]];
    outArray=[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"output" ofType:@"plist"]];
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
    
    
    //添加工作区域
    inputLab=[[UILabel alloc] initWithFrame:CGRectMake(20, 120, 100, 60)];
    inputLab.textAlignment=NSTextAlignmentCenter;
    inputLab.text=@"input";
    inputLab.layer.masksToBounds=YES;
    inputLab.layer.borderWidth=5;
    inputLab.layer.borderColor=[[UIColor grayColor] CGColor];
    inputLab.layer.cornerRadius=10;
    inputLab.userInteractionEnabled=YES;
    inputLab.numberOfLines=0;
    inputLab.tag=0;
    [inputLab setTextColor:[UIColor grayColor]];
    
    inputLab.font=[UIFont boldSystemFontOfSize:15];
    [self.view addSubview:inputLab] ;
    [inputLab release];
    
    
    
    //添加终止子按钮
    outputLab=[[UILabel alloc] initWithFrame:CGRectMake(360, 120, 100, 60)];
    outputLab.textAlignment=NSTextAlignmentCenter;
    [outputLab setText:@"output"];
    outputLab.layer.masksToBounds=YES;
    outputLab.layer.borderWidth=5;
    outputLab.layer.borderColor=[[UIColor grayColor] CGColor];
    outputLab.tag=1;
    outputLab.font=[UIFont boldSystemFontOfSize:15];
    outputLab.layer.cornerRadius=10;
    [outputLab setTextColor:[UIColor grayColor]];
    outputLab.userInteractionEnabled=YES;
    outputLab.numberOfLines=0;
    [self.view addSubview:outputLab] ;
    [outputLab release];
    
    //添加箭头
    UILabel *arrowLab=[[UILabel alloc] initWithFrame:CGRectMake(115, 140, 50, 20)];
    arrowLab.backgroundColor=[UIColor clearColor];
    arrowLab.text=@"→";
    arrowLab.textColor=[UIColor grayColor];
    arrowLab.font=[UIFont boldSystemFontOfSize:30];
    [self.view addSubview:arrowLab];
    [arrowLab release];
    

    
    UILabel *arrowLab2=[[UILabel alloc] initWithFrame:CGRectMake(335, 140, 50, 20)];
    arrowLab2.backgroundColor=[UIColor clearColor];
    arrowLab2.text=@"→";
    arrowLab2.textColor=[UIColor grayColor];
    arrowLab2.font=[UIFont boldSystemFontOfSize:30];
    [self.view addSubview:arrowLab2];
    [arrowLab2 release];
    

    //添加完成按钮
    UIButton *doneButton=[[UIButton alloc] initWithFrame:CGRectMake(350, 250, 100, 30)];
    [doneButton setBackgroundImage:imageWithPath(@"buttonback", @"png") forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(doneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    doneButton.layer.masksToBounds=YES;
    doneButton.layer.cornerRadius=15;
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [self.view addSubview:doneButton];
    [doneButton release];
    
    
    macImageView=[[UIImageView alloc] initWithFrame:CGRectMake(200, 50, 200, 150)];
    
    macImageView.center=CGPointMake(480/2, 320/2);
    macImageView.image=imageWithPath(@"mac", @"png");
    [self.view addSubview:macImageView];
    [macImageView release];
    codeActivity=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    codeActivity.center=CGPointMake(100, 55);
    codeActivity.hidesWhenStopped=YES;
    
    [macImageView addSubview:codeActivity];
    [codeActivity release];
    
    
    //添加选择区域
    selectActionSheet=[[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n\n" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    UIImageView *paperImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, -5, 480, 450)];
    paperImageView.image=imageWithPath(@"paper1", @"png");
    [selectActionSheet addSubview:paperImageView];
    [paperImageView release];
    
    //添加data列表
    dataTableView=[[UITableView alloc] initWithFrame:CGRectMake(20, 50, 440, 205)];
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
    //添加键盘图片
    UIImage *keyboardImage=imageWithPath(@"jianpan", @"png");
    keyboardImageView=[[UIImageView alloc] initWithFrame:CGRectMake(-130, 240, 120, 120*keyboardImage.size.height/keyboardImage.size.width)];
    keyboardImageView.image=keyboardImage;
    [self.view addSubview:keyboardImageView];
    [keyboardImageView release];
}
-(void)cancelButtonClick
{
    [selectActionSheet dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)doneButtonClick
{
    if([inputLab.text isEqualToString:@"input"]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Input is invalid" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    if([outputLab.text isEqualToString:@"output"]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Output is invalid" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    [codeActivity startAnimating];
    self.view.userInteractionEnabled=NO;
    [self findResult];

}
-(void)findResult
{
    [resultArray removeAllObjects];
    [inResultArray removeAllObjects];
    [outResultArray removeAllObjects];
    NSDictionary *dataArray=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];
    for (NSString *d in [dataArray allKeys]) {
        NSDictionary *dic=[dataArray objectForKey:d];
        if([inputLab.text isEqualToString:@"None"]){
            NSString *type= [[[dic objectForKey:@"type"] componentsSeparatedByString:@"_"] objectAtIndex:1];
            if([[type uppercaseString] isEqualToString:[@"promoter" uppercaseString]]&&[[dic objectForKey:@"input+"]isEqualToString:inputLab.text]){
                [inResultArray addObject:d];
            }
        }else{
            if([[dic objectForKey:@"input+"]isEqualToString:inputLab.text]){
                [inResultArray addObject:d];
            }
        }
        if([[dic objectForKey:@"output"]isEqualToString:outputLab.text]){
            [outResultArray addObject:d];
        }
    }
    NSDictionary *lengthDic=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dataLength" ofType:@"plist"]];
    for (NSString *inStr in inResultArray) {
        NSDictionary *inDic=[lengthDic objectForKey:inStr];
        if(inDic==nil){
            continue;
        }
        NSArray *aa=[inDic allKeys];
        for (NSString *outStr in outResultArray) {
            NSString *resultStr=[inDic objectForKey:outStr];
            if(resultStr!=nil){
                [resultArray addObject:resultStr];
            }
        }
    }
    if(resultArray.count==0){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Temporarily not constitute a path" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
        [codeActivity stopAnimating];
        self.view.userInteractionEnabled=YES;
        return;
    }
    ResultViewController *resultVC=[[[ResultViewController alloc] init] autorelease];
    resultVC.isHand=NO;
    resultVC.resultArray=resultArray;
    [self presentViewController:resultVC animated:YES completion:^{
        [codeActivity stopAnimating];
    }];
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    if([touch view]==inputLab){
        isOut=NO;
        [selectActionSheet showInView:self.view];
        
        [dataTableView reloadData];
        dataTableView.scrollsToTop=YES;
    }else if([touch view]==outputLab){
        isOut=YES;
        [selectActionSheet showInView:self.view];
        
        [dataTableView reloadData];
        dataTableView.scrollsToTop=YES;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	if(isOut){
        return [[outArray allKeys] count];
    }
	return [[inArray allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isOut){
        NSArray *allK=[[outArray allKeys] sortedArrayUsingSelector:@selector(compare:)];
        return [[outArray objectForKey:[allK objectAtIndex:section]] count];
    }
	NSArray *allK=[[inArray allKeys] sortedArrayUsingSelector:@selector(compare:)];
    return [[inArray objectForKey:[allK objectAtIndex:section]] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	if(isOut){
        NSArray *allK=[[outArray allKeys] sortedArrayUsingSelector:@selector(compare:)];
        
        cell.textLabel.text=[[outArray objectForKey:[allK objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    }else{
        NSArray *allK=[[inArray allKeys] sortedArrayUsingSelector:@selector(compare:)];
        
        cell.textLabel.text=[[inArray objectForKey:[allK objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[selectActionSheet dismissWithClickedButtonIndex:0 animated:YES];
    if (isOut) {
        NSArray *allK=[[outArray allKeys] sortedArrayUsingSelector:@selector(compare:)];
        outputLab.text=[[outArray objectForKey:[allK objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    }else{
        NSArray *allK=[[inArray allKeys] sortedArrayUsingSelector:@selector(compare:)];
        inputLab.text=[[inArray objectForKey:[allK objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(isOut){
        NSArray *allK=[[outArray allKeys] sortedArrayUsingSelector:@selector(compare:)];
        return [allK objectAtIndex:section];
    }else{
        NSArray *allK=[[inArray allKeys] sortedArrayUsingSelector:@selector(compare:)];
        return [allK objectAtIndex:section];
    }
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *toBeReturned = [[NSMutableArray alloc]init];
    for(char c = 'A';c<='Z';c++)
        [toBeReturned addObject:[NSString stringWithFormat:@"%c",c]];
    return toBeReturned;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
