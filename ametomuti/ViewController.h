//
//  ViewController.h
//  ametomuti
//
//  Created by ビザンコムマック０４ on 2014/09/12.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>


@interface ViewController : UIViewController<AVAudioPlayerDelegate>
- (IBAction)button1:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *countdownlabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datepicker;
@property (weak, nonatomic) IBOutlet UILabel *startlabel;
- (IBAction)valuechangedpicker:(UIDatePicker *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnA;
@property (weak, nonatomic) IBOutlet UIButton *btnB;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
- (IBAction)startbutton:(UIButton *)sender;
- (IBAction)creabutton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *creabuttonimage;
@property (weak, nonatomic) IBOutlet UIButton *startbuttonimage;
@end


