//
//  WDSplashViewManager.m
//  MyProject
//
//  Created by Joseph Gao on 2017/5/4.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "WDSplashViewManager.h"
#import "WDSplashViewModel.h"
#import "WDSplashView.h"

@interface WDSplashViewManager ()

@property (nonatomic, strong) WDSplashViewModel *viewModel;
@property (nonatomic, strong) WDSplashView *splashView;
@property (nonatomic, strong) NSObject *_observer;
@property (nonatomic, assign) SEL _selector;

@end

@implementation WDSplashViewManager

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    static WDSplashViewManager *mgr = nil;
    dispatch_once(&onceToken, ^{
        mgr = [[WDSplashViewManager alloc] init];
    });
    return mgr;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.splashView = [[WDSplashView alloc] init];
    self.viewModel = [[WDSplashViewModel alloc] init];
    self.showCommand = self.splashView.showCommand;
    
    [self.splashView bindWithViewModel:self.viewModel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(postDismissNotif)
                                                 name:@"splash_view_hidden"
                                               object:nil];
}

- (void)postDismissNotif {
    if ([self._observer respondsToSelector:self._selector]) {
        IMP imp = [self._observer methodForSelector:self._selector];
        void(*func)(id, SEL) = (void *)imp;
        func(self._observer, self._selector);
    }
}

- (void)addSplashViewDismissObserver:(NSObject *)observer selector:(SEL)selector {
    self._observer = observer;
    self._selector = selector;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
