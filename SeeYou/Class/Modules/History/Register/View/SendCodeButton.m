//
//  SendCodeButton.m
//  11111111
//
//  Created by 杜凯 on 2016/12/8.
//  Copyright © 2016年 WondersGroup. All rights reserved.
//

#import "SendCodeButton.h"
@interface SendCodeButton()

//渲染层


@property (nonatomic,strong) CAShapeLayer *loadingLayer;




@property (nonatomic,assign)CGRect originFrame;

@end
@implementation SendCodeButton
- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        
        self.originFrame = frame;
    }
    return self;
    
}
-(UIBezierPath *)drawLoadingBezierPath{
    CGFloat radius = self.bounds.size.height/2 - 4;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath addArcWithCenter:CGPointMake(0,0) radius:radius startAngle:M_PI/6 endAngle: M_PI* 2 clockwise:YES];
    return bezierPath;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}

-(void)loadingAnimation{
    _loadingLayer = [CAShapeLayer layer];
    _loadingLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 );
    _loadingLayer.fillColor = [UIColor clearColor].CGColor;
    _loadingLayer.strokeColor = [UIColor grayColor].CGColor;
    _loadingLayer.lineWidth = 1;
    _loadingLayer.path = [self drawLoadingBezierPath].CGPath;
    [self.layer addSublayer:_loadingLayer];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation.fromValue = @(0);
    basicAnimation.toValue = @(M_PI*2);
    basicAnimation.duration = 2.0;
    basicAnimation.repeatCount = LONG_MAX;
    [_loadingLayer addAnimation:basicAnimation forKey:@"loadingAnimation"];
    

    
}
-(void)removeSubViews{

    [_loadingLayer removeFromSuperlayer];
    
    self.frame = self.originFrame;
    self.userInteractionEnabled = YES;
}
-(void)removeAllAnimation{
    [self removeSubViews];

}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
