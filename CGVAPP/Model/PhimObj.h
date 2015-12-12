//
//  PhimObj.h
//  CGVAPP
//
//  Created by Nguyen Van Thanh on 12/7/15.
//  Copyright © 2015 DangDingCan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhimObj : NSObject
@property (nonatomic, strong) NSString * namePhim;
@property (nonatomic, strong) NSString * theLoai;
@property (nonatomic, strong) NSString * thoiLuong;
@property (nonatomic, strong) NSString * khoiChieu;
@property (nonatomic, strong) NSString * linkDetail;
@property (nonatomic, strong) NSString * urlImage;
-(id) initWithName:(NSString *) name
           andCate:(NSString *) cate
       andDuration:(NSString *) duration
              date:(NSString *)date
        linkDetail:(NSString *) linhDtail
          imageUrl:(NSString *) imageURL;




@end
