//
//  HandViewController.h
//  Auto Circuit
//
//  Created by Demo on 13-8-3.
//  Copyright (c) 2013年 usetc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface HandViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>

@property (nonatomic, retain) NSArray *arrayOriginal;
@property (nonatomic, retain) NSMutableArray *arForTable;
@property (nonatomic,strong) NSMutableArray *selectArray;
-(void)miniMizeThisRows:(NSArray*)ar;
@end
