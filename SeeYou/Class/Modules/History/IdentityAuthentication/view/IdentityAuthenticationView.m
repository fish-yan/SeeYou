//
//  IdentityAuthenticationView.m
//  youbaner
//
//  Created by luzhongchang on 17/8/1.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "IdentityAuthenticationView.h"
#import "IndentifityAuthenDescriptionCell.h"
#import "IndentifityAuthenViewModel.h"
#import "IndentituAuthenUploadIdentifyPhotoCell.h"

#define HY_INDENTIFITYAUTHEN_ID @"IndentifityAuthenDescriptionCell"
#define HY_INDENTIFITYAUTHENUPLOAD_ID @"IndentituAuthenUploadIdentifyPhotoCell"

@interface IdentityAuthenticationView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView *mTableview;
@property(nonatomic ,strong)IndentifityAuthenViewModel * viewModel;

@end

@implementation IdentityAuthenticationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if(self)
    {
        [self setUpview];
        self.viewModel =[IndentifityAuthenViewModel new];
        [self.viewModel GetDataList];
        [self.viewModel loadSection];
        [self.mTableview reloadData];
        
    }
    return self;
}


- (void)setUpview
{
    self.mTableview =[UITableView tableViewOfStyle:UITableViewStylePlain inView:self withDatasource:self delegate:self];
    self.mTableview.showsVerticalScrollIndicator=NO;
    self.mTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mTableview.backgroundColor =[UIColor clearColor];
    [self.mTableview registerClass:[IndentifityAuthenDescriptionCell class] forCellReuseIdentifier:HY_INDENTIFITYAUTHEN_ID];
    [self.mTableview registerClass:[IndentituAuthenUploadIdentifyPhotoCell class] forCellReuseIdentifier:HY_INDENTIFITYAUTHENUPLOAD_ID];
    @weakify(self);
    [self.mTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(64);
        make.bottom.equalTo(self.mas_bottom);
    }];
}


#pragma mark --TableviewDelegate--
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.viewModel.SectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger index = [[self.viewModel.SectionArray objectAtIndex:section] intValue];
    
    switch (index) {
        case IndentifityAuthenDescriptionType:
            return self.viewModel.listArray.count;
            break;
        case IndentifityAuthenUploadPhtotoType:
            return 1;
            break;
        default:
            break;
    }
    
    return  0;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     NSInteger index = [[self.viewModel.SectionArray objectAtIndex:indexPath.section] intValue];
    
    switch (index) {
        case IndentifityAuthenDescriptionType:
        {
            IndentifityAuthenDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:HY_INDENTIFITYAUTHEN_ID];
            [cell BindModel: [self.viewModel.listArray objectAtIndex:indexPath.row]];
            return cell;
        }
            break;
        case IndentifityAuthenUploadPhtotoType:
        {
            IndentituAuthenUploadIdentifyPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:HY_INDENTIFITYAUTHENUPLOAD_ID];
            [cell  BindViewmodel:self.viewModel.uploadViewModel];
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSInteger index = [[self.viewModel.SectionArray objectAtIndex:indexPath.section] intValue];
    
    switch (index) {
        case IndentifityAuthenDescriptionType:
        {
            return [tableView fd_heightForCellWithIdentifier:HY_INDENTIFITYAUTHEN_ID  configuration:^(IndentifityAuthenDescriptionCell* cell) {
                
                [cell BindModel: [self.viewModel.listArray objectAtIndex:indexPath.row]];
            }];
        }
            break;
        case IndentifityAuthenUploadPhtotoType:
        {
            return [tableView fd_heightForCellWithIdentifier:HY_INDENTIFITYAUTHENUPLOAD_ID  configuration:^(IndentituAuthenUploadIdentifyPhotoCell* cell) {
                
                [cell BindViewmodel:self.viewModel.uploadViewModel];
            }];
        }
            break;
        default:
            break;
    }
    return 0;

   
}



@end
