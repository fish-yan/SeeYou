//
//  IndentituAuthenUploadIdentifyPhotoCell.m
//  youbaner
//
//  Created by luzhongchang on 17/8/1.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "IndentituAuthenUploadIdentifyPhotoCell.h"
#import "IndentituAuthenUploadIdentifyPhotoCellViewModel.h"


@interface IndentituAuthenUploadIdentifyPhotoCell ()
@property (nonatomic, strong) IndentituAuthenUploadIdentifyPhotoCellViewModel *viewModel;

@property (nonatomic, strong) UIImageView *iconImageview;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *exampleForwardView;

@property (nonatomic, strong) UIImageView *examplebackwardView;

@property (nonatomic, strong) UIImageView *forwardImageView;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIButton *commitButton;
@property (nonatomic, strong) UIButton *skipButton;
@property (nonatomic, assign) BOOL complete;


@end

@implementation IndentituAuthenUploadIdentifyPhotoCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.complete        = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self setUpview];
        [self subviewsLayout];
        [self bindmodel];
    }
    return self;
}


- (void)setUpview {
    @weakify(self);

    self.iconImageview = [UIImageView imageViewWithImageName:@"identifyicon1" inView:self.contentView];
    self.titleLabel    = [UILabel labelWithText:@"身份认证（请务必按样例上传照片）"
                                   textColor:[UIColor tc4a4a4aColor]
                                    fontSize:16
                                      inView:self.contentView
                                   tapAction:nil];

    NSMutableAttributedString *attrString =
    [[NSMutableAttributedString alloc] initWithString:@"身份认证（请务必按样例上传照片）"];
    [attrString addAttributes:@{
        NSFontAttributeName: [UIFont systemFontOfSize:12],
        NSForegroundColorAttributeName: [UIColor bg9b9b9bColor]
    }
                        range:[@"身份认证（请务必按样例上传照片）"
                              rangeOfString:@"（请务必按样例上传照片）"]];

    self.titleLabel.attributedText = attrString;


    self.exampleForwardView = [UIImageView imageViewWithImageName:@"pic_idcard"
                                                           inView:self.contentView
                                                        tapAction:^(UIImageView *imgView, UIGestureRecognizer *tap){

                                                        }];

    UILabel *exampleLabel = [UILabel labelWithText:@"手持正面（例）"
                                         textColor:[UIColor bg9b9b9bColor]
                                     textAlignment:NSTextAlignmentCenter
                                          fontSize:14
                                            inView:self.contentView
                                         tapAction:nil];
    [exampleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.exampleForwardView.mas_left);
        make.right.equalTo(self.exampleForwardView.mas_right);
        make.height.equalTo(@14);
        make.top.equalTo(self.exampleForwardView.mas_bottom).offset(15);
    }];

    self.examplebackwardView = [UIImageView imageViewWithImageName:@"identify"
                                                            inView:self.contentView
                                                         tapAction:^(UIImageView *imgView, UIGestureRecognizer *tap){

                                                         }];

    UILabel *examplebackLabel = [UILabel labelWithText:@"身份证正面（例）"
                                             textColor:[UIColor bg9b9b9bColor]
                                         textAlignment:NSTextAlignmentCenter
                                              fontSize:14
                                                inView:self.contentView
                                             tapAction:nil];
    [examplebackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.examplebackwardView.mas_left);
        make.right.equalTo(self.examplebackwardView.mas_right);
        make.height.equalTo(@14);
        make.top.equalTo(self.examplebackwardView.mas_bottom).offset(15);
    }];


    self.forwardImageView = [UIImageView imageViewWithImageName:@"addicon"
                                                         inView:self.contentView
                                                      tapAction:^(UIImageView *imgView, UIGestureRecognizer *tap) {
                                                          @strongify(self);
                                                          if (self.frowardblock) {
                                                              self.frowardblock();
                                                          }

                                                      }];


    UILabel *forwardleLabel = [UILabel labelWithText:@"身份证正面"
                                           textColor:[UIColor bg9b9b9bColor]
                                       textAlignment:NSTextAlignmentCenter
                                            fontSize:14
                                              inView:self.contentView
                                           tapAction:nil];
    [forwardleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.forwardImageView.mas_left);
        make.right.equalTo(self.forwardImageView.mas_right);
        make.height.equalTo(@14);
        make.top.equalTo(self.forwardImageView.mas_bottom).offset(15);
    }];

    self.backImageView = [UIImageView imageViewWithImageName:@"addicon"
                                                      inView:self.contentView
                                                   tapAction:^(UIImageView *imgView, UIGestureRecognizer *tap) {


                                                       @strongify(self);
                                                       if (self.backwardblock) {
                                                           self.backwardblock();
                                                       }
                                                   }];
    UILabel *backLabel = [UILabel labelWithText:@"身份证反面"
                                      textColor:[UIColor bg9b9b9bColor]
                                  textAlignment:NSTextAlignmentCenter
                                       fontSize:14
                                         inView:self.contentView
                                      tapAction:nil];
    [backLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.backImageView.mas_left);
        make.right.equalTo(self.backImageView.mas_right);
        make.height.equalTo(@14);
        make.top.equalTo(self.backImageView.mas_bottom).offset(15);
    }];


    [self.exampleForwardView.layer setMasksToBounds:YES];
    [self.exampleForwardView.layer setCornerRadius:2];
    [self.examplebackwardView.layer setMasksToBounds:YES];
    [self.examplebackwardView.layer setCornerRadius:2];


    [self.forwardImageView.layer setMasksToBounds:YES];
    [self.forwardImageView.layer setCornerRadius:2];


    [self.backImageView.layer setMasksToBounds:YES];
    [self.backImageView.layer setCornerRadius:2];

    self.commitButton = [UIButton buttonWithTitle:@"提交"
                                       titleColor:[UIColor whiteColor]
                                         fontSize:16
                                    normalImgName:nil
                                normalBgImageName:@"btn_bg"
                                           inView:self.contentView
                                           action:^(UIButton *btn) {
                                               //提交图片 跳转到 CommitVerfifyViewController 页面
                                               if (self.viewModel.forwardimage == nil) {
                                                   [WDProgressHUD showTips:@"您还没有选择正面照"];
                                                   return;
                                               }
                                               if (self.viewModel.backwardimage == nil) {
                                                   [WDProgressHUD showTips:@"您还没有选择背面照"];
                                                   return;
                                               }
                                               [WDProgressHUD showInView:nil];
                                               [self.viewModel.doRacommond execute:@"1"];

                                           }];

    self.skipButton = [UIButton buttonWithTitle:@"证件不在身边？暂时跳过"
                                     titleColor:[UIColor tcff8bb1Color]
                                       fontSize:16
                                        bgColor:[UIColor whiteColor]
                                         inView:self.contentView
                                         action:^(UIButton *btn) {
                                             [YSMediator pushToViewController:@"CommitVerfifyViewController"
                                                                   withParams:@{}
                                                                     animated:YES
                                                                     callBack:nil];
                                             //是会员
                                             // [YSMediator popToViewController:@"HYHomeViewController"];
                                         }];

    [self.skipButton.layer setMasksToBounds:YES];
    [self.skipButton.layer setBorderWidth:1];
    [self.skipButton.layer setBorderColor:[UIColor tcff8bb1Color].CGColor];


    [self.commitButton.layer setMasksToBounds:YES];
    [self.commitButton.layer setCornerRadius:2];
    [self.skipButton.layer setMasksToBounds:YES];
    [self.skipButton.layer setCornerRadius:2];
}


- (void)subviewsLayout {
    @weakify(self);
    [self.iconImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.contentView.mas_top).offset(47);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 18));
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.contentView.mas_top).offset(49);
        make.left.equalTo(self.iconImageview.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.equalTo(@16);
    }];
    float width = (SCREEN_WIDTH - 50 - 20) / 2;

    float scale = 0.8;

    [self.exampleForwardView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);

        make.left.equalTo(self.contentView.mas_left).offset(25);
        make.top.equalTo(self.iconImageview.mas_bottom).offset(25);
        make.size.mas_equalTo(CGSizeMake(width, width * scale));
    }];

    [self.examplebackwardView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);

        make.right.equalTo(self.contentView.mas_right).offset(-25);
        make.top.equalTo(self.iconImageview.mas_bottom).offset(25);
        make.size.mas_equalTo(CGSizeMake(width, width * scale));
    }];


    [self.forwardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);

        make.left.equalTo(self.exampleForwardView.mas_left);
        make.top.equalTo(self.exampleForwardView.mas_bottom).offset(25 + 25);
        make.size.mas_equalTo(CGSizeMake(width, width * scale));
    }];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);

        make.left.equalTo(self.examplebackwardView.mas_left);
        make.top.equalTo(self.exampleForwardView.mas_bottom).offset(25 + 25);
        make.size.mas_equalTo(CGSizeMake(width, width * scale));
    }];


    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.top.equalTo(self.forwardImageView.mas_bottom).offset(87 - 25);
        make.height.equalTo(@44);
    }];


    [self.skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.top.equalTo(self.commitButton.mas_bottom).offset(20);
        make.height.equalTo(@44);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
    }];
}

- (void)BindViewmodel:(HYBaseViewModel *)vm {
    if (vm && [vm isKindOfClass:[IndentituAuthenUploadIdentifyPhotoCellViewModel class]]) {
        self.viewModel = (IndentituAuthenUploadIdentifyPhotoCellViewModel *) vm;
        if (self.viewModel.forwardimage) self.forwardImageView.image = self.viewModel.forwardimage;
        if (self.viewModel.backwardimage) self.backImageView.image   = self.viewModel.backwardimage;
    }
}


- (void)bindmodel {
    @weakify(self);


    [RACObserve(self, source) subscribeNext:^(NSNumber *_Nullable x) {

        @strongify(self);
        if (self.source == 1) {
            self.skipButton.hidden = YES;
        }
    }];

    [RACObserve(self, viewModel.forwrdUrl) subscribeNext:^(NSURL *_Nullable x) {
        @strongify(self);
        if (x) {
            [self.forwardImageView sd_setImageWithURL:x placeholderImage:[UIImage imageNamed:@"addicon"]];
        }
    }];

    [RACObserve(self, viewModel.backwrdUrl) subscribeNext:^(NSURL *_Nullable x) {
        @strongify(self);
        if (x) {
            [self.backImageView sd_setImageWithURL:x placeholderImage:[UIImage imageNamed:@"addicon"]];
        }
    }];

    RAC(self.forwardImageView, image) = RACObserve(self, viewModel.forwardimage);

    RAC(self.backImageView, image) = RACObserve(self, viewModel.backwardimage);

    [RACObserve(self, viewModel.result) subscribeNext:^(WDResponseModel *_Nullable x) {
        [WDProgressHUD showTips:@"身份认证提交成功, 请等待审核"];
        //@strongify(self);
        if (x && ((NSArray *) x.data).count > 0) {
            NSString *go = [[NSUserDefaults standardUserDefaults] objectForKey:@"used"];
            if (go != nil) {
                return;
            }
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"used"];
            
            
//            if (self.source == 1) {
//                [YSMediator pushToViewController:@"HYUserCenterViewController"
//                                      withParams:nil
//                                        animated:YES
//                                        callBack:NULL];
//            } else {
//                //去支付
//                [YSMediator pushToViewController:@"CommitVerfifyViewController"
//                                      withParams:@{}
//                                        animated:YES
//                                        callBack:^{
//                                            @strongify(self);
//                                            self.complete = NO;
//                                        }];
//            }
        
        
        }

    }];

    [RACObserve(self, viewModel.error) subscribeNext:^(NSError *  _Nullable x) {
        [WDProgressHUD hiddenHUD];
       
        [WDProgressHUD showTips:x.localizedDescription];
    }];
    
}

@end
