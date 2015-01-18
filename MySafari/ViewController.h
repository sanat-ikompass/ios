//
//  ViewController.h
//  MySafari
//
//  Created by sanat on 16/01/15.
//  Copyright (c) 2015 iKompass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)onForwardButtonPressed:(id)sender;
- (IBAction)onBackButtonPressed:(id)sender;

- (IBAction)onStopLoadingButtonPressed:(id)sender;
- (IBAction)onReloadButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
- (IBAction)onComingSoonButtonPressed:(id)sender;

@property CGFloat lastOffsetY;

@end

