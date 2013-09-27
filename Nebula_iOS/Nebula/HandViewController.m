//
//  HandViewController.m
//  Auto Circuit
//
//  Created by Demo on 13-8-3.
//  Copyright (c) 2013年 usetc. All rights reserved.
//

#import "HandViewController.h"
#import "myDefine.h"
#import "ResultViewController.h"

@interface HandViewController ()
{
    UIActionSheet *selectActionSheet;
    UITableView *dataTableView;
    UITableView *selectTableView;
    UIButton *selectBackButton;
    
    
    UIScrollView *drawScrollView;
    NSMutableArray *cellArray;
    UILabel *buttonLab;
    UILabel *currentLab;
    
    BOOL isAddBefore;
    BOOL isForward;
    float positionY;
    
    UIActionSheet *detailActionSheet;
    UITextView *detailLab;
    UITextView *detailTextView;
    UILabel *detailNameLab;
    
    NSDictionary *dataDics;
}
@end

@implementation HandViewController

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
    [cellArray release];
    [dataDics release];
    [detailActionSheet release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    dataDics=[[NSDictionary  alloc ]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];
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
    //添加作图区域
    
    cellArray=[[NSMutableArray alloc] init];
    drawScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(10, 48, 460, 210)];
    //drawScrollView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:drawScrollView];
    [drawScrollView release];
    //添加第一个按钮
    isForward=YES;
    positionY=20;
    buttonLab=[[UILabel alloc] initWithFrame:CGRectMake(20, 20, 90, 50)];
    buttonLab.layer.borderWidth=3;
    buttonLab.layer.borderColor=[[UIColor grayColor] CGColor];
    buttonLab.layer.cornerRadius=5;
    buttonLab.textAlignment=NSTextAlignmentCenter;
    buttonLab.text=@"Add";
    buttonLab.userInteractionEnabled=YES;
    buttonLab.textColor=[UIColor grayColor];
    [drawScrollView addSubview:buttonLab];
    [buttonLab release];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAddLab)];
    [buttonLab addGestureRecognizer:tap];
    [tap release];
    
    
    //添加完成按钮
    UIButton *doneButton=[[UIButton alloc] initWithFrame:CGRectMake(350, 260, 100, 30)];
    [doneButton setBackgroundImage:imageWithPath(@"buttonback", @"png") forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(doneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    doneButton.layer.masksToBounds=YES;
    doneButton.layer.cornerRadius=15;
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [self.view addSubview:doneButton];
    [doneButton release];
    //添加选择区域
    selectActionSheet=[[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n\n" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    UIImageView *paperImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, -5, 480, 450)];
    paperImageView.image=imageWithPath(@"paper1", @"png");
    [selectActionSheet addSubview:paperImageView];
    [paperImageView release];
    
    //添加data列表
    selectTableView=[[UITableView alloc] initWithFrame:CGRectMake(20, 50, 440, 205)];
    selectTableView.delegate=self;
    selectTableView.dataSource=self;
    selectTableView.backgroundColor=[UIColor clearColor];
    selectTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [selectActionSheet addSubview:selectTableView];
    [selectTableView release];
    
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
    UIImage *selectBackImage=imageWithPath(@"selectback", @"png");
    selectBackButton=[[UIButton alloc] initWithFrame:CGRectMake(10, 5, 50, 50*cancelImage.size.height/cancelImage.size.width)];
    selectBackButton.alpha=0;
    [selectBackButton addTarget:self action:@selector(selectBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [selectBackButton setBackgroundImage:selectBackImage forState:UIControlStateNormal];
    [selectActionSheet addSubview:selectBackButton];
    [selectBackButton release];
    
    
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
    
    //添加数据
    NSDictionary *dTmp=[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"typeData" ofType:@"plist"]];
	self.arrayOriginal=[dTmp valueForKey:@"Objects"];
	[dTmp release];
	
	self.arForTable=[[[NSMutableArray alloc] init] autorelease];
	[self.arForTable addObjectsFromArray:self.arrayOriginal];
    
    self.selectArray=[[[NSMutableArray alloc] init] autorelease];

    

}
-(void)doneButtonClick
{
    if(cellArray.count<2){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Temporarily not constitute a path" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    NSMutableString *str=[[[NSMutableString alloc] init] autorelease];
    [str appendString:[NSString stringWithFormat:@"%@",[[cellArray objectAtIndex:0] text]]];
    for (int i=1; i<cellArray.count; i++) {
        [str appendString:[NSString stringWithFormat:@"-%@",[[cellArray objectAtIndex:i] text]]];
    }
    ResultViewController *resultVC=[[[ResultViewController alloc] init] autorelease];
    resultVC.isHand=YES;
    resultVC.resultArray=@[str];
    [self presentViewController:resultVC animated:YES completion:^{
    }];
}
-(void)tapAddLab
{
    [selectActionSheet showInView:self.view];
}
-(void)selectBackButtonClick
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        selectTableView.alpha=0;
        selectBackButton.alpha=0;
    } completion:^(BOOL finished) {
        dataTableView.alpha=1;
    }];
}
-(void)cancelButtonClick
{
    [selectActionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
    selectBackButton.alpha=0;
    [self.view bringSubviewToFront:dataTableView];
}
-(void)cancelButton2Click
{
    [detailActionSheet dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==selectTableView){
        return [self.selectArray count];
    }
	return [self.arForTable count];
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
   
    NSDictionary *dic=[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"allDescribe" ofType:@"plist"]] objectForKey:[_selectArray objectAtIndex:indexPath.row]];
    detailNameLab.text=[self.selectArray objectAtIndex:indexPath.row] ;
    detailTextView.text=[dic objectForKey:@"sequences/seq_data"];
    detailLab.text=[dic objectForKey:@"part_short_desc"];
    
    [detailActionSheet showInView:self.view];
}
-(void)detailButtonClick
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://parts.igem.org/wiki/index.php?title=Part:%@",detailNameLab.text]]];
}
-(void)removeDetailViewHappen
{
    [selectActionSheet showInView:self.view];
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if(tableView==selectTableView){
        
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            
        }
        NSDictionary *dic=[dataDics objectForKey:[self.selectArray objectAtIndex:indexPath.row]];
        cell.textLabel.text=[self.selectArray objectAtIndex:indexPath.row];
        cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
        cell.detailTextLabel.text=[NSString stringWithFormat:@"scores:%@",[dic objectForKey:@"scores"]];
        return cell;
    }
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
    }
	cell.textLabel.text=[[self.arForTable objectAtIndex:indexPath.row] valueForKey:@"name"];
    int level=[[[self.arForTable objectAtIndex:indexPath.row] valueForKey:@"level"] intValue];
	[cell setIndentationLevel:3*level];
    cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",level]];
	
    return cell;
}
//长按删除功能
-(void)holdLab:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state==UIGestureRecognizerStateBegan){
        currentLab=(UILabel *)[gesture view];
        UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Remove",@"Add Before",@"Add After", nil];
        actionSheet.actionSheetStyle=UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self.view];
        [actionSheet release];
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:{
            UILabel *lsLab=[cellArray lastObject];
            buttonLab.frame=lsLab.frame;
            
            for (int i=currentLab.tag; i<cellArray.count-1; i++) {
                UILabel *lab1=[cellArray objectAtIndex:i];
                UILabel *lab2=[cellArray objectAtIndex:i+1];
                lab1.text=lab2.text;
                    
            }
            currentLab=nil;
            [lsLab removeFromSuperview];
            [cellArray removeObject:lsLab];
            lsLab=nil;
        }
            break;
        case 1:
            isAddBefore=YES;
             [selectActionSheet showInView:self.view];
            break;
        case 2:
            isAddBefore=NO;
             [selectActionSheet showInView:self.view];
            break;
        case 3:
            
            break;
        default :
            break;
    }
}

-(void)insertAddLabWithBefore{
    //NSString *labStr=[[cellArray objectAtIndex:currentLab.tag+1] text];
    int currentTag=currentLab.tag;
    if(cellArray.count<2){
        return;
    }
    NSString *lsLabStr=[[cellArray objectAtIndex:cellArray.count-1] text];
    
    for (int i=cellArray.count-1; i>=currentTag+1; i--) {
        UILabel *lab1=[cellArray objectAtIndex:i-1];
        UILabel *lab2=[cellArray objectAtIndex:i];
        lab2.text=lab1.text;
    }
    UILabel *lab=[cellArray objectAtIndex:currentTag+1];
    if(isAddBefore){
        lab.text=currentLab.text;
        currentLab.text=lsLabStr;
    }else{
        lab.text=lsLabStr;
    }
    currentLab=nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==selectTableView){
        UILabel *addLab=[[UILabel alloc] initWithFrame:buttonLab.frame];
        addLab.tag=[cellArray count];
        addLab.textAlignment=NSTextAlignmentCenter;
        addLab.userInteractionEnabled=YES;
        addLab.layer.cornerRadius=5;
        addLab.layer.borderWidth=3;
        addLab.clipsToBounds=NO;
        addLab.font=[UIFont systemFontOfSize:15];
        addLab.numberOfLines=0;
        addLab.text=[self.selectArray objectAtIndex:indexPath.row];
        [drawScrollView addSubview:addLab];
        [addLab release];
        
        
        
        
        UILongPressGestureRecognizer *holdGesture=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(holdLab:)];
        [addLab addGestureRecognizer:holdGesture];
        [holdGesture release];
        
        UILabel *arrowLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        arrowLab.alpha=0;
        arrowLab.backgroundColor=[UIColor clearColor];
        arrowLab.textAlignment=NSTextAlignmentCenter;
        arrowLab.font=[UIFont boldSystemFontOfSize:20];
        [addLab addSubview:arrowLab];
        [arrowLab release];
        
        CGRect frame=buttonLab.frame;
        CGRect arrowFrame=arrowLab.frame;
        if (isForward) {
            if(frame.origin.x<350){
                frame.origin.x+=110;
                arrowFrame.origin.x=90;
                arrowFrame.origin.y=15;
                arrowLab.text=@"→";
            }else{
                frame.origin.y+=70;
                arrowLab.text=@"↓";
                arrowFrame.origin.x=35;
                arrowFrame.origin.y=50;
                isForward=NO;
            }
            
        }else{
            if(frame.origin.x>20){
                frame.origin.x-=110;
                arrowLab.text=@"←";
                arrowFrame.origin.x=-20;
                arrowFrame.origin.y=15;
            }else{
                frame.origin.y+=70;
                arrowLab.text=@"↓";
                arrowFrame.origin.x=35;
                arrowFrame.origin.y=50;
                isForward=YES;
            }
        }
        arrowLab.frame=arrowFrame;
        [cellArray addObject:addLab];
        [UIView animateWithDuration:0.5 animations:^{
            buttonLab.frame=frame;
            arrowLab.alpha=1;
            float Y=drawScrollView.contentSize.height;
            if(Y>210){
                [drawScrollView setContentOffset:CGPointMake(0, Y-210)];
            }
            
        }];
        [drawScrollView setContentSize:CGSizeMake(460,frame.origin.y+70)];
        if(currentLab!=nil){
            [self insertAddLabWithBefore];
        }
        
        [selectActionSheet dismissWithClickedButtonIndex:0 animated:YES];
        
        selectTableView.alpha=0;
        dataTableView.alpha=1;
        selectBackButton.alpha=0;
        return;
        
    }
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	NSDictionary *d=[self.arForTable objectAtIndex:indexPath.row];

	if([d valueForKey:@"Objects"]) {
		NSArray *ar=[d valueForKey:@"Objects"];
		
		BOOL isAlreadyInserted=NO;
		
		for(NSDictionary *dInner in ar ){
			NSInteger index=[self.arForTable indexOfObjectIdenticalTo:dInner];
			isAlreadyInserted=(index>0 && index!=NSIntegerMax);
			if(isAlreadyInserted) break;
		}
		
		if(isAlreadyInserted) {
			[self miniMizeThisRows:ar];
		} else {
			NSUInteger count=indexPath.row+1;
			NSMutableArray *arCells=[NSMutableArray array];
			for(NSDictionary *dInner in ar ) {
				[arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
				[self.arForTable insertObject:dInner atIndex:count++];
			}
			[tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationLeft];
		}
	}else{
        [self.selectArray removeAllObjects];
        NSString *key=[[self.arForTable objectAtIndex:indexPath.row] valueForKey:@"name"];
        NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"allTypedata" ofType:@"plist"]];
        NSArray *a=[dic objectForKey:key];
        if (a.count==0) {
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"No part of this type in this data base at present" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alert show];
//            [alert release];
            return;
        }
        for (NSString *s in a) {
            [_selectArray addObject:s];
        }
        [selectTableView reloadData];
        selectTableView.alpha=0;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            dataTableView.alpha=0;
            selectBackButton.alpha=1;
        } completion:^(BOOL finished) {
            [self.view bringSubviewToFront:selectTableView];
            selectTableView.alpha=1;
        }];
    }
}

-(void)miniMizeThisRows:(NSArray*)ar{
	
	for(NSDictionary *dInner in ar ) {
		NSUInteger indexToRemove=[self.arForTable indexOfObjectIdenticalTo:dInner];
		NSArray *arInner=[dInner valueForKey:@"Objects"];
		if(arInner && [arInner count]>0){
			[self miniMizeThisRows:arInner];
		}
		
		if([self.arForTable indexOfObjectIdenticalTo:dInner]!=NSNotFound) {
			[self.arForTable removeObjectIdenticalTo:dInner];
			[dataTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject: [NSIndexPath indexPathForRow:indexToRemove inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
		}
	}
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
