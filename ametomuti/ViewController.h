//
//  ViewController.h
//  ametomuti
//
//  Created by ビザンコムマック０４ on 2014/09/12.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController
- (IBAction)button1:(UIButton *)sender;
- (IBAction)stopbutton:(UIButton *)sender;
- (IBAction)restartbutton:(UIButton *)sender;
- (IBAction)creabutton:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UILabel *countdownlabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datepicker;
- (IBAction)valuechangedpicker:(UIDatePicker *)sender;
- (IBAction)okbutton:(UIBarButtonItem *)sender;
@property(nonatomic, getter = isHidden)BOOL hidden;
@end


