//
//  ViewController.m
//  SubtitlesScrolling
//
//  Created by shengxinwei on 16/9/23.
//  Copyright © 2016年 shengxinwei. All rights reserved.
//

#import "ViewController.h"
#import "XWScrollLabelView.h"

@interface ViewController ()

@property (nonatomic,strong) NSArray *arr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XWScrollLabelView *scrollLabelView = [[XWScrollLabelView alloc] initWithFrame:CGRectMake(0, 150,self.view.bounds.size.width,50)];
    scrollLabelView.dataArr = self.arr;
    [self.view addSubview:scrollLabelView];
    
}

#pragma mark -
- (NSArray *)arr {
    if (_arr == nil) {
        _arr = @[@"我是第0000000000000000",@"我是第11111111111111111111",@"我是第222222222222222222",@"有第33333333333333333?",@"4444444444444444444444444"];
    }
    return _arr;
}


@end
