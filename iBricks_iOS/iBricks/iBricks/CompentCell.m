//
//  CompentCell.m
//  iBricks
//
//  Created by 向 文品 on 13-8-29.
//  Copyright (c) 2013年 Demo. All rights reserved.
//

#import "CompentCell.h"
@interface CompentCell ()
{
    NSMutableDictionary *powerDic;
}
@end
@implementation CompentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        powerDic=[[NSMutableDictionary alloc] init];
        NSArray *titleArray=@[@"stability",@"speed",@"weapon"];
        for (int i=0; i<titleArray.count; i++) {
            UIImage *stabilityImage=[UIImage imageNamed:[titleArray objectAtIndex:i]];
            UIImageView *stabilityImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5+50*i, 90, 90*stabilityImage.size.height/stabilityImage.size.width)];
            stabilityImageView.image=stabilityImage;
            [self.contentView addSubview:stabilityImageView];
            NSMutableArray *starArray=[NSMutableArray array];
            for (int j=0; j<5; j++) {
                UIButton *starButton=[[UIButton alloc] initWithFrame:CGRectMake(110+50*j, 2+45*i, 30, 30)];
                [starButton setBackgroundImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [starButton setBackgroundImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateSelected];
                //starButton.enabled=NO;
                [self.contentView addSubview:starButton];
                [starArray addObject:starButton];
            }
            [powerDic setValue:starArray forKey:[titleArray objectAtIndex:i]];
            self.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
    }
    return self;
}
-(void)setStarWithMark:(NSString *)str
{
    NSArray *titleArray=@[@"stability",@"speed",@"weapon"];
    NSArray *marks=[str componentsSeparatedByString:@"	"];
    for (int i=0; i<titleArray.count; i++) {
        NSArray *bts=[powerDic objectForKey:[titleArray objectAtIndex:i]];
        int select=[[marks objectAtIndex:i] intValue];
        for (int j=0; j<bts.count; j++) {
            UIButton *b=[bts objectAtIndex:j];
            if(j<select){
                b.selected=YES;
            }else{
                b.selected=NO;
            }
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
