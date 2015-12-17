//
//  ViewController.m
//  CGVAPP
//
//  Created by Nguyen Van Thanh on 12/7/15.
//  Copyright © 2015 DangDingCan. All rights reserved.
//

#import "ViewController.h"
#import "TFHpple.h"
#import "PhimObj.h"
#import "NetworkManager.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *arr_data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadHTML];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
-(void) loadHTML{
    [[NetworkManager shareManager] GetFilmFromLink:@"https://www.cgv.vn/vn/movies/now-showing.html" OnComplete:^(NSArray *items) {
        self.arr_data = [[NSMutableArray alloc] initWithArray:items];
    
        [self.tableView reloadData]; // Tải lại table khi dữ liệu đc parse về.
        
    } fail:^{
        NSLog(@"loi");
    }];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr_data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"] ;
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:@"Cell"];
    }
    PhimObj *obj = self.arr_data[indexPath.row];
    cell.textLabel.text = obj.tenPhim;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:obj.linkAnh]];

    cell.imageView.image = [UIImage imageWithData:data];
   // cell.imageView.image =
    return cell ;}
@end
