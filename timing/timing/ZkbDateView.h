//
//  ZkbDateView.h
//  ZkbPickView
//
//  Created by 赵奎博 on 2017/3/10.
//  Copyright © 2017年 赵奎博. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol selectTimePickDelegate <NSObject>

-(void)sureAction:(NSString *)year month:(NSString *)month;

@end

@interface ZkbDateView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray * year_array;
    NSMutableArray * mouth_array;
    
    NSInteger now_month;
    NSInteger month;
}
/**
 本类视图为最基层的灰色覆盖，所有的属性均显示在该上方
 
 下方所有属性均可单独更改
 */

//所有下部显示的父类
@property (nonatomic,strong) UIView * dataView;

//顶部视图 显示title 承载取消、确认按钮
@property (nonatomic,strong) UILabel * topView;

//取消按钮
@property (nonatomic,strong) UIButton * cancleButton;

//确认按钮
@property (nonatomic,strong) UIButton * sureButton;

//该属性为滑动列表的底框，模拟选中的效果
@property (nonatomic,strong) UIView * selectView;

//年份列表
@property (nonatomic,strong) UIPickerView * yearTableView;

//确认事件
@property (nonatomic,assign) id<selectTimePickDelegate> delegate;

@property (nonatomic,copy) NSString * myyear;
@property (nonatomic,copy) NSString * mymonth;

@property (nonatomic,copy) NSString * startYear;
@property (nonatomic,copy) NSString * startmonth;

@end
