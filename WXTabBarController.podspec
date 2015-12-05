Pod::Spec.new do |spec|
  spec.name         = 'WXTabBarController'
  spec.version      = '0.1'
  spec.license      = 'MIT'
  spec.summary      = '在系统 UITabBarController 的基础上实现安卓版微信 TabBar 的滑动切换功能'
  spec.homepage     = 'https://github.com/leichunfeng/WXTabBarController'
  spec.author       = { 'leichunfeng' => '307213080@qq.com' }
  spec.source       = { :git => 'https://github.com/leichunfeng/WXTabBarController.git', :tag => 'v0.1' }
  spec.source_files = 'WXTabBarController/Source/*.{h,m}'
  spec.requires_arc = true
end
