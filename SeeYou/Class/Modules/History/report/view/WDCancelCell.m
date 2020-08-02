//
//  WDCancelCell.m
//  youbaner
//
//  Created by luzhongchang on 2017/9/20.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "WDCancelCell.h"

#import "WDReportModel.h"
@interface  WDCancelCell()
@property(nonatomic ,strong) UILabel * contentlabel;
@property(nonatomic ,strong) UIImageView * selectViewImage;
@end

@implementation WDCancelCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setUpview];
        [self subviewLayout];
        [self bindModel];
    }
    return self;
}

- (void) setUpview
{
    
    self.contentlabel =[UILabel labelWithText:@"" textColor:[UIColor tc31Color] fontSize:16 inView:self.contentView tapAction:nil];
    self.selectViewImage =[UIImageView imageViewWithImageName:@"payseled" inView:self.contentView];
    self.showBottomLine=YES;
}


-(void) subviewLayout
{
    @weakify(self);
    
    [self.contentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-40);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@16);
    }];
    
    [self.selectViewImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@24);
        make.right.equalTo(@24);
    }];
}


-(void)bindModel
{
    @weakify(self);
    [RACObserve(self, reportModel) subscribeNext:^(WDReportModel *  _Nullable x) {
     
        @strongify(self);
        if(x)
        {
            self.contentlabel.text = x.content;
            if(x.Selected)
            {
                self.selectViewImage.hidden=NO;
            }
            else
            {
                self.selectViewImage.hidden=YES;
            }
            
        }
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
