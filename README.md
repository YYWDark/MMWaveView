##使用规则：
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
