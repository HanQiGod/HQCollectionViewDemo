//
//  HQViewController.m
//  HQCollectionViewDemo
//
//  Created by Mr_Han on 2018/10/10.
//  Copyright © 2018年 Mr_Han. All rights reserved.
//

#define JkScreenHeight [UIScreen mainScreen].bounds.size.height
#define JkScreenWidth [UIScreen mainScreen].bounds.size.width
#define ISiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#import "HQViewController.h"
#import "HQCollectionViewFlowLayout.h"
#import "HQTopStopView.h"

@interface HQViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation HQViewController

#pragma mark -- 懒加载

- (UICollectionView *)collectionView
{
    HQCollectionViewFlowLayout *flowlayout = [[HQCollectionViewFlowLayout alloc] init];
    //设置悬停高度，默认64
    flowlayout.naviHeight = ISiPhoneX?88:64;
    //设置滚动方向
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //左右间距
    flowlayout.minimumInteritemSpacing = 1;
    //上下间距
    flowlayout.minimumLineSpacing = 1;
    flowlayout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 2);
    if (!_collectionView) {
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0 , 0 , JkScreenWidth, JkScreenHeight) collectionViewLayout:flowlayout];
    }
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    _collectionView.showsVerticalScrollIndicator = NO;
    
    //注册单元格
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    //注册区头
    [_collectionView registerClass:[HQTopStopView class] forSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"topView"];
    
    return _collectionView;
}


#pragma mark ---------   配置单元格   --------------
//配置单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = indexPath.section==0?[UIColor redColor]:[UIColor greenColor];
    return cell;
    
}
#pragma mark ---------  UICollectionView  Delegate/DataSource-----
//点击单元格
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
//配置区头
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        
        HQTopStopView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"topView" forIndexPath:indexPath];
        
        headerView.backgroundColor = [UIColor blackColor];
        
        return headerView;
        
    }
    return nil;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return 100;
}
//设置区头高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(JkScreenWidth,50);
}

//设置区尾高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}


//设置cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {//轮播
        return CGSizeMake(JkScreenWidth,150);
    }
    return CGSizeMake((JkScreenWidth -1-2-2)/2,580/2);
}








- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"悬停效果";
    
    [self.view addSubview:self.collectionView];
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
