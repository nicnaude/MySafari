//
//  WebViewViewController.m
//  MySafari
//
//  Created by Nicholas Naudé on 12/01/2016.
//  Copyright © 2016 Nicholas Naudé. All rights reserved.
//

#import "WebViewViewController.h"

@interface WebViewViewController () <UIWebViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadURL:(@"http://www.mobilemakers.co")];
    
    //NSURL *url = [NSURL URLWithString:@"http://www.mobilemakers.co"];
    //[self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    self.webView.delegate = self;
    // Do any additional setup after loading the view.
}
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Load fail"
                                                                             message:error.localizedDescription
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *goHomeButton = [UIAlertAction actionWithTitle:@"Go home"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             [self loadURL:@"http://www.mobilemakers.co"];
                                                         }];
    
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                               // cancel
                                                           }];
    [alertController addAction:goHomeButton];
    [alertController addAction:cancelButton];
    
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSURL *url = [NSURL URLWithString:textField.text];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    return YES;
}

- (void) loadURL: (NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

@end
