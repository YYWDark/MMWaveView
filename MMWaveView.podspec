Pod::Spec.new do |s|
  s.name         = 'YYCache'
  s.summary      = 'A Wave View used on iOS.'
  s.version      = '1.0.0'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'wyy' => 'wangyayun0629@163.com' }
  s.social_media_url = 'http://www.jianshu.com/u/786142888986'
  s.homepage     = 'https://github.com/YYWDark/MMWaveView'
  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.source       = { :git => 'https://github.com/YYWDark/MMWaveView.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'MMWaveView/*.{h,m}'
  s.frameworks = 'UIKit', 'CoreFoundation', 'QuartzCore' 

end
