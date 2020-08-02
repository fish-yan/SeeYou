//
//  HYAlertViewController.m
//  youbaner
//
//  Created by luzhongchang on 17/8/1.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYAlertViewController.h"



@implementation HYAlertAnimator
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    HYAlertViewController * selectVC = nil;
    
    UIView *view = [transitionContext containerView];
    if (toVC.isBeingPresented) {
        [view addSubview:toView ];
        selectVC = (HYAlertViewController *)toVC;
        selectVC.maskView.alpha=0;
        [UIView animateWithDuration:0.5
                              delay:0 usingSpringWithDamping:1
              initialSpringVelocity:1
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             selectVC.maskView.alpha=1;
                             selectVC.alertView.center = view.center;
                         }
                         completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                             
                         }];
    }
    else
    {
        selectVC = (HYAlertViewController *)fromVC;
        
        float hieght =[HYAlertViewController getHeightLineWithString:selectVC.message withWidth:SCREEN_WIDTH -120 withFont:selectVC.messageLabel.font];
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             selectVC.maskView.alpha=0;
                             
                             if(selectVC.alertTitle.length==0)
                                 selectVC.alertView.frame=CGRectMake(30, SCREEN_HEIGHT, SCREEN_WIDTH-60, hieght+ 33+85 );
                             else
                             {
                                 selectVC.alertView.frame=CGRectMake(30, SCREEN_HEIGHT, SCREEN_WIDTH-60, hieght+ 33+85+38 );
                             }
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    }
    
    
    
    
}

@end

/***************************/
@interface HYAlertViewController ()
@property (nonatomic ,strong) HYAlertAnimator * animator;
@property (nonatomic ,strong) UILabel *titleLabel;
@property(nonatomic ,strong) UIButton *cancelButton;
@property(nonatomic ,strong) UIButton *sureButton;
@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic ,strong) UIView * stickView;

@property(nonatomic,copy) CancelBlock cancelBlock;
@property(nonatomic,copy) SureBlock   sureBlock;
@end

@implementation HYAlertViewController

- (instancetype)init
{
    if(self =[super init])
    {
        [self initialize];
    }
    return self;
}
- (void)initialize {
    self.animator = [[HYAlertAnimator alloc] init];
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self.animator;
    
    self.type =HYALERTTYPETWO;
    self.leftButtonTitle=@"取消";
    self.leftTitleColor =[UIColor tc31Color];
    self.rightButtonTitle=@"确定";
    self.rightTitleColor =[UIColor tc31Color];
    self.fontsize=16;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor clearColor];
    [self setUpview];
    [self subviewsLayout];
   
    // Do any additional setup after loading the view.
}


- (void) setUpview
{

    @weakify(self);
    self.maskView =[UIView viewWithBackgroundColor:[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.7] inView:self.view tapAction:^(UIView *view, UIGestureRecognizer *tap) {
            @strongify(self);
            [self dismissViewControllerAnimated:YES completion:nil];
    }];
    self.maskView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.maskView];
        
        
    self.alertView=[UIView viewWithBackgroundColor:[UIColor whiteColor] inView:self.view];

    [self.alertView.layer setMasksToBounds:YES];
    [self.alertView.layer setCornerRadius:5];
    
    
    self.titleLabel =[UILabel labelWithText:self.alertTitle textColor:[UIColor tc31Color] fontSize:18 inView:self.alertView tapAction:nil];
    self.titleLabel.textAlignment= NSTextAlignmentCenter;
    self.titleLabel.numberOfLines=1;
    
    self.messageLabel =[UILabel labelWithText:self.message textColor:[UIColor tc31Color] fontSize:14 inView:self.alertView tapAction:nil];
    self.messageLabel.textAlignment= NSTextAlignmentCenter;
    self.messageLabel.numberOfLines=0;
    
    self.lineView=[UIView viewWithBackgroundColor:[UIColor line0Color] inView:self.alertView];
    
    
    
    self.cancelButton =[UIButton buttonWithTitle:self.leftButtonTitle titleColor:self.leftTitleColor fontSize:self.fontsize bgColor:[UIColor bgf7f7f7Color] inView:self.alertView action:^(UIButton *btn) {
        @strongify(self);
            [self dismissViewControllerAnimated:YES completion:nil];
            if(self.cancelBlock)
            {
                self.cancelBlock();
            }
    }];
    
    
    self.sureButton =[UIButton buttonWithTitle:self.rightButtonTitle  titleColor:self.rightTitleColor fontSize:self.fontsize bgColor:[UIColor bgf7f7f7Color] inView:self.alertView action:^(UIButton *btn) {
        
        @strongify(self);
            [self dismissViewControllerAnimated:YES completion:nil];
            if(self.sureBlock)
            {
                self.sureBlock();
            }
    }];
    
    self.stickView=[UIView viewWithBackgroundColor:[UIColor line0Color] inView:self.alertView];
    
    
    
    
    
}

-(void)subviewsLayout
{
    @weakify(self);
    float hieght =[HYAlertViewController getHeightLineWithString:self.message withWidth:SCREEN_WIDTH -120 withFont:self.messageLabel.font];
    
    if(self.alertTitle.length==0)
        self.alertView.frame=CGRectMake(30, SCREEN_HEIGHT, SCREEN_WIDTH-60, hieght+ 33+85 );
    else
    {
        self.alertView.frame=CGRectMake(30, SCREEN_HEIGHT, SCREEN_WIDTH-60, hieght+ 33+85+38 );
    }
    
    
    
    if(self.alertTitle)
    {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.alertView.mas_left).offset(30);
            make.right.equalTo(self.alertView.mas_right).offset(-30);
            make.top.equalTo(self.alertView.mas_top).offset(33);
            make.height.equalTo(@18);
        }];
        
    }
    
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.alertView.mas_left).offset(30);
        make.right.equalTo(self.alertView.mas_right).offset(-30);
        if(self.alertTitle.length==0)
            make.top.equalTo(self.alertView.mas_top).offset(30);
        else
        {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        }
        make.bottom.equalTo(self.alertView.mas_bottom).offset(-85);
       
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.alertView.mas_left);
        make.right.equalTo(self.alertView.mas_right);
        make.top.equalTo(self.messageLabel.mas_bottom).offset(29.5);
        make.height.equalTo(@0.5);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.alertView.mas_left);
        if(self.type == HYALERTYPETONE)
        {
              make.right.equalTo(self.alertView.mas_right);
        }
        else
        {
        
        make.right.equalTo(self.alertView.mas_centerX);
        }
      
        make.bottom.equalTo(self.alertView.mas_bottom);
        make.height.equalTo(@55);
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.alertView.mas_centerX);
        make.right.equalTo(self.alertView.mas_right);
        make.bottom.equalTo(self.alertView.mas_bottom);
        make.height.equalTo(@55);
    }];
    
    [self.stickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.alertView.mas_centerX);
        make.top.equalTo(self.lineView.mas_bottom);
        make.bottom.equalTo(self.alertView.mas_bottom);
        make.width.equalTo(@0.5);
    }];
    
    
      if(self.type == HYALERTYPETONE)
      {
          self.sureButton.hidden=YES;
          self.stickView.hidden=YES;
      }
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 根据字符串计算label高度
+ (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font {
    
    //1.1最大允许绘制的文本范围
    CGSize size = CGSizeMake(width, 2000);
    //1.2配置计算时的行截取方法,和contentLabel对应
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:10];
    //1.3配置计算时的字体的大小
    //1.4配置属性字典
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
    //2.计算
    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    
    return height;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
