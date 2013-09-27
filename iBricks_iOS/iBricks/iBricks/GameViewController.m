//
//  GameViewController.m
//  iBricks
//
//  Created by 向 文品 on 13-8-29.
//  Copyright (c) 2013年 Demo. All rights reserved.
//

#import "GameViewController.h"
#import "myDefine.h"
#import <AudioToolbox/AudioToolbox.h>
@interface GameViewController ()
{
    NSMutableArray *normalCellArray;
    NSMutableArray *virusArray;
    int virusTime;
    int virusCountTime;
    int lifePower;
    BOOL isTimeOut;
    NSTimer *gameTimer;
    
    int selectTag;
    UIImageView  *view;
    UIButton *nextButton;
    float time;
    int magic;
    SystemSoundID shortSound;
    SystemSoundID winSound;
    SystemSoundID failSound;
}
@end

@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(void)backButtonClick:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Notice" message:@"Exit Game？" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alert show];
    [gameTimer invalidate];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        gameTimer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(virusTime) userInfo:nil repeats:YES];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"menu" ofType:@"wav"];
    if (soundPath) {
        NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
        OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL,&shortSound);
        if (err != kAudioServicesNoError)
        {   
        }
    }
    soundPath = [[NSBundle mainBundle] pathForResource:@"胜利" ofType:@"wav"];
    if (soundPath) {
        NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
        OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL,&winSound);
        if (err != kAudioServicesNoError)
        {
        }
    }
    soundPath = [[NSBundle mainBundle] pathForResource:@"失败" ofType:@"wav"];
    if (soundPath) {
        NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
        OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL,&failSound);
        if (err != kAudioServicesNoError)
        {
        }
    }
    
    NSUserDefaults *myUsetDefault=[NSUserDefaults standardUserDefaults];
    lifePower=[myUsetDefault integerForKey:@"blood"];
    _bloodLab.text=[NSString stringWithFormat:@"%d",lifePower];
    _clockLab.text=[NSString stringWithFormat:@"%d",[myUsetDefault integerForKey:@"clock"]];
    _magicLab.text=@"0";
	normalCellArray=[[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"睁眼.png"],[UIImage imageNamed:@"睁眼.png"],[UIImage imageNamed:@"睁眼.png"],[UIImage imageNamed:@"睁眼.png"],[UIImage imageNamed:@"闭眼.png"], nil];
    [_cellImageView setAnimationDuration:1];
    [_cellImageView setAnimationImages:normalCellArray];
    [_cellImageView startAnimating];
    
    
    virusArray=[[NSMutableArray alloc] init];
    virusTime=30;
    virusCountTime=0;
    //添加病毒体
    for (int i=0; i<15; i++) {
        VirusImageView *virus=[[VirusImageView alloc] initWithFrame:CGRectMake(0, -20, 48, 70)];
        virus.image=[UIImage imageNamed:@"phage1.png"];
        virus.backgroundColor=[UIColor clearColor];
        virus.delegate=self;
        [self.view addSubview:virus];
        virus.alpha=0;
        [virusArray addObject:virus];
    }
    gameTimer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(virusTime) userInfo:nil repeats:YES];
    selectTag=[myUsetDefault integerForKey:@"selectTag"];
    view=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    
    view.userInteractionEnabled=YES;
    view.center=CGPointMake(160, 240);
    
    nextButton=[[UIButton alloc] initWithFrame:CGRectMake(180, 145, 40, 40)];
    [nextButton setBackgroundImage:[UIImage imageNamed:@"选关"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:nextButton];
    time=[_clockLab.text floatValue];
}
-(void)nextButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//点击方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self.view];
    NSUserDefaults *myUserDefault=[NSUserDefaults standardUserDefaults];
    for (VirusImageView *im in virusArray) {
        if([self isInViewWithPoint:point andWithView:im ]&&im.alpha==1){
            if (im.life>=1) {
                AudioServicesPlaySystemSound(shortSound);
                im.life--;
                magic++;
                if (magic>=[myUserDefault integerForKey:@"magic"]) {
                    magic=0;
                    self.magicLab.text=[NSString stringWithFormat:@"%d",[self.magicLab.text intValue]+1];
                }
                
            }
            if (im.life==0) {
                im.alpha=0;
                if(virusTime>5){
                    virusTime-=1;
                }
                
        
            }
            
            
            
        }
    }
    
}
-(IBAction)reStart:(id)sender
{
    for(VirusImageView *virus in virusArray) {
        virus.alpha=0;
        
    }
    NSUserDefaults *myUsetDefault=[NSUserDefaults standardUserDefaults];
    lifePower=[myUsetDefault integerForKey:@"blood"];
    _bloodLab.text=[NSString stringWithFormat:@"%d",lifePower];
    _clockLab.text=[NSString stringWithFormat:@"%d",[myUsetDefault integerForKey:@"clock"]];
    time=[_clockLab.text floatValue];
    _scoreLab.text=@"0000";
    _magicLab.text=@"0";
	normalCellArray=[[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"睁眼.png"],[UIImage imageNamed:@"睁眼.png"],[UIImage imageNamed:@"睁眼.png"],[UIImage imageNamed:@"睁眼.png"],[UIImage imageNamed:@"闭眼.png"], nil];
    [_cellImageView setAnimationDuration:1];
    [_cellImageView setAnimationImages:normalCellArray];
    [_cellImageView startAnimating];
}
-(BOOL)isInViewWithPoint:(CGPoint )point andWithView:(UIView *)v
{
    BOOL result=NO;
    if(point.x>=v.frame.origin.x&&point.x<=v.frame.origin.x+v.frame.size.width&&point.y>=v.frame.origin.y&&point.y<=v.frame.origin.y+v.frame.size.height){
        result=YES;
    }
    return result;
}

//病毒
-(void)virusTime
{
    time-=0.1;
    _clockLab.text=[NSString stringWithFormat:@"%.0f",time];
    if (time<=0) {
        [gameTimer invalidate];
        view.image=[UIImage imageNamed:@"弹框1"];
        [self.view addSubview:view];
        AudioServicesPlaySystemSound(winSound);
        NSUserDefaults *myUserDefaults=[NSUserDefaults standardUserDefaults];
        if ([myUserDefaults integerForKey:@"achieveTag"]<4&&selectTag==[myUserDefaults integerForKey:@"achieveTag"]) {
            [myUserDefaults setInteger:[myUserDefaults integerForKey:@"achieveTag"]+1 forKey:@"achieveTag"];
        }
        
    }
    BOOL isViCanAppear=NO;
    virusCountTime++;
    if(virusCountTime>=virusTime){
        virusCountTime=0;
        //virusTime=20;
        isViCanAppear=YES;
    }
    if(isViCanAppear){
        VirusImageView *virusLab=[self getVieus];
        if(virusLab){
            virusLab.alpha=1;
            virusLab.center=CGPointMake(abs(arc4random()%220+50), -20);
            float sp=[self getSpeed];
            virusLab.speed=sp;
            if (sp==15.0/5) {
                virusLab.image=[UIImage imageNamed:@"phage 3"];
                virusLab.life=5;
            }else if (sp==15.0/4) {
                virusLab.image=[UIImage imageNamed:@"phage 2"];
                virusLab.life=4;
            }else if (sp==15.0/3) {
                virusLab.image=[UIImage imageNamed:@"phage 4"];
                virusLab.life=3;
            }else if (sp==15.0/2) {
                virusLab.image=[UIImage imageNamed:@"phage1"];
                virusLab.life=2;
            }else if (sp==15.0) {
                virusLab.image=[UIImage imageNamed:@"phage透明"];
                virusLab.life=1;
            }
            virusLab.transform=CGAffineTransformMakeRotation(arc4random()%40/10.f);
        }
    }
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        for (VirusImageView *lab in virusArray) {
            if(lab.alpha==1){
                [lab setPosition];
            }
        }
    } completion:^(BOOL finished) {
        
    }];
}
-(float )getSpeed
{
    float s=arc4random()%100;
    float speed=15;
    switch (selectTag) {
        case 0:
            return speed;;
            break;
        case 1:
            if (s<=25) {
                return speed/2;;
            }else{
                return speed;
            }
            break;
        case 2:
            if (s<11) {
                return speed/3;
            }else if(s<44){
                return speed/2;
            }else{
                return speed;
            }
            break;
        case 3:
            if (s<6.25) {
                return speed/4;
            }else if(s<25){
                return speed/3;
            }else if(s<37.5){
                return speed/2;
            }else{
                return speed; 
            }
            break;
        case 4:
            if (s<4) {
                return speed/5;
            }else if(s<7){
                return speed/4;
            }else if(s<20.5){
                return speed/3;
            }else if(s<40){
                return speed/2;
            }else{
                return speed;
            }
            break;
        default:
            break;
    }
    return 0;
}
-(void)cutLifePower
{
    lifePower--;
    _bloodLab.text=[NSString stringWithFormat:@"%d",lifePower];
    NSArray *cellImages=@[[UIImage imageNamed:@"受伤大"],[UIImage imageNamed:@"受伤大"],[UIImage imageNamed:@"受伤大"],[UIImage imageNamed:@"受伤大"],[UIImage imageNamed:@"受伤小"]];
    [self.cellImageView setAnimationImages:cellImages];
    [self.cellImageView startAnimating];
    [self performSelector:@selector(setNormalCell) withObject:nil afterDelay:3];
    if(lifePower==0){
        AudioServicesPlaySystemSound(failSound);
        self.cellImageView.image=[UIImage imageNamed:@"死亡"];
        [gameTimer invalidate];
        view.image=[UIImage imageNamed:@"弹框2"];
        [self.view addSubview:view];
        
    }
}
-(void)setNormalCell
{
    NSArray *normal=@[[UIImage imageNamed:@"睁眼.png"],[UIImage imageNamed:@"睁眼.png"],[UIImage imageNamed:@"睁眼.png"],[UIImage imageNamed:@"睁眼.png"],[UIImage imageNamed:@"闭眼.png"]];
    [self.cellImageView setAnimationImages:normal];
    [self.cellImageView startAnimating];
}
-(IBAction)usePower:(id)sender
{
    if([_magicLab.text intValue]>0){
        for (VirusImageView *im in virusArray) {
            im.alpha=0;
        }
        _scoreLab.text=[NSString stringWithFormat:@"%d",[_scoreLab.text intValue]+30];
        _magicLab.text=[NSString stringWithFormat:@"%d",[_magicLab.text intValue]-1];
    }
    
}
-(VirusImageView *)getVieus
{
    VirusImageView *result=nil;
    for (VirusImageView *lab in virusArray){
        if(lab.alpha==0){
            lab.alpha=0.1;
            result=lab;
            break;
        }
    }
    return result;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
