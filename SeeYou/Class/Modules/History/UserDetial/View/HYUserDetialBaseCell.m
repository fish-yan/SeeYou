//
//  HYUserDetialBaseCell.m
//  youbaner
//
//  Created by luzhongchang on 17/8/2.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYUserDetialBaseCell.h"
#import "WDLinkView.h"
#import "HYUserdetialBaseinfoViewModel.h"
@interface HYUserDetialBaseCell()
@property(nonatomic,strong) WDLinkView *linkView;

@property(nonatomic ,strong) UILabel *titleLabel;
@property(nonatomic ,strong) HYUserdetialBaseinfoViewModel * viewModel;

@end

@implementation HYUserDetialBaseCell

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
    
        self.backgroundColor =[UIColor whiteColor];
        [self setUpview];
        [self subviewslayout];
        
    }
    return self;
}

- (void) setUpview
{
    
    self.titleLabel=[UILabel labelWithText:@"基本资料" textColor:[UIColor tc31Color] fontSize:15 inView:self.contentView tapAction:nil];
    self.linkView =[[WDLinkView alloc] initWithFrame:CGRectMake(75, 0, SCREEN_WIDTH-90, 0)];
    self.linkView.baseParentpoint = 20;
    self.linkView.borderColor =[UIColor clearColor];
    self.linkView.labelColor =[UIColor tc7d7d7dColor];
    self.linkView.bgColor =[UIColor bgf5f5f5Color];
    self.linkView.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:self.linkView];
    self.linkView.dataArray =@[];
    UIView * line =[UIView viewWithBackgroundColor:[UIColor bgf5f5f5Color] inView:self.contentView];
    @weakify(self);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

- (void) subviewslayout
{
    self.titleLabel.frame = CGRectMake(15, 20, 60, 15);
    
}


- (void)  bindWithViewModel:(HYBaseViewModel *)vm
{
    if(vm && [vm isKindOfClass:[HYUserdetialBaseinfoViewModel class]])
    {
            self.viewModel =(HYUserdetialBaseinfoViewModel*)vm;
        
            NSArray * array = ((HYUserdetialBaseinfoViewModel*)vm).array;
            NSMutableArray *tem=[NSMutableArray new];
            for (int i=0; i<array.count; i++) {
                if([array objectAtIndex:i] ==[NSNull null])
                {
                continue;
                }
                [tem addObject:[array objectAtIndex:i]];
            
            }
            [self.linkView upContent:[tem copy]];
    }
    
}


+(CGFloat) getHeight:(HYBaseViewModel *)vm
{
    
     WDLinkView *linkView =[[WDLinkView alloc] initWithFrame:CGRectZero];
     linkView.baseParentpoint = 10;
    
    NSArray * array = ((HYUserdetialBaseinfoViewModel*)vm).array;
    NSMutableArray *tem=[NSMutableArray new];
    for (int i=0; i<array.count; i++) {
        if([array objectAtIndex:i] ==[NSNull null])
        {
            continue;
        }
        [tem addObject:[array objectAtIndex:i]];
        
    }
    
    
     [linkView upContent:[tem copy]];
    return linkView.totalHeight +20;

}


@end
