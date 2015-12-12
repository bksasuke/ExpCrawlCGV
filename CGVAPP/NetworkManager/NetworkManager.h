//
//  NetworkManager.h
//  CGVAPP
//
//  Created by Nguyen Van Thanh on 12/7/15.
//  Copyright © 2015 DangDingCan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject
+(instancetype)shareManager;
-(void) GetFilmFromLink:(NSString*) url OnComplete:(void(^)(NSArray *items))completedMethod fail:(void(^)())failMethod;

@end
