//
//  NetworkManager.m
//  CGVAPP
//
//  Created by Nguyen Van Thanh on 12/7/15.
//  Copyright © 2015 DangDingCan. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetworking.h"
#define BASE_URL @"https://www.cgv.vn"
#import "TFHpple.h"
#import "PhimObj.h"


@interface NetworkManager()
@property (nonatomic, strong) AFHTTPRequestOperationManager *httpRequestOperationManager;

@end

@implementation NetworkManager
+(instancetype)shareManager {
    static NetworkManager*shareManager = nil;
    static dispatch_once_t dispatchOnce;
    dispatch_once(&dispatchOnce, ^{
        shareManager = [self new];
    });
    return shareManager;
}
-(id)init {
    if (self = [super init]) {
        _httpRequestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:nil];
    }
    return self;
}
// Phim dang chieu
-(void)GetFilmFromLink:(NSString *)url OnComplete:(void (^)(NSArray *))completedMethod fail:(void (^)())failMethod{

    NSError * error;
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url] options:NSDataReadingUncached  error:&error];
    if (error) {
        failMethod();
    }
        NSMutableArray * allItems = [NSMutableArray new];
    
        TFHpple * tutorialPaser = [TFHpple hppleWithHTMLData:data];
        
        NSString * tutorialQueryString = @"//div[@class='category-products']/ul/li";
        NSArray *nodes = [tutorialPaser searchWithXPathQuery:tutorialQueryString];
        for (TFHppleElement * element in nodes) {
            
            
        
            TFHppleElement * element1 = [element firstChildWithClassName:@"product-poster"];  // lay vap the div co class product-poster
            TFHppleElement * element2 = [element1 firstChildWithTagName:@"a"];
            //TFHppleElement *element3 = element2.children[1];
            TFHppleElement *element3 = [element2 firstChildWithTagName:@"img"];
            
            NSString *linkDetail = [element2 objectForKey:@"href"];
            NSString *linkimage = [element3 objectForKey:@"src"];
            
            ////
            TFHppleElement * element4 = [element firstChildWithClassName:@"product-info"];
            TFHppleElement *element5 = [element4 firstChildWithClassName:@"movie-actress"];
            TFHppleElement *element6 = [element5 firstChildWithClassName:@"std"];
            NSString *filmType = element5.content;
         //   NSLog(@"%@",filmType);
            
            TFHppleElement *element7 = [element4 firstChildWithClassName:@"movie-release"];
            TFHppleElement *element8 = [element7 firstChildWithClassName:@"std"];
            NSString *filmDateRealease = element8.content;
            NSLog(@"%@",filmDateRealease);
            
            
            
            PhimObj *phim = [[PhimObj alloc] initWithName:nil andCate:nil andDuration:nil date:nil linkDetail:linkDetail imageUrl:linkimage];
            [allItems addObject:phim];
        }
        completedMethod(allItems);
}
// detail


  



@end
