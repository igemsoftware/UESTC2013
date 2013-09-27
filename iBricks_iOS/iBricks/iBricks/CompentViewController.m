//
//  CompentViewController.m
//  iBricks
//
//  Created by 向 文品 on 13-8-29.
//  Copyright (c) 2013年 Demo. All rights reserved.
//

#import "CompentViewController.h"
#import "CompentCell.h"
#import "myDefine.h"
@interface CompentViewController ()
{
    NSDictionary *dataDic;
    NSMutableArray *dataArray;
    int selectTag;
    NSMutableArray *makeArray;
}
@end

@implementation CompentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	dataDic=[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"]];
    dataArray=[[NSMutableArray alloc] init];
    NSUserDefaults *myUserDefaults=[NSUserDefaults standardUserDefaults];
    selectTag=[myUserDefaults integerForKey:@"selectTag"];
    makeArray=[[NSMutableArray alloc] initWithObjects:@"2	2	1",@"1	2	1",@"1	1	2",@"2	2	1", nil];
    [self cellButtonClick:nil];
    [self setPowerWithMake];
}
-(void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *myUserDefaults=[NSUserDefaults standardUserDefaults];
    int selectTag=[myUserDefaults integerForKey:@"selectTag"];
    int achieveTag=[myUserDefaults integerForKey:@"achieveTag"];
    if (selectTag>achieveTag) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Notice" message:@"locked" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)setPowerWithMake
{
    int n=0;
    int m=0;
    int k=0;
    for (int i=0; i<makeArray.count; i++) {
        NSArray *mm=[[makeArray objectAtIndex:i] componentsSeparatedByString:@"	"];
        n+=[[mm objectAtIndex:0] intValue];
        m+=[[mm objectAtIndex:1] intValue];
        k+=[[mm objectAtIndex:2] intValue];
    
    }
    int index=[[[NSUserDefaults standardUserDefaults] valueForKey:@"selectTag"] intValue];
    _bloodLab.text=[NSString stringWithFormat:@"%d",n];
    _clockLab.text=[NSString stringWithFormat:@"%d",[[TIME objectAtIndex:m/4-1] intValue]+index*5];
    _magicLab.text=[NSString stringWithFormat:@"%@",[WEAPON objectAtIndex:k/4-1]];
    NSUserDefaults *myUserDefaults=[NSUserDefaults standardUserDefaults];
    [myUserDefaults setInteger:[_bloodLab.text intValue] forKey:@"blood"];
    [myUserDefaults setInteger:[_clockLab.text intValue] forKey:@"clock"];
    
    [myUserDefaults setInteger:1/[_magicLab.text floatValue] forKey:@"magic"];
    [myUserDefaults synchronize];
}
-(IBAction)cellButtonClick:(UIButton *)sender
{
    NSArray *array=@[@"Promoter",@"RBS",@"CDS",@"Terminator"];
    [dataArray removeAllObjects];
    NSDictionary *d=[dataDic objectForKey:[array objectAtIndex:sender.tag]];
    for (int i=0; i<=selectTag; i++) {
        NSArray *selectArray=[d objectForKey:[NSString stringWithFormat:@"%d",i]];
        for (NSString *str in selectArray) {
            [dataArray addObject:str];
        }
    }
    [_dataTableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 138;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *Cell=@"Cell";
    CompentCell *cell=[tableView dequeueReusableCellWithIdentifier:Cell];
    if(cell==nil){
        cell=[[CompentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    [cell setStarWithMark:[dataArray objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [makeArray removeObjectAtIndex:selectTag];
    [makeArray insertObject:[dataArray objectAtIndex:indexPath.row] atIndex:selectTag];
    [self setPowerWithMake];
    
}
-(IBAction)backButtonClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
