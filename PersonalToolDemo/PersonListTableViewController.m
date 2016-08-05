//
//  PersonListTableViewController.m
//  PersonalToolDemo
//
//  Created by bill on 16/8/3.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "PersonListTableViewController.h"
#import "PersonTableViewCell.h"
#import "Person.h"

static BOOL kBarButtonItemEditing;

@interface PersonListTableViewController ()

@property (nonatomic, strong) NSMutableArray *personArray;

@property (nonatomic, strong) FMDatabase *myDatabase;

@end

@implementation PersonListTableViewController

- (NSMutableArray *)personArray {
   
    if (!_personArray) {
    
        self.personArray = [NSMutableArray array];
    
    }
    
    return _personArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _myDatabase = [[FMDBSingletonDemo shareWithFMDBSingleton] myDataBase];
    
    [self getDataFromSQLite];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"PersonList";
    
    kBarButtonItemEditing = NO;
    
    self.tableView.sectionIndexBackgroundColor = [UIColor greenColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    NSLog(@"内存警告!");
    
}

#pragma mark - 从数据库获取数据
- (void)getDataFromSQLite {
    
    [_myDatabase open];
    
    FMResultSet *resultSet = [_myDatabase executeQuery:@"select * from PersonList"];
    
    while ([resultSet next]) {
        
        Person * person = [[Person alloc] init];
        
        [person setPersonName:[resultSet stringForColumnIndex:1] personAddress:[resultSet stringForColumnIndex:2] telephone:[resultSet stringForColumnIndex:3]];
        
        [self.personArray addObject:person];
        
        [self.tableView reloadData];
        
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.personArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    PersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonTableViewCell" forIndexPath:indexPath];
    
    Person *person = self.personArray[indexPath.row];
    
    cell.person = person;
    
    if (indexPath.row % 2 == 0) {
        
        cell.contentView.backgroundColor = [UIColor lightGrayColor];
        
    }else{
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;

}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [_myDatabase open];
        
        Person *deletePerson = self.personArray[indexPath.row];
        
        NSString *phone = deletePerson.telePhone;
        
        [_myDatabase executeUpdate:@"delete from PersonList where person_telephone = ?", phone];
        
        [_myDatabase close];
        
        [self.personArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
        
        if (self.personArray.count == 0) {
            
            self.deleteBlock(NO);
            
        }
        
    }
    
    
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return  @[@"A",  @"B", @"C", @"D", @"E"];
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
    
}

#pragma mark -  Block

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    if (self.personArray.count) {
        
        Person *firstPerson = self.personArray[0];
        
        self.personBlock(firstPerson);
        
    }
}

- (void)sendValueToForeward:(PersonListBlock)personBlock {
    
    
    self.personBlock = personBlock;
    
}

- (void)deletePerson:(DeletePersonBlock)deleteBlock {
    
    self.deleteBlock = deleteBlock;
    
}

#pragma mark table edite

- (IBAction)editTableViewCell:(id)sender {
    
    kBarButtonItemEditing = !kBarButtonItemEditing;
    
    if (kBarButtonItemEditing) {
        
        self.tableView.editing = YES;
        
        self.navigationItem.rightBarButtonItem.title = @"Done";
        
    }else{
        
        self.tableView.editing = NO;
        
        self.navigationItem.rightBarButtonItem.title = @"Edit";
        
    }
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
