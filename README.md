##Demo效果：

![Demo效果.gif](http://upload-images.jianshu.io/upload_images/307963-77440d5ef9003846.gif?imageMogr2/auto-orient/strip)
##Installation
1.using CocoaPods:
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'MMWaveView'
end
```
2.by cloning the project into your repository


##How To Use：
```
 #import "MMWaveView.h"
 MMWaveView *view = [[MMWaveView alloc] initWithFrame:self.view.bounds];
 view.delegate = self;
 [self.view addSubview:view];

#pragma mark - MMWaveViewDelegate
- (void)waveViewTriggerAction:(MMWaveView *)waveView{
  NSLog(@"respond to event action");
}
```
当原有工程的某个视图想有这个功能只需要继承`MMWaveView`即可。

##事件响应:
当手指离开屏幕，整个箭头出现在屏幕则会触发事件响应回调
简书：
http://www.jianshu.com/p/1be3bee0d6ae
