//
//  PersonTableViewCell.h
//  PersonalToolDemo
//
//  Created by bill on 16/8/3.
//  Copyright © 2016年 bill. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Person;
@interface PersonTableViewCell : UITableViewCell

@property (nonatomic, strong) Person *person;

@property (weak, nonatomic) IBOutlet UILabel *nameLB;

@property (weak, nonatomic) IBOutlet UILabel *addressLB;

@property (weak, nonatomic) IBOutlet UILabel *phoneLB;


@end
