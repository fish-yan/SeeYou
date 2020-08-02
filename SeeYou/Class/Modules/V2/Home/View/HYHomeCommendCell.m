//
//  HYHomeCommendCell.m
//  youbaner
//
//  Created by Joseph Koh on 2018/4/16.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYHomeCommendCell.h"

@interface HYCommendItemCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIImageView *tagView;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, assign) BOOL hasHeart;

@end

@implementation HYCommendItemCell

-  (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubvews];
        [self setupSubvewsLayout];
    }
    
    return self;
}

- (void)setupSubvews {
    _iconView = [UIImageView imageViewWithImageName:AVATAR_PLACEHOLDER inView:self];
    _iconView.contentMode = UIViewContentModeScaleAspectFill;
    _iconView.clipsToBounds = YES;
    _iconView.layer.cornerRadius = 70 * 0.5;
    
    _tagView = [UIImageView imageViewWithImageName:@"heart_nor" inView:self];
    _tagView.clipsToBounds = YES;
    _tagView.layer.cornerRadius = 28 * 0.5;
    
    _infoLabel = [UILabel labelWithText:@"广州/23岁"
                              textColor:[UIColor colorWithHexString:@"#3A444A"]
                               fontSize:12
                                 inView:self
                              tapAction:NULL];
}

- (void)setHasHeart:(BOOL)hasHeart {
    _hasHeart = hasHeart;
    if (hasHeart) {
        _tagView.image = [UIImage imageNamed:@"heart_sel"];
    } else {
        _tagView.image = [UIImage imageNamed:@"heart_nor"];
    }

}

- (void)setupSubvewsLayout {
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 28));
        make.bottom.equalTo(_iconView).offset(-2);
        make.right.equalTo(_iconView);
    }];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_iconView.mas_bottom).offset(20);
    }];
}

@end


@interface HYHomeCommendCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *topBtn;    // 置顶
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@end

@implementation HYHomeCommendCell

#pragma mark - Initialize

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialize];
        [self setupSubviews];
        [self setupSubviewsLayout];
        [self bind];
    }
    return self;
}

- (void)initialize {
    self.contentView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1/1.0];
    self.showBottomLine = YES;
}


#pragma mark - Bind

- (void)bind {
    RAC(self.titleLabel, text) = RACObserve(self, title);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HYCommendItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseID" forIndexPath:indexPath];
    HYObjectListModel *m = self.dataArray[indexPath.item];
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:m.avatar]
                     placeholderImage:[UIImage imageNamed:AVATAR_PLACEHOLDER]];
    cell.infoLabel.text = [NSString stringWithFormat:@"%@/%@岁", m.workcity ?: @"-", m.age ?: @"-"];
    cell.hasHeart = m.beckoningstatus;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HYObjectListModel *m = self.dataArray[indexPath.item];
    if (self.itemClickedAction) {
        self.itemClickedAction(m);
    }
}

#pragma mark - Setup UI

- (void)setupSubviews {
    _titleLabel = [UILabel labelWithText:nil
                               textColor:[UIColor colorWithHexString:@"#3A444A"]
                                fontSize:18
                                  inView:self.contentView
                               tapAction:NULL];
    
    @weakify(self);
    _topBtn = [UIButton buttonWithTitle:@"我要置顶"
                             titleColor:[UIColor colorWithHexString:@"#43484D"]
                               fontSize:14
                                bgColor:nil
                                 inView:self.contentView
                                 action:^(UIButton *btn) {
                                     @strongify(self);
                                     if (self.topAction) {
                                         self.topAction();
                                     }
                                 }];
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                         collectionViewLayout:self.layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = YES;
    [_collectionView registerClass:[HYCommendItemCell class] forCellWithReuseIdentifier:@"reuseID"];
    [self.contentView addSubview:_collectionView];
}

- (void)setupSubviewsLayout {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(20);
    }];
    
    [_topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.centerY.equalTo(_titleLabel);
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(20);
        make.bottom.right.offset(0);
        make.left.offset(20);
    }];
}


#pragma mark - Lazy Loading

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [UICollectionViewFlowLayout new];
        _layout.itemSize = CGSizeMake(70, 134);
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumLineSpacing = 20;
        _layout.minimumInteritemSpacing = 0;
    }
    return _layout;
}

@end
