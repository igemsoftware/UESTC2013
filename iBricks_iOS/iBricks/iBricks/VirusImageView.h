//
//  VirusImageView.h
//  iBricks
//
//  Created by 向 文品 on 13-8-29.
//  Copyright (c) 2013年 Demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
@protocol VirusCutLifePower <NSObject>
-(void)cutLifePower;

@end
@interface VirusImageView : UIImageView
@property (nonatomic,assign)id <VirusCutLifePower>  delegate;
@property (nonatomic,assign) float speed;
@property (nonatomic,assign) int life;
@property (nonatomic,assign) BOOL isCanSound;
@property (nonatomic,assign) SystemSoundID shortSound;
-(void)setPosition;
@end
