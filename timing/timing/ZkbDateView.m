//
//  ZkbDateView.m
//  ZkbPickView
//
//  Created by 赵奎博 on 2017/3/10.
//  Copyright © 2017年 赵奎博. All rights reserved.
//

#import "ZkbDateView.h"
//主屏的宽
#define DEF_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

// 主屏的高
#define DEF_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

//主色调
#define NAVColor  [UIColor colorWithRed:24/255.00 green:153/255.00 blue:80/255.00 alpha:1]

@implementation ZkbDateView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
        self.userInteractionEnabled = YES;
        
        //规则
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        
        //时间戳转时间的方法
        //NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[NSDate date]];
        //匹配时间规则
        NSString *confromTimespStr = [formatter stringFromDate:[NSDate date]];
        //NSLog(@"time =  %@",confromTimespStr);
        
        NSArray * array = [confromTimespStr componentsSeparatedByString:@" "];
        
        NSArray * arraytwo = [array[0] componentsSeparatedByString:@"-"];
        self.myyear = arraytwo[0];
        self.mymonth = arraytwo[1];
        //self.myday = @"1";
        
        self.startYear = self.myyear;
        self.startmonth = self.mymonth;
        
        [self dataSource];
        
        [self.yearTableView selectRow:year_array.count - 1 inComponent:0 animated:NO];
        [self.yearTableView selectRow:self.startmonth.integerValue - 1 inComponent:1 animated:NO];
        [self addSubview:self.dataView];
    }
    
    return self;
}

-(UIView *)dataView{
    if(!_dataView){
        _dataView = [[UIView alloc]initWithFrame:CGRectMake(0, DEF_SCREEN_HEIGHT - 280, DEF_SCREEN_WIDTH, 280)];
        _dataView.backgroundColor = [UIColor whiteColor];
        _dataView.userInteractionEnabled = YES;
        
        [_dataView addSubview:self.topView];
        [_dataView addSubview:self.cancleButton];
        [_dataView addSubview:self.sureButton];
        
        UILabel * labelLine = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH / 2 - 0.5, 60, 1, 170)];
        labelLine.backgroundColor = [UIColor grayColor];
        [_dataView addSubview:labelLine];
        [_dataView addSubview:self.selectView];
        [_dataView addSubview:self.yearTableView];
    }
    
    return _dataView;
}

-(UILabel *)topView{
    if(!_topView){
        _topView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 40)];
        _topView.backgroundColor = NAVColor;
        _topView.userInteractionEnabled = YES;
        _topView.textColor = [UIColor whiteColor];
        _topView.textAlignment = NSTextAlignmentCenter;
        _topView.text = @"请选择年月";
    }
    
    return _topView;
}

-(UIButton *)cancleButton{
    if(!_cancleButton){
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.frame = CGRectMake(0, 0, 80, 40);
        [_cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancleButton;
}

- (void)cancleAction:(UIButton *)button{
    
    [self removeFromSuperview];

}

-(UIButton *)sureButton{
    if(!_sureButton){
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.frame = CGRectMake(DEF_SCREEN_WIDTH - 80, 0, 80, 40);
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureButton setTitle:@"确认" forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _sureButton;
}

- (void)sureAction:(UIButton *)button{
    NSLog(@"确认");
    [self.delegate sureAction:self.myyear month:self.mymonth];
    [self removeFromSuperview];
}

-(UIView *)selectView{
    if(!_selectView){
        _selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 120, DEF_SCREEN_WIDTH, 30)];
        _selectView.layer.borderWidth = 1.0;
        _selectView.layer.borderColor = NAVColor.CGColor;
        _selectView.backgroundColor = [UIColor colorWithRed:24/255.00 green:153/255.00 blue:80/255.00 alpha:0.1];
    }
    
    return _selectView;
}

-(UIPickerView *)yearTableView{
    if(!_yearTableView){
        _yearTableView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 55, DEF_SCREEN_WIDTH, 160)];
        _yearTableView.backgroundColor = [UIColor clearColor];
        _yearTableView.delegate = self;
        _yearTableView.dataSource = self;
    }
    
    return _yearTableView;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
    {
        return year_array.count;
    }
    if(component == 1)
    {
        if([self.myyear isEqualToString:self.startYear]){
            if(self.mymonth.integerValue > self.startmonth.integerValue){
                self.mymonth = self.startmonth;
            }
            return self.startmonth.integerValue;
        }
        return mouth_array.count;
    }
    
    return year_array.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel * label = [[UILabel alloc]init];
    if(component == 0)
    {
        label.text = [NSString stringWithFormat:@"%@年",year_array[row]];
    }
    if(component == 1)
    {
        label.text = [NSString stringWithFormat:@"%@月",mouth_array[row]];
    }
    
    label.textAlignment  =NSTextAlignmentCenter;
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"%ld ====== %ld",row,component);
    
    if(component == 0)
    {
        NSString * str = year_array[row];
        
        self.myyear = str;
        [pickerView reloadComponent:1];
    }
    
    if(component == 1)
    {
        now_month = row;
        
        self.mymonth = [NSString stringWithFormat:@"%ld",row + 1];
    }
    
    NSLog(@"%ld",month);
    
}

-(void)dataSource
{
    year_array = [[NSMutableArray alloc]init];
    mouth_array= [[NSMutableArray alloc]init];
    
    month = 1;
    now_month = 1;
    
    for(int i= 2000; i <= self.startYear.intValue; i++)
    {
        NSString * str = [[NSString alloc]initWithFormat:@"%d",i];
        [year_array addObject:str];
    }
    for(int i = 1; i < 13; i++)
    {
        NSString * str = [[NSString alloc]initWithFormat:@"%d",i];
        [mouth_array addObject:str];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
