
Pod::Spec.new do |s|
    s.name         = 'HXCerCodeInputView'
    s.version      = '0.1.0'
    s.summary      = '验证码输入控件'
    s.homepage     = 'https://github.com/derekhuangxu/HXCerCodeInputView.git'
    s.license      = 'MIT'
    s.authors      = {'huangxu' => 'huangwade3@huangwade3@163.com.com'}
    s.platform     = :ios, '9.0'
    s.source       = {:git => 'https://github.com/derekhuangxu/HXCerCodeInputView.git', :tag => s.version}
    s.source_files = 'HXCerCodeInputView/**/Sources/*.{h,m}'
    s.requires_arc = true
end
