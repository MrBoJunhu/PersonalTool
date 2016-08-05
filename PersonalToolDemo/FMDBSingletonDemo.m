//
//  FMDBSingletonDemo.m
//  PersonalToolDemo
//
//  Created by bill on 16/8/3.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "FMDBSingletonDemo.h"
#import <FMDatabase.h>
@implementation FMDBSingletonDemo

+ (FMDBSingletonDemo *)shareWithFMDBSingleton {
    
    static FMDBSingletonDemo *fmdb = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
    
        fmdb = [[self alloc] init];
    
    });
    
    return fmdb;
    
}

- (FMDatabase *)myDataBase {
    
    NSString *dataFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *dataBasePath = [dataFilePath stringByAppendingPathComponent:@"Personal.sqlite"];
    
    if (!_myDataBase) {
        
        self.myDataBase = [FMDatabase databaseWithPath:dataBasePath];
        
        NSLog(@"%@",  dataBasePath);
        
    }
    
    return _myDataBase;
    
}


@end
