//
//  QPMeViewController.m
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/27.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import "QPMeViewController.h"
#import "QPMeInfoView.h"
#import "QPSetting.h"

@interface QPMeViewController ()

@property (nonatomic, strong) NSMutableArray * datalist;

@property (nonatomic, strong) QPMeInfoView * infoView;

@end

@implementation QPMeViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (QPMeInfoView *)infoView {
    
    if (!_infoView) {
        _infoView = [QPMeInfoView loadInfoView];
//        _infoView.frame = CGRectMake(0, 0, 0, SCREEN_HEIGHT * 0.3);
    }
    return _infoView;
    
}


- (NSMutableArray *)dataList {
    
    if (!_datalist) {
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    
    [self loadData];
}

- (void)initUI {

    self.view.backgroundColor = RGB(238, 245, 245);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.tableView.tableHeaderView = self.infoView;
    self.tableView.rowHeight = 60;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);

    
}

- (void)loadData {
    
    QPSetting * set1 = [[QPSetting alloc] init];
    set1.title = @"映客贡献榜";
    set1.subTitle = @"";
    set1.vcName = @"";
    
    QPSetting * set2 = [[QPSetting alloc] init];
    set2.title = @"收益";
    set2.subTitle = @"0映票";
    set2.vcName = @"";
    
    QPSetting * set3 = [[QPSetting alloc] init];
    set3.title = @"账户";
    set3.subTitle = @"0钻石";
    set3.vcName = @"";
    
    QPSetting * set4 = [[QPSetting alloc] init];
    set4.title = @"等级";
    set4.subTitle = @"3级";
    set4.vcName = @"";
    
    QPSetting * set5 = [[QPSetting alloc] init];
    set5.title = @"实名认证";
    set5.subTitle = @"";
    set5.vcName = @"";
    
    QPSetting * set6 = [[QPSetting alloc] init];
    set6.title = @"设置";
    set6.subTitle = @"";
    set6.vcName = @"";
    
    
    NSArray * arr1 = @[set1,set2,set3];
    NSArray * arr2 = @[set4,set5];
    NSArray * arr3 = @[set6];
    self.datalist = [@[arr1,arr2,arr3] mutableCopy];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.datalist.count;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray * arr = self.datalist[section];

    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    QPSetting * set = self.datalist[indexPath.section][indexPath.row];
    
    cell.textLabel.text = set.title;
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.text = set.subTitle;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.infoView;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return SCREEN_HEIGHT * 0.55;
    }
    
    return 0.1;
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
