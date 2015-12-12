//
//  PhimObj.m
//  CGVAPP
//
//  Created by Nguyen Van Thanh on 12/7/15.
//  Copyright © 2015 DangDingCan. All rights reserved.
//

#import "PhimObj.h"

@interface PhimObj()


@end


@implementation PhimObj
-(id)initWithName:(NSString *)name andCate:(NSString *)cate andDuration:(NSString *)duration date:(NSString *)date linkDetail:(NSString *)linhDtail imageUrl:(NSString *)imageURL{
    self = [super init];
    if (self) {
        self.namePhim = name;
        self.theLoai = cate;
        self.thoiLuong = duration;
        self.khoiChieu = date;
        self.linkDetail = linhDtail;
        self.urlImage = imageURL;
    }
    return self;
}



@end
