//
//  ViewController.m
//  PersonalToolDemo
//
//  Created by bill on 16/7/28.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "ViewController.h"

#import "MatchSingleton.h"


#import "Person.h"

#import "PersonListTableViewController.h"

static  BOOL hasTable;

static BOOL hasData;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *createResultLB;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *addressTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (nonatomic, strong) FMDatabase *myDatabase;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    hasTable = NO;
    
    _myDatabase = [[FMDBSingletonDemo shareWithFMDBSingleton] myDataBase];
    
    [super viewDidLoad];
    
//    [self demo1];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSArray *subViewArray = self.view.subviews;
    
    for (UIView *view in subViewArray) {
        
        if ([view isKindOfClass:[UITextField class]]) {
        
            UITextField *textField = (UITextField *)view;
            
            textField.text = @"";
            
        }
    }
    
}


#pragma mark  - database demo

- (IBAction)createTableDataSource:(id)sender {
    [self demo2];
}

- (void)demo2 {
    
    if (!hasTable) {
        
        [_myDatabase open];
        
        BOOL result = [_myDatabase executeUpdate:@"create table if not exists PersonList (person_id integer primary key autoincrement, person_name text, person_address text, person_telephone text)"];
        
        hasTable = result;
        
        if (hasTable) {
            
            self.createResultLB.text = @"创表成功!";
            
            FMResultSet *resultSet = [_myDatabase executeQuery:@"select * from PersonList"];
            
            if ([resultSet next]) {
                
                hasData = YES;
                
            }else{
                
                hasData = NO;
                
            }
            
            
        }else{
            
            self.createResultLB.text = @"创表失败!";
        }
        
        [_myDatabase close];
        
    }
    
}


- (IBAction)addPersonAction:(id)sender {
    
    self.createResultLB.textColor = [UIColor redColor];
    
    
    if (hasTable) {
        
        
        if (self.nameTextField.text.length > 0 && self.addressTextField.text.length > 0 && self.phoneTextField.text.length > 0) {
            
            [_myDatabase open];
            
            FMResultSet *resultSet = [_myDatabase executeQuery:@"select * from PersonList"];
            
            while ([resultSet next]) {
               
                NSLog(@"[resultSet stringForColumnIndex:3] %@",  [resultSet stringForColumnIndex:3]);
                
                NSLog(@"phoneTextField  %@", self.phoneTextField.text);
               
                if ([self.phoneTextField.text isEqualToString:[resultSet stringForColumnIndex:3]]) {
                    self.createResultLB.text = @"该人已存在!";
                    return;
                }
                
                
            }
            
            BOOL insertResult = [_myDatabase executeUpdate:@"insert into PersonList(person_name , person_address , person_telephone) values(?,?,?)", self.nameTextField.text, self.addressTextField.text, self.phoneTextField.text];
            
            if (insertResult) {
                
                self.createResultLB.text = @"添加成功!";
            
            }else{
            
                self.createResultLB.text = @"添加失败!";
            
            }
          
            hasData = insertResult;
            
            [_myDatabase close];
        
        }else{
            self.createResultLB.text = @"姓名或地址或电话为空";
        }
        
        
    }else{
        
        self.createResultLB.text = @"请先创建表";
        
    }
    
}

- (IBAction)deletePersonFromPersonList:(id)sender {
    
    if (hasTable) {
        
        if (hasData) {
            
            if (self.phoneTextField.text) {
                
                [_myDatabase open];
                
                BOOL deleteResult = [_myDatabase executeUpdate:@"delete from PersonList where person_telephone = ? ", self.phoneTextField.text];
                
                if (deleteResult) {
                    
                    self.createResultLB.text = @"删除成功!";
                    
                }else{
                    
                    self.createResultLB.text = @"删除失败!";
                    
                }
                
                
                [_myDatabase close];
                
            }else{
                
                self.createResultLB.text = @"请输入手机号";
                
            }
            
        }else{
            
            self.createResultLB.text = @"表中无任何数据!";
            
        }
        
    }else{
        
        self.createResultLB.text = @"请先创建表!";
        
    }
    
}

- (IBAction)deleteAllPersonFromDataSource:(id)sender {
    
    if (hasData && hasTable) {
        
        [_myDatabase open];
        
        BOOL deleteAll = [_myDatabase executeUpdate:@"delete from PersonList"];
        
        if (deleteAll) {
            
            hasData = NO;
            
            self.createResultLB.text = @"数据已清空!";
            
        }else {
            
            self.createResultLB.text = @"数据清空失败!";;
            
        }
        
        
        [_myDatabase close];
        
        
    }else{
        
        self.createResultLB.text = @"无表或表中数据为空";
        
    }
    
}



- (IBAction)dropTable:(id)sender {
    
    if (hasTable) {
        
        [_myDatabase open];
        

        if (hasData) {
            
            [_myDatabase executeUpdate:@"delete from PersonList"];
            
            [_myDatabase executeUpdate:@"drop table if exists PersonList"];
            
            hasData = NO;
            
        }else{
            
            [_myDatabase executeUpdate:@"drop table if exists PersonList"];
        }
        
        
        [_myDatabase close];
        
        hasTable = NO;
        
        self.createResultLB.text = @"删除表成功!";
        
    }else{
        
        self.createResultLB.text = @"数据库无任何表!";
        
    }

    
}

- (IBAction)searchPerson:(id)sender {
    
    
    
}

#pragma mark - date demo
- (void)demo1 {
    
    NSDate *currentDate = [NSDate date];
    
    NSString *testString = [[MatchSingleton shareMatchSingleton] giveDate:currentDate dateFormatter:@"yyyy-MM-dd HH:mm:ss"];
    
    NSLog(@"%@", testString);
}


#pragma mark - block

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    PersonListTableViewController *personListVC = (PersonListTableViewController *)segue.destinationViewController;
    
    [personListVC sendValueToForeward:^(Person *person) {
      
        NSLog(@"block %@", person);
        
    }];
    
    [personListVC deletePerson:^(BOOL hasNoPerson) {
       
        hasData = hasNoPerson;
        
    }];
    
}

#pragma mark - 中文转拼音

- (IBAction)changeTextToPinyin:(id)sender {
    
    NSString *tempString = self.createResultLB.text;
    
    NSLog(@"tempString %@", tempString);
    
    if (tempString.length) {
    
     self.createResultLB.text = [[MatchSingleton shareMatchSingleton]  changeTextToPinyin:tempString ChangeTextStyle:ChangeTextcapitalPinyinStyle];
        
    }
    
}


#pragma mark - did Receive Memory Warning
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

@end
