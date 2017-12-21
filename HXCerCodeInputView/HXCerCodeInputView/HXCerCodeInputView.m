//
//  HXCerCodeInputView.m
//  HXCerCodeInputView
//
//  Created by Derek on 2017/12/13.
//  Copyright © 2017年 Derek. All rights reserved.
//

#import "HXCerCodeInputView.h"

static const NSUInteger tag_base = 20;//tag基础值
static const NSUInteger line_tag_base = 100;//tag基础值


@interface HXCerCodeInputView ()<UITextFieldDelegate>

@property (assign, nonatomic, getter=isCodeSecure) BOOL codeSecure;
@property (assign, nonatomic) NSInteger verCodeNum;
@property (assign, nonatomic) NSInteger inputFieldWidth;

@property (strong, nonatomic) UITextField *useTextField;
@property (strong, nonatomic) UIView *activeLine;
@property (weak, nonatomic) NSTimer *timer;

@end


@implementation HXCerCodeInputView

- (instancetype)initWithFrame:(CGRect)frame verCodeNum:(NSInteger)verCodeNum inputFieldWidth:(CGFloat)inputFieldWidth isSecure:(BOOL)isSecure
{
    self = [super initWithFrame:frame];
    if (self) {
        self.verCodeNum = verCodeNum;
        self.inputFieldWidth = inputFieldWidth;
        self.codeSecure = isSecure;
        [self createUI];
    }
    return self;
}

- (void)dealloc
{
    @try {
        if(self.timer){
            [self.timer invalidate];
            self.timer = nil;
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

- (void)createUI {
    [self checkPamameters];

    self.backgroundColor = [UIColor clearColor];
    
    CGFloat labelHeight = self.frame.size.height;
    CGFloat labelWidth = self.inputFieldWidth;
    CGFloat lineSpacing = (self.frame.size.width - labelWidth * self.verCodeNum) / (self.verCodeNum - 1);
    for (int i = 0; i< self.verCodeNum; i++) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.tag = tag_base + i;
        label.frame = CGRectMake((lineSpacing + labelWidth) * i, 0, labelWidth, labelHeight);
        [self addSubview:label];
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor blueColor];
        lineView.tag = line_tag_base + i;
        lineView.frame = CGRectMake((lineSpacing + labelWidth) * i, labelHeight, labelWidth, 1);
        [self addSubview:lineView];
    }

    self.useTextField = [[UITextField alloc] init];
    self.useTextField.textColor = [UIColor clearColor];
    self.useTextField.backgroundColor = [UIColor clearColor];
    self.useTextField.tintColor = [UIColor clearColor];
    self.useTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.useTextField.delegate = self;
    self.useTextField.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.useTextField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:self.useTextField];
    
    UIView *lineView = [self viewWithTag:line_tag_base];
    lineView.backgroundColor = [UIColor redColor];
    self.activeLine = lineView;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateLineView:) userInfo:nil repeats:YES];

}

- (void)checkPamameters {
    
    NSParameterAssert(self.verCodeNum);
    NSParameterAssert(self.inputFieldWidth);
    NSAssert(self.verCodeNum > 4, @"至少需要4个需要输入的验证码");
    NSAssert(self.inputFieldWidth > 20.f, @"请增大输入框宽度");
    NSAssert((self.inputFieldWidth * self.verCodeNum) < self.frame.size.width, @"请减小输入框宽度或者增大View的宽度");
}



/**
 处理值变化
 
 @param textField 接收输入
 */
- (void)valueChange:(UITextField *)textField {
    
    NSString *string = textField.text;
    for (int i = 0; i <= self.verCodeNum; i++) {
        UILabel *label = [self viewWithTag:tag_base + i];
        UIView *lineView = [self viewWithTag:line_tag_base + i];
        if ((lineView.tag - line_tag_base) == string.length) {
            self.activeLine = lineView;
        } else {
            lineView.backgroundColor = [UIColor blueColor];
        }

        if (i < string.length) {
            if (self.isCodeSecure) {
                if ([label.text isEqualToString:@"*"] || [label.text isEqualToString:[string substringWithRange:NSMakeRange(i, 1)]]) {

                } else {
                    label.text = [string substringWithRange:NSMakeRange(string.length - 1, 1)];
                    label.text = @"*";
                }
            } else {
                label.text = [string substringWithRange:NSMakeRange(i, 1)];
            }
        } else {
            label.text = @"";
        }
        
    }
    
    if (textField.text.length == self.verCodeNum) {
        if (self.inputFinishedBlock) {
            self.inputFinishedBlock(textField.text);
        }
    }
}


/**
 清空键盘
 */
- (void)clearInput {
    for (int i = 0; i <= self.verCodeNum; i++) {
        UILabel *label = [self viewWithTag:tag_base + i];
        label.text = @"";
    }
    self.useTextField.text = @"";
    for (int i = 0; i <= self.verCodeNum; i++) {
        UIView *lineView = [self viewWithTag:line_tag_base + i];
        if ((lineView.tag - line_tag_base) == 0) {
            self.activeLine = lineView;
        } else {
            lineView.backgroundColor = [UIColor blueColor];
        }
    }
}

#pragma mark - 键盘代理：验证字符、处理字符长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.location + string.length > self.verCodeNum) {
        return NO;
    }
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

- (void)updateLineView:(NSTimer *)timer {
    
    if (self.activeLine.backgroundColor == [UIColor blueColor]) {
        self.activeLine.backgroundColor = [UIColor redColor];
    } else {
        self.activeLine.backgroundColor = [UIColor blueColor];
    }
}

- (void)captchaInputViewBecomeActive {
    
    [self.useTextField becomeFirstResponder];
}


@end
