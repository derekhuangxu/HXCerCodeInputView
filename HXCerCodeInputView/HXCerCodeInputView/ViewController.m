//
//  ViewController.m
//  HXCerCodeInputView
//
//  Created by Derek on 2017/12/13.
//  Copyright © 2017年 Derek. All rights reserved.
//

#import "ViewController.h"
#import "HXCerCodeInputView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    HXCerCodeInputView *inputView = [[HXCerCodeInputView alloc] initWithFrame:CGRectMake(48.f, 100.f, self.view.bounds.size.width - 48.f * 2, 37.f)
                                                                   verCodeNum:6
                                                              inputFieldWidth:27.f
                                                                     isSecure:YES];
    inputView.inputFinishedBlock = ^(NSString *inputCode) {
        NSLog(@"%@",inputCode);
    };
    [self.view addSubview:inputView];
    
    UIButton *clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 50, 20)];
    clearBtn.titleLabel.text = @"清除已经输入的内容";
    clearBtn.backgroundColor = [UIColor blueColor];
    clearBtn.tintColor = [UIColor yellowColor];
    [clearBtn addTarget:inputView action:@selector(clearInput) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearBtn];    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
