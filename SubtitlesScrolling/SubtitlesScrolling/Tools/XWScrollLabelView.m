//
//  XWScrollLabelView.m
//  lunzi
//
//  Created by shengxinwei on 16/9/18.
//  Copyright © 2016年 JiTengTechnology. All rights reserved.
//

#import "XWScrollLabelView.h"
#define scrollViewH self.bounds.size.height
#define scrollTime 2.0
#define fontSize [UIFont systemFontOfSize:16.0]

@interface XWScrollLabelView ()
@property (nonatomic,strong) UILabel *upLabel;
@property (nonatomic,strong) UILabel *downLabel;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation XWScrollLabelView {
    NSInteger _index;
    NSInteger _recordIndex;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupScrollView];
    }
    return self;
}

- (void)setupScrollView {
    //设置滚动范围
    self.contentSize = CGSizeMake(0, self.bounds.size.height * 2);
    self.pagingEnabled = YES;
    
    self.upLabel = [[UILabel alloc] init];
    self.upLabel.font = fontSize;
    [self addSubview:_upLabel];
    self.downLabel = [[UILabel alloc] init];
    self.downLabel.font = fontSize;
    [self addSubview:_downLabel];
    
    //计算文字高度
    NSString *textStr = @"计算文字高度";
    //最大值
    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGFloat strHeight = [self sizeWithText:textStr textFont:fontSize textMaxSize:maxSize].height;
    NSLog(@"%f",strHeight);
    //设置label位置
    self.upLabel.frame = CGRectMake(0, (scrollViewH - strHeight)/2 , self.bounds.size.width, strHeight);
    self.downLabel.frame = CGRectMake(0, scrollViewH + (scrollViewH - strHeight)/2 , self.bounds.size.width, strHeight);
    //禁止手动拖拽
    self.scrollEnabled = NO;
    //开启定时器
    [self timer];
}

- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    self.upLabel.text= _dataArr[0];
    _index = 1;
}

#pragma mark - 定时器执行方法
- (void)autoRepeatScrollLabel {
    [UIView animateWithDuration:scrollTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.contentOffset = CGPointMake(0, scrollViewH);
        self.downLabel.text = self.dataArr[_index];
        _recordIndex = _index;
        [self checkDataIndex];
    } completion:^(BOOL finished) {
        self.upLabel.text = self.dataArr[_recordIndex];
          self.contentOffset = CGPointMake(0, 0);
        _index = _recordIndex;
        [self checkDataIndex];
    }];
}

//判断数据索引
- (void) checkDataIndex {
    _index ++ ;
    if (_index  >= self.dataArr.count) {
        _index = 0;
    }
}

#pragma mark - 懒加载
- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:scrollTime * 1.5 target:self selector:@selector(autoRepeatScrollLabel) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

#pragma mark - 计算文字高度 

/**
 计算文字得尺寸
 @param text    要计算得字符串
 @param font    计算字符串时按几号字体去计算
 @param maxSize 规定的最大尺寸
 @return 文字得真实尺寸
 */
- (CGSize)sizeWithText:(NSString *)text textFont:(UIFont *)font textMaxSize:(CGSize)maxSize {
    // 计算文字时要几号字体
    NSDictionary *attr = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}







@end
