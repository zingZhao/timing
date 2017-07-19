//
//  ViewController.m
//  timing
//
//  Created by 赵奎博 on 2017/7/19.
//  Copyright © 2017年 赵奎博. All rights reserved.
//

#import "ViewController.h"
#import "ZkbDateView.h"
@interface ViewController ()<selectTimePickDelegate>
@property (nonatomic,strong) ZkbDateView * myPick;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 200, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"点击选择年月" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

- (void)show{
    [self.view addSubview:self.myPick];
}

- (void)sureAction:(NSString *)year month:(NSString *)month{
    NSLog(@"----%@年%@月\n",year,month);
    UIAlertController * avc = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"已选择%@年%@月",year,month] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alsure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [avc addAction:alsure];
    [self presentViewController:avc animated:year completion:nil];
}

- (ZkbDateView *)myPick{
    if(!_myPick){
        _myPick = [[ZkbDateView alloc]initWithFrame:self.view.bounds];
        _myPick.delegate = self;
    }
    
    return _myPick;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
