//
//  Person.m
//  PersonalToolDemo
//
//  Created by bill on 16/8/3.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    NSLog(@"%@  :  %@", key, value);
    
}

- (void)setPersonName:(NSString *)name personAddress:(NSString *)personAddress telephone:(NSString *)telePhone {
    
    self.name = name;
    
    self.address = personAddress;
    
    
    self.telePhone = telePhone;

}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"\n<%@ : %p>\n%@", [self class], self, @{@"name" : _name, @"address" : _address, @"telePhone" : _telePhone}];
    
}

@end
