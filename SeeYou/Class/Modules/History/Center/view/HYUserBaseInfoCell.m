//
//  HYUserBaseInfoCell.m
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYUserBaseInfoCell.h"
#import "HYUserBaseInfoViewModel.h"

@interface  HYUserBaseInfoCell()
@property(nonatomic ,strong) UILabel * titleLabel;
@property(nonatomic ,strong) HYUserBaseInfoViewModel * viewModel;
@property(nonatomic ,strong) UIImageView * arrowView;
@property(nonatomic ,strong) UIView * topLine;
@property(nonatomic ,strong) UIView * Bottomline;

@end

@implementation HYUserBaseInfoCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setupView];
        [self subviewsLayout];
        [self bindmodel];
    
    }
    
    return self;
}
//50
- (void) setupView
{
    self.titleLabel= [UILabel labelWithText:@"" textColor:[UIColor tc7d7d7dColor] fontSize:15 inView:self.contentView tapAction:nil];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.infoLabel= [UILabel labelWithText:@"" textColor:[UIColor tc46aa78Color] fontSize:15 inView:self.contentView tapAction:nil];
    self.infoLabel.textAlignment = NSTextAlignmentRight;
    self.arrowView =[UIImageView imageViewWithImageName:@"arrowright" inView:self.contentView];
  
    

    
}

- (void) subviewsLayout
{
    @weakify(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(16);
        make.height.equalTo(@15);
        make.width.equalTo(@150);
        
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.contentView.mas_right).offset(-45);
        make.top.equalTo(self.contentView.mas_top).offset(16);
        make.height.equalTo(@15);
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        
        
    }];
    
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.contentView.mas_top).offset(16);
        make.height.equalTo(@14);
        make.width.equalTo(@8);
        
    }];
    
}

- (void) bindWithViewModel:(HYBaseViewModel *)vm
{

    if(vm && [vm isKindOfClass:[HYUserBaseInfoViewModel class]])
    {
       
         self.viewModel =(HYUserBaseInfoViewModel*)vm;
        
    }
    
}

- (void)bindmodel
{
    
        @weakify(self);
        
        RAC(self.titleLabel,text) =RACObserve(self,viewModel.title);
        RAC(self.infoLabel,text) =RACObserve(self,viewModel.value);
        [RACObserve(self, viewModel.hiddenArrow) subscribeNext:^(NSNumber *  _Nullable x) {
            
            @strongify(self);
            if(x)
            {
                self.arrowView.hidden  =[x boolValue];
                if([x boolValue])
                {
                    [self.infoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        @strongify(self);
                        make.right.equalTo(self.contentView.mas_right).offset(-15);
                        make.top.equalTo(self.contentView.mas_top).offset(16);
                        make.height.equalTo(@14);
                        make.left.equalTo(self.titleLabel.mas_right).offset(10);
                        
                        
                    }];
                }
            }
        }];


    

}

@end
