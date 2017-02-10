//
//  MMWaveView.h
//  CADisplayLinkDemo
//
//  Created by wyy on 16/11/15.
//  Copyright © 2016年 yyx. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MMWaveViewDelegate;

@interface MMWaveView : UIView
@property (nonatomic, weak) id<MMWaveViewDelegate> delegate;
@end

@protocol MMWaveViewDelegate <NSObject>
- (void)waveViewTriggerAction:(MMWaveView *)waveView;
@end