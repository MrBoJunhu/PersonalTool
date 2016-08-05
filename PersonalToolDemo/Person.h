//
//  Person.h
//  PersonalToolDemo
//
//  Created by bill on 16/8/3.
//  Copyright © 2016年 bill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *telePhone;

@property (nonatomic, assign) NSInteger personID;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key ;

- (void)setPersonName:(NSString *)name
        personAddress:(NSString *)personAddress
            telephone:(NSString *)telePhone;

@end
