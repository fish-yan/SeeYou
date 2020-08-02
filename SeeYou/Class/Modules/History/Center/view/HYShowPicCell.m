//
//  HYShowPicCell.m
//  youbaner
//
//  Created by luzhongchang on 17/8/8.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//
#define kSpaceBetweenSubscribe  0
#define kVerticalSpaceBetweenSubscribe  0
#define kSubscribeHeight  100 * SCREEN_WIDTH_RATIO
#define kContentLeftAndRightSpace  0
#define kTopViewHeight  64 * SCREEN_WIDTH_RATIO

#define kDeleteBtnWH 20 * SCREEN_WIDTH_RATIO
/***  屏宽比例 */
#define SCREEN_WIDTH_RATIO (SCREEN_WIDTH / 375.0)
#define kLineHeight (1 / [UIScreen mainScreen].scale)
#pragma mark - 字体

#import "HYCollectionViewCell.h"
#import "HYShowPicCell.h"

#define HYCollectionViewCell_ID @"HYCollectionViewCell"
#import "HYShoePhotosViewModel.h"
@implementation HYShowPicCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
        self.delButton=NO;
        @weakify(self);
        self.isShowAdd =NO;
      
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        self.titleLabel=[UILabel labelWithText:@"照片（18）" textColor:[UIColor blackColor] fontSize:15 inView:self.contentView tapAction:nil];
        
        

        self.button =[UIButton buttonWithNormalImgName:@"centerAdd" bgColor:[UIColor clearColor] inView:self.contentView action:^(UIButton *btn) {
            @strongify(self);
            if(self.block)
            {
                self.block(10000);
            }
        }];
        
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_top).offset(48);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.height.equalTo(@48);
        }];
        
     
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.top.equalTo(self.contentView.mas_top).offset(16.5);
            make.height.equalTo(@15);
        }];
        
        
        
 
        
        
        [self addSubview: self.collectView];
        [self bindModel];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-( void )bindModel
{
    
    RAC(self.button ,hidden)= [RACObserve(self, isShowAdd) not];
}


-(UICollectionView*)collectView
{
    if(!_collectView)
    {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = (SCREEN_WIDTH-4)/3.0 ;
        layout.itemSize = CGSizeMake(width, width);
        layout.minimumLineSpacing = kSpaceBetweenSubscribe;
        layout.minimumInteritemSpacing = kVerticalSpaceBetweenSubscribe;
        layout.sectionInset = UIEdgeInsetsMake(kContentLeftAndRightSpace, kContentLeftAndRightSpace, kContentLeftAndRightSpace, kContentLeftAndRightSpace);
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        //注册cell
        
        _collectView.dataSource = self;
        _collectView.delegate   = self;
        _collectView.allowsSelection=YES;
        _collectView.backgroundColor = [UIColor clearColor];
        
        [_collectView registerClass:[HYCollectionViewCell class] forCellWithReuseIdentifier:HYCollectionViewCell_ID];
        [_collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeader"];
        
    }
    return _collectView;
}

-(void)updateArray:(NSArray *)array
{
    
    self.titleLabel.text =[NSString stringWithFormat:@"照片（%lu）",array.count];
    
    
    NSMutableArray * temarray =[NSMutableArray new];
    
    for (int i=0; i<array.count; i++) {
    
        
         HYShoePhotosViewModel * viewmodel = [HYShoePhotosViewModel  viewModelWithObj:[array objectAtIndex:i]];
        viewmodel.delButton = self.delButton;
        [temarray addObject:viewmodel];
    }
    
    
    self.MyServiceArray =[temarray copy];
    self.collectView.frame =CGRectMake(2, 48, SCREEN_WIDTH-4, [HYShowPicCell GetHeight:array.count]);
    [self.collectView reloadData];
}


/*collect delegate*/
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.MyServiceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HYCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:HYCollectionViewCell_ID forIndexPath:indexPath];
    [cell bindWithViewModel:[self.MyServiceArray objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 2);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout  referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 2);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    HYShoePhotosViewModel * viewModel = [self.MyServiceArray objectAtIndex:indexPath.row];
    if(viewModel.deleteStatus)
    {
        ((HYShoePhotosViewModel*)[self.MyServiceArray objectAtIndex:indexPath.row]).deleteStatus=NO;
        return;
    }
    if(self.block)
    {
        self.block((int)indexPath.row);
    }

    
}


+(CGFloat)GetHeight:( NSInteger)serviceCount
{
    float width = (SCREEN_WIDTH-4)/3.0;
    
    if(serviceCount==0)
    {
        return 48;
    }
    
    if(serviceCount%3==0)
    {
       return 48+ (serviceCount/3)*(width +2);
    }
    else
    {
        return  48+ (serviceCount/3 +1)*(width +2);
    }
    
}

@end
