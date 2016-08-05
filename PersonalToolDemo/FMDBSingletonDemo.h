//
//  FMDBSingletonDemo.h
//  PersonalToolDemo
//
//  Created by bill on 16/8/3.
//  Copyright © 2016年 bill. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDatabase;
@interface FMDBSingletonDemo : NSObject

@property (nonatomic, strong) FMDatabase *myDataBase;

+ (FMDBSingletonDemo *)shareWithFMDBSingleton;

@end
