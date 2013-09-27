//
//  VirusImageView.m
//  iBricks
//
//  Created by 向 文品 on 13-8-29.
//  Copyright (c) 2013年 Demo. All rights reserved.
//

#import "VirusImageView.h"

@implementation VirusImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"噬菌体进入液体" ofType:@"wav"];
        if (soundPath) {
            NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
            OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL,&_shortSound);
            if (err != kAudioServicesNoError)
            {
            }
        }
    }
    return self;
}
-(void)setPosition
{
    self.center=CGPointMake(self.center.x, self.center.y+_speed);
    if(self.center.y>300){
        self.speed=self.speed/1.2;
        if (self.isCanSound) {
            AudioServicesPlaySystemSound(_shortSound);
        }
        self.isCanSound=NO;
    }else{
        self.isCanSound=YES;
    }
    if(self.speed<2){
        self.alpha=0;
        [_delegate cutLifePower];
    }
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
