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

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *arr_data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadHTML];
    NSLog(@"%@",self.arr_data);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void) loadHTML{
    
    [[NetworkManager shareManager] GetFilmFromLink:@"https://www.cgv.vn/vn/movies/now-showing.html" OnComplete:^(NSArray *items) {
        self.arr_data = [[NSMutableArray alloc] initWithArray:items];
        
    } fail:^{
        NSLog(@"loi");
    }];
    

}

@end
