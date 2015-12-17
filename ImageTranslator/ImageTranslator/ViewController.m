//
//  ViewController.m
//  ImageTranslator
//
//  Created by Wen Xu on 11/29/15.
//  Copyright (c) 2015 Aerodyne Research, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Create your Tesseract object using the initWithLanguage method:
    G8Tesseract* tesseract = [[G8Tesseract alloc] initWithLanguage:@"eng+ita"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
