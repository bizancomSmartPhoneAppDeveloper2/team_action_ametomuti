//
//  ViewController.h
//  ametomutito
//
//  Created by ビザンコムマック０４ on 2014/09/21.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface ViewController : UIViewController<AVAudioPlayerDelegate>
- (IBAction)button1:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *countdownlabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datepicker;
@property (weak, nonatomic) IBOutlet UILabel *startlabel;
@property (weak, nonatomic) IBOutlet UILabel *animationlabel;
- (IBAction)valuechangedpicker:(UIDatePicker *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnA;
- (IBAction)btnB:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnB;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
- (IBAction)startbutton:(UIButton *)sender;
- (IBAction)creabutton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *creabuttonimage;
@property (weak, nonatomic) IBOutlet UIButton *startbuttonimage;
@property (weak, nonatomic) IBOutlet UIButton *threeminuts;
@property (weak, nonatomic) IBOutlet UIButton *fiveminuts;
@property (weak, nonatomic) IBOutlet UIButton *eirhtminuts;
@property (weak, nonatomic) IBOutlet UIButton *trnminuts;
@property (weak, nonatomic) IBOutlet UIButton *thirtyminuts;
@property (weak, nonatomic) IBOutlet UIButton *ahour;
@property (weak, nonatomic) IBOutlet UIButton *ahourandthirty;
@property (weak, nonatomic) IBOutlet UIButton *twohours;
@property (weak, nonatomic) IBOutlet UIButton *threehours;
@property (weak, nonatomic) IBOutlet UIButton *fivehours;
@end
