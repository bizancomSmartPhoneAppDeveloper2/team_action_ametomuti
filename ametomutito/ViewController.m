//
//  ViewController.m
//  ametomutito
//
//  Created by ビザンコムマック０４ on 2014/09/21.
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
    AVAudioPlayer *audioPlayer;
    AVAudioPlayer *zero_audioPlayer;
    BOOL isZero;//00:00:00を通過したかどうか、マイナスカウントを行うために必要
    BOOL isAction;//タイマーが動作中かどうか
    BOOL isMainasuThree;
    
    AVAudioPlayer *PreiseVoiceAV;
    AVAudioPlayer *scoldVoiceAV;
    AVAudioPlayer *ScaredScoldVoiceAV;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initialaiza];//必要な初期化をまとめたメソッドを実行
    [self showdatepickerview];//ピッカータイマーを表示しておく
    [self defaultView];//デフォルトで見せたい画面を表示
    
    //タイマースタートと同時に効果音鳴らす
    NSError *error = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"piiii" ofType:@"MP3"];// 再生する audio ファイルのパスを取得
    // パスから、再生するURLを作成する
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];// auido を再生するプレイヤーを作成する
    // エラーが起きたとき
    if ( error != nil )
    {
        NSLog(@"Error %@", [error localizedDescription]);
    }
    [audioPlayer setDelegate:self];// 自分自身をデリゲートに設定
    
    //カウントダウン３秒前に鳴ったら効果音で知らせる
    NSError *error1 = nil;
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"pipipipiii" ofType:@"MP3"];// 再生する audio ファイルのパスを取得
    // パスから、再生するURLを作成する
    NSURL *url1 = [[NSURL alloc] initFileURLWithPath:path1];
    zero_audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url1 error:&error];// auido を再生するプレイヤーを作成する
    // エラーが起きたとき
    if ( error1 != nil )
    {
        NSLog(@"Error %@", [error1 localizedDescription]);
    }
    [zero_audioPlayer setDelegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button1:(UIButton *)sender {
    [timer invalidate];//一旦初期化の意味でタイマー止める
    [self initialaiza];//必要な変数の初期化
    [self animation];//アニメーション開始
    
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
            minuts = 30;
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
    [self isActionView];
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

- (IBAction)btnA:(UIButton*)sender
{
    [timer invalidate];
    [self initialaiza];
    [self defaultView];
    [self PreiseVoice];
}

- (IBAction)btnB:(UIButton*)sender
{
    [timer invalidate];
    [self initialaiza];
    [self defaultView];
    if (isMainasuThree) {
        [self ScaredScoldVoice];
    }else
        [self ScoldVoice];
}

- (IBAction)startbutton:(UIButton *)sender {
    [timer invalidate]; // タイマー動作中の可能性もあるので一旦タイマーを停止する
    //タイマー動作中の可能性もあるので初期化
    [self initialaiza];
    //datepickerの値を取り出してラベルに表示
    [self valuecatched];
    [self animation];
    
    minuts = minute;
    hours = hour;
    [self showtimerlabel];
    //タイマー始める
    [self timer];
    [self showstartlabel];
    [audioPlayer play];
    [self isActionView];
}

- (IBAction)creabutton:(UIButton *)sender {
    [timer invalidate];
    [self initialaiza];
    [self defaultView];
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
    
    if (isZero == NO && hours == 0 && minuts == 0 && seconds == 3) {
        [zero_audioPlayer play];
    }else
        nil;
    
}

-(void)mainasucount{
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
    if (isZero == YES && hours == 0 && minuts == 0 && seconds == 3) {
        isMainasuThree = YES;
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
    self.countdownlabel.text = [NSString stringWithFormat:@" %02ld %02ld %02ld",hours,minuts,seconds];
}

-(void)mainasushowtimerlabel{
    //マイナスカウントの時はラベルの文字を赤色にする
    self.countdownlabel.textColor = [UIColor redColor];
    self.animationlabel.textColor = [UIColor redColor];
    self.startlabel.textColor = [UIColor redColor];
    self.startlabel.text = @"ミッションピンチ！！";
    //マイナスのタイマーラベルを表示する
    self.countdownlabel.text = [NSString stringWithFormat:@"-%02ld %02ld %02ld",hours,minuts,seconds];
}

-(void)showstartlabel{
    self.startlabel.text = @"ミッションスタート";
}



-(void)PreiseVoice//賞賛音声の入れ物です。
{
    
    NSString *bgmPath = [[NSBundle mainBundle]
                         pathForResource:@"GoodJobMen" ofType:@"mp3"];
    NSURL *bgmUrl = [NSURL fileURLWithPath:bgmPath];
    PreiseVoiceAV = [[AVAudioPlayer alloc] initWithContentsOfURL:bgmUrl error:nil];
    [ PreiseVoiceAV setNumberOfLoops:0]; // 0なら1回だけ。－1ならエンドレスリピート。
    [NSThread sleepForTimeInterval:1];
    [ PreiseVoiceAV play];
    
 
}


-(void)ScoldVoice//叱責音声の入れ物です。
{
    
    NSString *bgmPath = [[NSBundle mainBundle]
                         pathForResource:@"WillBeOK" ofType:@"mp3"];
    NSURL *bgmUrl = [NSURL fileURLWithPath:bgmPath];
    scoldVoiceAV = [[AVAudioPlayer alloc] initWithContentsOfURL:bgmUrl error:nil];
    [scoldVoiceAV setNumberOfLoops:0]; // 0なら1回だけ。－1ならエンドレスリピート。
    [NSThread sleepForTimeInterval:1];
    [scoldVoiceAV play];
    
    
    

    
}



-(void)ScaredScoldVoice//叱責音声の入れ物です。
{
    
    NSString *bgmPath = [[NSBundle mainBundle]
                         pathForResource:@"YouNeedMoreEffort" ofType:@"mp3"];
    NSURL *bgmUrl = [NSURL fileURLWithPath:bgmPath];
    ScaredScoldVoiceAV = [[AVAudioPlayer alloc] initWithContentsOfURL:bgmUrl error:nil];
    [ScaredScoldVoiceAV setNumberOfLoops:0]; // 0なら1回だけ。－1ならエンドレスリピート。
    [NSThread sleepForTimeInterval:1];
    [ScaredScoldVoiceAV play];
    
    

    
}


//タイマー使用中に見せたい画面構成を準備
-(void)isActionView{
    self.datepicker.hidden = YES;
    self.btnA.hidden = NO;
    self.imageview.hidden = NO;
    self.startlabel.hidden = NO;
    self.countdownlabel.hidden = NO;
    self.startbuttonimage.hidden = YES;
    self.creabuttonimage.hidden = NO;
    self.animationlabel.hidden = NO;
}

//デフォルトで見せたい画面構成を準備
-(void)defaultView{
    self.datepicker.hidden = NO;
    self.countdownlabel.hidden = YES;
    self.imageview.hidden = YES;
    self.startbuttonimage.hidden = NO;
    self.creabuttonimage.hidden = YES;
    self.btnA.hidden = YES;
    self.btnB.hidden = YES;
    self.startlabel.hidden = YES;
    self.animationlabel.hidden = YES;
}

//変数の初期化がたびたび必要なものをまとめるメソッド
- (void)initialaiza{
    hours = 0;
    minuts = 0;
    seconds = 0;
    isZero = 0;
    isAction = 0;
}

//時刻の間の：をアニメーションにする
-(void)animation{
    self.animationlabel.text = @"  :    :";
    UIViewAnimationOptions animeOptions =
    UIViewAnimationCurveEaseInOut
    | UIViewAnimationOptionAutoreverse
    | UIViewAnimationOptionRepeat;
    [UIView animateWithDuration:1.0
                          delay:0
                        options:animeOptions
                     animations:^{
                         self.animationlabel.alpha = 0.0;
                     }completion:nil];
    
}

-(IBAction)gobackhome:(UIStoryboardSegue *)segue{
    
}

@end