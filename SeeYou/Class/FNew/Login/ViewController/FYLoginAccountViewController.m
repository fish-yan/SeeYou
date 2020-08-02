//
//  FYLoginAccountViewController.m
//  SeeYou
//
//  Created by Yan on 2019/8/31.
//  Copyright © 2019 luzhongchang. All rights reserved.
//

#import "FYLoginAccountViewController.h"

@interface FYLoginAccountViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *accountV;
@property (weak, nonatomic) IBOutlet UIView *pwV;
@property (weak, nonatomic) IBOutlet UIImageView *accountImg;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UIImageView *pwImg;
@property (weak, nonatomic) IBOutlet UITextField *pwTF;

@end

@implementation FYLoginAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == self.accountTF) {
        self.accountV.layer.bcolor = UIColorByRGB(0xFF758C);
        self.accountImg.image = [UIImage imageNamed:@"icon_login_tel_selected"];
    } else {
        self.pwV.layer.bcolor = UIColorByRGB(0xFF758C);
        self.pwImg.image = [UIImage imageNamed:@"icon_login_code_selected"];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length == 0) {
        if (textField == self.accountTF) {
            self.accountV.layer.bcolor = UIColorByRGB(0xA5A5A5);
            self.accountImg.image = [UIImage imageNamed:@"icon_login_tel_unselected"];
        } else {
            self.pwV.layer.bcolor = UIColorByRGB(0xA5A5A5);
            self.pwImg.image = [UIImage imageNamed:@"icon_login_code_unselected"];
        }
    }
}

@end
