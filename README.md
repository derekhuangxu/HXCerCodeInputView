# HXCerCodeInputView

![](https://img.shields.io/badge/License-MIT-green.svg)
![](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
![](https://img.shields.io/cocoapods/v/HXCerCodeInputView.svg?style=popout)


验证码输入框

用于输入短信验证码以及密码等功能
## How to use
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
 键盘相应验证码输入控件
 */
- (void)captchaInputViewBecomeActive;

/**
 输入数字达到限制后执行的回调
 */
@property (copy, nonatomic) cerCodeInputFinished inputFinishedBlock;


## Installation

HXCerCodeInputView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HXCerCodeInputView'
```

## License

HXCerCodeInputView is available under the MIT license. See the LICENSE file for more info.
