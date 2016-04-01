//
//  LevelCell.h
//  MultiDimensional
//
//  Created by James Perih on 2016-04-01.
//  Copyright © 2016 Hot Dang Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    kLevelTypeMario,
    kLevelTypeSonic,
} kLevelType;

@interface LevelCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *levelNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelTypeLabel;

@property (nonatomic) kLevelType levelType;

@end
