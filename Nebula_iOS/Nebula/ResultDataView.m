//
//  ResultDataView.m
//  Auto Circuit
//
//  Created by igem on 8/5/13.
//  Copyright (c) 2013 usetc. All rights reserved.
//

#import "ResultDataView.h"
#import <QuartzCore/QuartzCore.h>
#import "myDefine.h"
@implementation ResultDataView

- (id)init
{
    self = [super init];
    if (self) {
        self.frame=CGRectMake(0, 0, 85, 50);
        UIImageView *borImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 85, 50)];
        borImageView.layer.borderWidth=2;
        borImageView.layer.borderColor=[[UIColor grayColor] CGColor];
        borImageView.layer.cornerRadius=5;
        [self addSubview:borImageView];
        [borImageView release];
        
        self.headImageView=[[[UIImageView alloc] initWithFrame:CGRectMake(-15, -10, 40, 25)] autorelease];
        [self addSubview:_headImageView];
        
        self.nameLab=[[[UILabel alloc] initWithFrame:CGRectMake(5, 10, 75, 35)] autorelease];
        _nameLab.backgroundColor=[UIColor clearColor];
        _nameLab.numberOfLines=0;
        _nameLab.font=[UIFont systemFontOfSize:10];
        _nameLab.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_nameLab];
        
        self.rightLab=[[[UILabel alloc] initWithFrame:CGRectMake(85, 15, 20, 20)] autorelease];
        _rightLab.backgroundColor=[UIColor clearColor];
        _rightLab.textAlignment=NSTextAlignmentCenter;
        _rightLab.font=[UIFont boldSystemFontOfSize:20];
        _rightLab.text=@"→";
        [self addSubview:_rightLab];
    
        
        self.LeftLab=[[[UILabel alloc] initWithFrame:CGRectMake(-20, 15, 20, 20)] autorelease];
        _LeftLab.backgroundColor=[UIColor clearColor];
        _LeftLab.textAlignment=NSTextAlignmentCenter;
        _LeftLab.font=[UIFont boldSystemFontOfSize:20];
        _LeftLab.text=@"←";
        [self addSubview:_LeftLab];
        
        self.bottomLab=[[[UILabel alloc] initWithFrame:CGRectMake(32.5, 50, 20, 20)] autorelease];
        _bottomLab.backgroundColor=[UIColor clearColor];
        _bottomLab.textAlignment=NSTextAlignmentCenter;
        _bottomLab.font=[UIFont boldSystemFontOfSize:20];
        _bottomLab.text=@"↓";
        [self addSubview:_bottomLab];
        
        self.LeftLab.alpha=0;
        self.rightLab.alpha=0;
        self.bottomLab.alpha=0;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
