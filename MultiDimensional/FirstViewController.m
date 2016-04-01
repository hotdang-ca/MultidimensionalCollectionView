//
//  FirstViewController.m
//  MultiDimensional
//
//  Created by James Perih on 2016-04-01.
//  Copyright © 2016 Hot Dang Interactive. All rights reserved.
//

#import "FirstViewController.h"
#import "LevelCell.h"
#import "HeaderCell.h"

@interface FirstViewController ()
@property (strong, nonatomic) NSArray *collectionArray;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation FirstViewController {
    UICollectionViewFlowLayout *flowLayout;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDataSource];
    [self setupCollectionView];
    [self.collectionView reloadData];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setupDataSource {
    NSArray *firstMarioLevel = @[@"1-1", @"1-2", @"1-3", @"1-4"];
    NSArray *secondMarioLevel = @[@"2-1", @"2-2", @"2-3", @"2-4"];
    NSArray *thirdMarioLevel = @[@"3-1", @"3-2", @"3-3", @"3-4"];
    NSArray *fourthMarioLevel = @[@"4-1", @"4-2", @"4-3", @"4-4"];
    NSArray *fifthMarioLevel = @[@"5-1", @"5-2", @"5-3", @"5-4"];
    NSArray *sixthMarioLevel = @[@"6-1", @"6-2", @"6-3", @"6-4"];
    NSArray *seventhMarioLevel = @[@"7-1", @"7-2", @"7-3", @"7-4"];
    NSArray *eighthMarioLevel = @[@"8-1", @"8-2", @"8-3", @"8-4"];
    
    NSArray *firstSonicLevel = @[@"Green Hill Act 1", @"Green Hill Act 2", @"Green Hill Act 3"];
    NSArray *secondSonicLevel = @[@"Marble Act 1", @"Marble Act 2", @"Marble Act 3"];
    NSArray *thirdSonicLevel = @[@"Spring Yard Act 1", @"Spring Yard Act 2", @"Spring Yard Act 3"];
    NSArray *fourthSonicLevel = @[@"Labyrinth Act 1", @"Labyrinth Act 2", @"Labyrinth Act 3"];
    NSArray *fifthSonicLevel = @[@"Starlight Act 1", @"Starlight Act 2", @"Starlight Act 3"];
    NSArray *sixthSonicLevel = @[@"Scrap Brain Act 1", @"Scrap Brain Act 2", @"Scrap Brain Act 3"];
    NSArray *seventhSonicLevel = @[@"Final Act 1"];
    
    NSArray *marioLevels = @[firstMarioLevel, secondMarioLevel, thirdMarioLevel, fourthMarioLevel, fifthMarioLevel, sixthMarioLevel, seventhMarioLevel, eighthMarioLevel];
    
    NSArray *sonicLevels = @[firstSonicLevel, secondSonicLevel, thirdSonicLevel, fourthSonicLevel, fifthSonicLevel, sixthSonicLevel, seventhSonicLevel];
    
    _collectionArray = @[marioLevels, sonicLevels];
}

-(void)setupCollectionView {
    // didn't want to adopt UICollectionViewDelegateFlowLayout protocol
    flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(250, 116)];
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing = 8;
    flowLayout.minimumInteritemSpacing = 8;
    
    UINib *nib = [UINib nibWithNibName:@"LevelCell"
                                bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"LevelCell"];
    
    UINib *headerNib = [UINib nibWithNibName:@"HeaderCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderCell"];
    [flowLayout setHeaderReferenceSize:CGSizeMake(250, 30)];

    
    [self.collectionView setCollectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [_collectionArray count]; // two sections
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_collectionArray[section] count];
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    HeaderCell *headerCell = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderCell" forIndexPath:indexPath];
    
    headerCell.headerTitleLabel.text = indexPath.section == 0 ? @"MARIO" : @"SONIC";
    return headerCell;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    // the nsarray at this indexPath has a set of elements to display horizontally; we'll handle these with paging scroll views rather than complicated UICollectionViews
    NSArray *levelStrings = _collectionArray[indexPath.section][indexPath.row];
    
    LevelCell *levelCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"LevelCell" forIndexPath:indexPath];
    
    // set up a nice scrolling view thinger
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, levelCell.frame.size.width, levelCell.frame.size.height)];
    scrollView.contentSize = CGSizeMake((levelCell.frame.size.width + 4) * levelStrings.count, levelCell.frame.size.height);
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    
    // some colours to randomly pick from
    NSArray *colors = @[[UIColor yellowColor], [UIColor redColor], [UIColor orangeColor], [UIColor brownColor]];
    
    // for each set element, create a containing view configured with that element's data
    int iterator = 0;
    CGFloat const spacing = 2.0;
    
    for (NSString *levelString in levelStrings) {
        UIView *containingView = [[UIView alloc] initWithFrame:CGRectMake(iterator * levelCell.frame.size.width + spacing, 0, levelCell.frame.size.width - spacing, levelCell.frame.size.height)]; // 4px spaces inbetween
        containingView.layer.borderWidth = 2;
        containingView.layer.borderColor = [UIColor blackColor].CGColor;
        containingView.layer.cornerRadius = 8.0;
        
        containingView.backgroundColor = colors[arc4random() % colors.count];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,containingView.frame.size.width, containingView.frame.size.height)];
        label.text = levelString;
        label.textAlignment = NSTextAlignmentCenter;
        
        [containingView addSubview:label];
        [scrollView addSubview:containingView];
        iterator++;
    }
    
    // configure this cell with the scrollview and it's contents of elements
    [levelCell addSubview:scrollView];
    
    return levelCell;
}

@end
