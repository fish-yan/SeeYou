//
//  CPUploadView.m
//  CPPatient
//
//  Created by luzhongchang on 2017/8/30.
//  Copyright © 2017年 Jam. All rights reserved.
//

#import "CPUploadView.h"
@interface CPUploadView ()
@property(nonatomic ,strong) UIView * bgView;
@property(nonatomic ,strong) UIImageView * addImageView;
@property(nonatomic ,strong) UILabel * titleLable;
@property(nonatomic ,strong) UILabel *desLabel;
@property(nonatomic ,strong) UIImageView * UploadImageView;
@end

@implementation CPUploadView

- (id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if(self)
    {
        [self setUpview];
        [self subviewsLayout ];
    }
    return self;
}


- (void)setUpview
{
    self.bgView =[UIView viewWithBackgroundColor:[UIColor whiteColor] inView:self];
    self.addImageView = [UIImageView imageViewWithImageName:@"img添加图片" inView:self];
    self.addImageView.userInteractionEnabled=YES;
    self.titleLable =[UILabel labelWithText:@"" textColor:[UIColor redColor] fontSize:16 inView:self tapAction:nil];
    self.desLabel = [UILabel labelWithText:@"" textColor:[UIColor redColor] fontSize:14 inView:self tapAction:nil];
    self.desLabel.numberOfLines=0;
    self.UploadImageView =[UIImageView imageViewWithImageName:@"" inView:self];
    self.UploadImageView.hidden=YES;
    self.UploadImageView.contentMode=UIViewContentModeScaleAspectFit;
    self.UploadImageView.userInteractionEnabled=YES;
    [self.addImageView addGestureRecognizer:[self createges]];
    [self.UploadImageView addGestureRecognizer:[self createges]];
    
}

-(UITapGestureRecognizer *) createges
{
    UITapGestureRecognizer * ges =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEvent)];
    return ges;
}


-(void)clickEvent
{

    if(self.block)
    {
        self.block();
    }
}

-(void) subviewsLayout
{
    @weakify(self);
    
    [self.bgView  mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@109);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(15);
        make.height.equalTo(@79);
        make.width.equalTo(@79);
    }];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.addImageView.mas_right).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(self.mas_top).offset(24.5);
        make.height.equalTo(@16);
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.addImageView.mas_right).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(self.titleLable.mas_bottom).offset(8);
    }];
    
    [self.UploadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left).offset(20);
        make.top.equalTo(self.mas_top).offset(20);
        make.size.mas_offset(CGSizeMake(670,480));
    }];
    
}


-(void) setPicurl:(NSString *)picurl
{
    if(self.picurl.length >0)
    {
        [self hideview];
        [self.UploadImageView sd_setImageWithURL:[NSURL URLWithString:picurl] placeholderImage:[UIImage imageNamed:@""]];

        self.UploadImageView.hidden=NO;
        
        float scale= (750-80)/480;
        float height = (SCREEN_WIDTH-80)/scale;
        @weakify(self);
        
        [self.UploadImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.equalTo(self.mas_left).offset(20);
            make.top.equalTo(self.mas_top).offset(20);
            make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-40, height));
            
        }];
        
        [self.bgView  mas_remakeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top);
            make.height.mas_equalTo(height+40);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
    }
}


-(void) setPicimage:(UIImage *)picimage
{
    self.uploadImage  = picimage;
    [self hideview];
    self.UploadImageView.image=picimage;
    self.UploadImageView.hidden=NO;
    
    float scale= (750-80)/480;
    float height = (SCREEN_WIDTH-80)/scale;
    @weakify(self);
    
    
    
    [self.UploadImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left).offset(20);
        make.top.equalTo(self.mas_top).offset(20);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-40, height));
       
    }];
    
    [self.bgView  mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(height+40);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
}


- (void) hideview
{
    self.addImageView.hidden=YES;
    self.titleLable.hidden=YES;
    self.desLabel.hidden = YES;
}


- (void)setTitleString:(NSString *)titleString
{
    self.titleLable.text =titleString;
}

- (void)setDesString:(NSString *)desString
{
    self.desLabel.text= desString;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
