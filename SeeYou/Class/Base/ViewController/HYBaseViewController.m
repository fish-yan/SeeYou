//
//  HYBaseViewController.m
//  youbaner
//
//  Created by luzhongchang on 17/7/29.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "HYBaseViewController.h"

@interface HYBaseViewController ()<UIGestureRecognizerDelegate>
{
     UITapGestureRecognizer  *_tapGesture;
}
@end

//static inline UIEdgeInsets sgm_safeAreaInset(UIView *view) {
//    if (@available(iOS 11.0, *)) {
//        return view.safeAreaInsets;
//    }
//    return UIEdgeInsetsZero;
//}

@implementation HYBaseViewController

- (void)setHasBgAction:(BOOL)hasBgAction {
    _hasBgAction = hasBgAction;
    if (!hasBgAction) {
        [self.view removeGestureRecognizer:_tapGesture];
    } else {
        [self addGesture];
    }
}

- (void)addGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        _tapGesture.cancelsTouchesInView =  NO;
        _tapGesture.delegate = self;
        [self.view addGestureRecognizer:_tapGesture];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self addGesture];

    
    [self __baseVCBindRAC];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addKeyboardNSNotification];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeKeyboardNSNotification];
}




- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([touch.view isKindOfClass: [UIButton class]] && [touch.view.superview isKindOfClass: [UITextField class]]) {
        return NO;
    }
    return  YES;
}

- (void)addKeyboardNSNotification {
    //键盘弹出监听
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(keyboardDidShow:)
                                                 name: UIKeyboardDidShowNotification
                                               object:nil];
    //键盘消失监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    //键盘即将弹出监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //键盘即将消失监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    //键盘即将变换
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChange:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    //键盘变换
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChange:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
    
}

- (void)removeKeyboardNSNotification {
    //移除键盘弹出监听
    [[NSNotificationCenter defaultCenter] removeObserver: self name:UIKeyboardWillShowNotification object: nil];
    //移除键盘消失监听
    [[NSNotificationCenter defaultCenter] removeObserver: self name:UIKeyboardWillHideNotification object: nil];
    //移除键盘即将弹出监听
    [[NSNotificationCenter defaultCenter] removeObserver: self name:UIKeyboardDidShowNotification object: nil];
    //移除键盘即将消失监听
    [[NSNotificationCenter defaultCenter] removeObserver: self name:UIKeyboardDidHideNotification object: nil];
    //移除键盘即将变化监听
    [[NSNotificationCenter defaultCenter] removeObserver: self name:UIKeyboardWillChangeFrameNotification object: nil];
    //移除键盘变化监听
    [[NSNotificationCenter defaultCenter] removeObserver: self name:UIKeyboardDidChangeFrameNotification object: nil];
}

#pragma mark - 键盘监听事件
- (void)keyboardDidShow:(NSNotification *)notification
{
    
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    
}

- (void)keyboardWillChange:(NSNotification *)notification
{
    
}

- (void)keyboardDidChange:(NSNotification *)notification
{
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 点击隐藏键盘操作
- (void)tapGestureAction:(id)sender
{
    [self hideKeyboard];
}

#pragma mark - 关闭编辑界面，键盘消失
- (void)hideKeyboard
{
    [self.view endEditing:YES];
}


- (void)__baseVCBindRAC {
    @weakify(self);
    [RACObserve(self, canBack) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x.boolValue) {
            
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, 8, 14);
            [btn setImage:[UIImage imageNamed:@"top_back"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//            [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_back"] style:UIBarButtonItemStyleDone target:self action:@selector(popBack)];
        }
        else {
            self.navigationItem.leftBarButtonItem = nil;
        }
    }];
}

- (void)popBack {
    [self.view endEditing:YES];
    
    if (self.presentingViewController) {
        if (self.navigationController && self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)viewSafeAreaInsetsDidChange
{
     [super viewSafeAreaInsetsDidChange];
   

    
}

@end
