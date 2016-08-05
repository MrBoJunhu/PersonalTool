//
//  PersonListTableViewController.h
//  PersonalToolDemo
//
//  Created by bill on 16/8/3.
//  Copyright © 2016年 bill. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Person;
typedef void(^PersonListBlock)(Person *person);

typedef void(^DeletePersonBlock)(BOOL hasNoPerson);

@interface PersonListTableViewController : UITableViewController

@property (nonatomic, copy) PersonListBlock personBlock;

@property (nonatomic, copy) DeletePersonBlock deleteBlock;

- (void)sendValueToForeward:(PersonListBlock )personBlock;

- (void)deletePerson:(DeletePersonBlock)deleteBlock;

@end
