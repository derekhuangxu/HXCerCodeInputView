//
//  HXCerCodeInputView.h
//  HXCerCodeInputView
//
//  Created by Derek on 2017/12/13.
//  Copyright © 2017年 Derek. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^cerCodeInputFinished)(NSString *inputCode);

@interface HXCerCodeInputView : UIView


/**
 初始化输入框

 @param frame 输入框的frame
 @param verCodeNum 验证码数量
 @param inputFieldWidth 验证码显示框的宽度
 @param isSecure 是否需要显示加密
 @return 输入框
 */
- (instancetype)initWithFrame:(CGRect)frame verCodeNum:(NSInteger)verCodeNum inputFieldWidth:(CGFloat)inputFieldWidth isSecure:(BOOL)isSecure;


/**
 清除所有已输入的内容
 */
- (void)clearInput;

/**
 输入数字达到限制后执行的回调
 */
@property (copy, nonatomic) cerCodeInputFinished inputFinishedBlock;

@end
