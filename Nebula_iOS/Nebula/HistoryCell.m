//
//  HistoryCell.m
//  Auto Circuit
//
//  Created by igem on 8/7/13.
//  Copyright (c) 2013 usetc. All rights reserved.
//

#import "HistoryCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation HistoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *lineImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 2, 150)];
        lineImageView.center=CGPointMake(240, 75);
        lineImageView.layer.borderWidth=1;
        lineImageView.layer.borderColor=[[UIColor blackColor] CGColor];
        [self.contentView addSubview:lineImageView];
        [lineImageView release];
        
        self.titleLab=[[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)] autorelease];
        _titleLab.center=CGPointMake(240, 75);
        _titleLab.textAlignment=NSTextAlignmentCenter;
        _titleLab.textColor=[UIColor blackColor];
        //_titleLab.backgroundColor=[UIColor blackColor];
        _titleLab.layer.borderColor=[[UIColor blackColor] CGColor];
        _titleLab.layer.borderWidth=1;
        _titleLab.layer.cornerRadius=50;
        _titleLab.numberOfLines=0;
        [self.contentView addSubview:_titleLab];
        
        
        self.treeImageView=[[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 2)] autorelease];
        _treeImageView.layer.borderWidth=1;
        _treeImageView.center=CGPointMake(0, 75);
        [self.contentView addSubview:_treeImageView];
        
        self.bodyLab=[[[UILabel alloc] initWithFrame:CGRectMake(315, 10, 470-325, 130)] autorelease];
        _bodyLab.font=[UIFont systemFontOfSize:15];
        _bodyLab.numberOfLines=0;
        _bodyLab.textAlignment=NSTextAlignmentCenter;
        _bodyLab.textColor=[UIColor blackColor];
        _bodyLab.layer.borderWidth=1;
        _bodyLab.layer.cornerRadius=10;
        _bodyLab.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:_bodyLab];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
