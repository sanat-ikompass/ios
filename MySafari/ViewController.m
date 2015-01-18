//
//  ViewController.m
//  MySafari
//
//  Created by sanat on 16/01/15.
//  Copyright (c) 2015 iKompass. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize webView, urlTextField, backButton, forwardButton, lastOffsetY;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateWebViewControls];
    webView.scrollView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //1. Hide the keyboard by forcing the textField to resign as first responder
    [textField resignFirstResponder];
    NSURL *url = nil;
    //2. Check if the user has entered a string with http://
    if([textField.text hasPrefix:@"http://"]){
    //3. If yes, then instantiate url with that value.
        url = [NSURL URLWithString:textField.text];
    }else{
    //4. If no, then append http:// to whatever string user has provided.
        NSString *urlString = [NSString stringWithFormat:@"http://%@", textField.text ];
        url = [NSURL URLWithString:urlString];
    }
    //5. Create an object of NSURLRequest using the NSURL's object
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    //6. Ask WebView to execute the given urlRequest
    [webView loadRequest:urlRequest];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self updateWebViewControls];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateWebViewControls];
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateWebViewControls];
}

- (IBAction)onForwardButtonPressed:(id)sender {
    
    [webView goForward];
}

- (IBAction)onBackButtonPressed:(id)sender {
    [webView goBack];
}

- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [webView stopLoading];

}

- (IBAction)onReloadButtonPressed:(id)sender {
    [webView reload];
}

-(void)updateWebViewControls{
    backButton.enabled = [webView canGoBack];
    forwardButton.enabled = [webView canGoForward];
    //1. We are reading request property of the webView
    //2. Then we are reading its URL and extracting the
    //   string equivalent from it.
    urlTextField.text = webView.request.URL.absoluteString;
}


- (IBAction)onComingSoonButtonPressed:(id)sender {
    //1. Create an instance of UIAlertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Coming soon !" preferredStyle:UIAlertControllerStyleAlert];
    //2. UIAlertAction adds a button to the UIAlertController.
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    //3. Add the created alertAction to alertController.
    [alertController addAction:alertAction];
    //4. Show the AlertViewController by calling the presentViewController method
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //1. Check if the lastOffsetY is set or it is the first time view is loaded
    if(lastOffsetY >= 0){
        //2. Compare the current value and the previous value
        if (lastOffsetY > scrollView.contentOffset.y){
            //3. User seems to be scrolling down. Hide the textField.
            urlTextField.hidden = NO;
        }else{
            //4. Else, show the textField
            urlTextField.hidden = YES;
        }
    }else{
        //5. If it is the first time view is loaded, show the textField
        urlTextField.hidden = NO;
    }
    //6. Set the current offset in lastOffsetY
    lastOffsetY = scrollView.contentOffset.y;
}


@end
