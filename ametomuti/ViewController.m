//
//  ViewController.m
//  ametomuti
//
//  Created by ビザンコムマック０４ on 2014/09/12.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSTimer *timer;
    NSInteger hours;
    NSInteger minuts;
    NSInteger seconds;
    NSInteger hour;
    NSInteger minute;
    BOOL isZero;//00:00:00を通過したかどうか、マイナスカウントを行うために必要
    BOOL isAction;
    AVAudioPlayer *audioPlayer;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    hours = 0;
    minuts = 0;
    seconds = 0;
    isZero = 0;
    [self showdatepickerview];//ピッカータイマーを表示しておく
    
    
    //タイマースタートと同時に効果音鳴らす
    NSError *error = nil;
    // 再生する audio ファイルのパスを取得
    NSString *path = [[NSBundle mainBundle] pathForResource:@"piiii" ofType:@"MP3"];
    // パスから、再生するURLを作成する
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    // auido を再生するプレイヤーを作成する
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    // エラーが起きたとき
    if ( error != nil )
    {
        NSLog(@"Error %@", [error localizedDescription]);
    }
    // 自分自身をデリゲートに設定
    [audioPlayer setDelegate:self];
    
   


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button1:(UIButton *)sender {
    [timer invalidate];
    hours = 0;
    minuts = 0;
    seconds = 0;
    switch (sender.tag) {
        case 0:
            minuts = 3;
            break;
        case 1:
            minuts = 5;
            break;
        case 2:
            minuts = 8;
            break;
        case 3:
            minuts = 10;
            break;
        case 4:
            minuts = 30;
            break;
        case 5:
            hours = 1;
            minuts = 00;
            break;
        case 6:
            hours = 1;
            minuts = 01;
            break;
        case 7:
            hours = 2;
            minuts = 00;
            break;
        case 8:
            hours = 3;
            minuts = 00;
            break;
        case 9:
            hours = 5;
            minuts = 00;
            break;
    }
    
    [self showtimerlabel];
    if (minuts == 00) {
        minuts = 60;
        hours = (hours-1);
    }
    minuts = (minuts-1);
    seconds=60;
    
    [self timer];
    [self showstartlabel];
    [audioPlayer play];
    }
    




- (IBAction)creabutton:(UIBarButtonItem *)sender {
    [timer invalidate];
    hours = 0;
    minuts = 0;
    seconds = 0;
    isZero = NO;
    [self showtimerlabel];
    
}
- (IBAction)Action {
    if (isAction) {
        [timer invalidate];
        isAction = NO;
    }else{
        [self timer];
        isAction = YES;
    }
}

- (IBAction)valuechangedpicker:(UIDatePicker *)sender {
    //datepickerの値が変化したら現在のpickerが示す値を取り出す
    [self valuecatched];
}

- (IBAction)okbutton:(UIBarButtonItem *)sender {
    [self.datepicker setHidden:YES];
    [self.btnA setHidden:NO];
    [timer invalidate]; // タイマー動作中の可能性もあるので一旦タイマーを停止する
    //タイマー動作中の可能性もあるので初期化
    hours = 0;
    minuts = 0;
    seconds = 0;
    isZero = NO;
    //datepickerの値を取り出してラベルに表示
    [self valuecatched];
    minuts = minute;
    hours = hour;
    [self showtimerlabel];
    //タイマー始める
    [self timer];
    [self showstartlabel];
    [audioPlayer play];

    

}

-(void)timer{
    //1秒ごとにこのタイマー呼ばれてcountdownメソッドを繰り返し実行します
    timer = [NSTimer
             scheduledTimerWithTimeInterval:1
             target: self
             selector:@selector(countdown)
             userInfo:nil
             repeats:YES];
}

-(void)countdown{
    //タイマー開始後まだ00:00:00通過していない場合
    if (!isZero) {
        if(seconds>0){
            //秒が0秒ではない場合、0秒になるまでは1秒ずつ引いて行く
            seconds--;
            [self showtimerlabel];//ラベルに表示
        }else if(minuts != 0 && seconds == 0){
            //0秒になり分はまだ0分でない場合は、1分引いて秒を60に戻してそこからまた1秒ずつ引いて行く
            minuts--;
            seconds=60;
            seconds--;
            [self showtimerlabel];
        }else if (minuts == 0 && seconds == 0){
            //秒も分も0になった場合
            if (hours > 0) {
                //hourはまだ0時間でないなら1時間引いて59分にして60秒にしてそこからまた1秒ずつ引いて行く
                hours--;
                minuts = 59;
                seconds = 60;
                seconds--;
            }else if (hours == 0){
                //hourも0時間ならば00:00:00を通過したことを記録
                isZero = YES;
                [self.btnA setHidden:YES];
                [self.btnB setHidden:NO];
            }
        }
    }
    else{
        //タイマー開始後に00:00:00通過しているならばマイナスカウントを行う
        [self mainasucount];
    }
}

-(void)mainasucount{
    //マイナスカウントの時はラベルの文字を赤色にする
    self.countdownlabel.textColor = [UIColor redColor];
    //マイナスカウントの場合は60秒になるまで1秒ずつ足して行く
    seconds++;
    //マイナスカウントの文字列を表示する
    [self mainasushowtimerlabel];
    if (seconds == 60) {
        //60秒になった場合
        if (minuts != 60) {
            //分はまだ60になってない場合は1分足して0秒に戻してからまた1秒ずつ足して行く
            minuts++;
            seconds = 0;
            [self mainasushowtimerlabel];
            seconds++;
            
        }else if (minuts == 60){
            //分も60分の場合は１時間足して、0分0秒に戻してからまた1秒ずつ足して行く
            hours++;
            minuts = 0;
            seconds = 0;
            [self mainasushowtimerlabel];
            seconds++;
        }
    }
}

-(void)showdatepickerview{
    //pickerviewの表示設定
    self.datepicker.center = self.view.center;
    self.datepicker.datePickerMode = UIDatePickerModeCountDownTimer;
    self.datepicker.countDownDuration = 5*60;
}

-(void)valuecatched{
    //pickerviewが指している値をNSIntegerに変換して取り出す
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger flags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [calender components:flags fromDate:self.datepicker.date];
    components = [calender components:flags fromDate:self.datepicker.date];
    hour = components.hour;
    minute = components.minute;
    NSLog(@"%ld時間 %ld分", hour, minute);
}

-(void)showtimerlabel{
    //タイマーラベルを表示する
    self.countdownlabel.text = [NSString stringWithFormat:@"%02ld:%02ld.%02ld",hours,minuts,seconds];
}

-(void)mainasushowtimerlabel{
    //マイナスのタイマーラベルを表示する
    self.countdownlabel.text = [NSString stringWithFormat:@"- %02ld:%02ld.%02ld",hours,minuts,seconds];
}

-(void)showstartlabel{
    self.startlabel.text = @"ミッションスタート";
    
}



-(void)PreiseVoice//賞賛音声の入れ物です。
{
    CFBundleRef maingundle = CFBundleGetMainBundle();
    CFURLRef soundfileURLRef;
    soundfileURLRef = CFBundleCopyResourceURL(maingundle, (CFStringRef)@"GoodJobMen",CFSTR("mp3"),NULL);
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundfileURLRef, &soundID);
    AudioServicesPlaySystemSound(soundID);
    
}

-(void)ScoldVoice//叱責音声の入れ物です。
{
    CFBundleRef maingundle = CFBundleGetMainBundle();
    CFURLRef soundfileURLRef;
    soundfileURLRef = CFBundleCopyResourceURL(maingundle, (CFStringRef)@"YouNeedMoreEffort",CFSTR("mp3"),NULL);
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundfileURLRef, &soundID);
    AudioServicesPlaySystemSound(soundID);
    
}


- (IBAction)btnA:(UIButton*)sender
{
    [self PreiseVoice];
    
}
- (IBAction)btnB:(UIButton*)sender
{
    [self ScoldVoice];
    
}
























@end

