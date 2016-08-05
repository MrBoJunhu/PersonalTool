//
//  PersonTableViewCell.m
//  PersonalToolDemo
//
//  Created by bill on 16/8/3.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "PersonTableViewCell.h"
#import "Person.h"

@implementation PersonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPerson:(Person *)person {
    
    _person = person;
    
    self.nameLB.text = person.name;
    
    self.addressLB.text = person.address;
    
    self.phoneLB.text = person.telePhone;
    
}

@end
