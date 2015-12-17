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
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]
                                             options:NSDataReadingUncached
                                               error:&error];
    if (error) { failMethod();
    }
        NSMutableArray * allItems = [NSMutableArray new];
    
        TFHpple * tutorialPaser = [TFHpple hppleWithHTMLData:data];
        
        NSString * tutorialQueryString = @"//div[@class='category-products']/ul/li";
        NSArray *nodes = [tutorialPaser searchWithXPathQuery:tutorialQueryString];
        for (TFHppleElement * element in nodes) { // bắt đầu duyệt trong class "category ...
            
            
        
            TFHppleElement * element1 = [element firstChildWithClassName:@"product-poster"];  // Lấy thẻ div co class là product-poster
            TFHppleElement * element2 = [element1 firstChildWithTagName:@"a"];
           

            NSString *linkDetail = [element2 objectForKey:@"href"];
            //TFHppleElement *element3 = element2.children[1];
            
            TFHppleElement *element3 = [element2 firstChildWithTagName:@"img"];
        
            NSString *linkimage = [element3 objectForKey:@"src"];
    
            TFHppleElement * element4 = [element firstChildWithClassName:@"product-info"]; //tạo node chứa thẻ prdoduct info
            TFHppleElement *element20 = [element4 firstChildWithClassName:@"product-name"];
            TFHppleElement *element21 = [element20 firstChildWithTagName:@"a"];
           // TFHppleElement *element22 = [element21 firstChildWithTagName:@"title"];
             NSString *name = [element21 objectForKey:@"title"];
            TFHppleElement *element5 = [element4 firstChildWithClassName:@"movie-actress"]; // lấy thẻ movie
            TFHppleElement *element6 = [element5 firstChildWithClassName:@"std"]; // lấy thẻ có class std
            
            NSString *filmDuration = element6.content; // --> thời lượng film là content của element6
            
            TFHppleElement *element7 = [element4 firstChildWithClassName:@"movie-genre"]; // lấy thẻ movie-genere
            TFHppleElement *element8 = [element7 firstChildWithClassName:@"std"];
        
            NSString *filmType = element8.content ;
           // NSLog(@"%@",filmType);
            
            TFHppleElement *element9 = [element4 firstChildWithClassName:@"movie-release"];
            TFHppleElement *element10 = [element9 firstChildWithClassName:@"std"];
            NSString *filmDateRealease = element10.content;
          //  NSLog(@"%@",filmDateRealease);
            
            
            
            PhimObj *phim = [[PhimObj alloc] initWithName:name
                                                 catelogy:filmType
                                                 duration:filmDuration
                                                     date:filmDateRealease
                                               linkDetail:linkDetail
                                                 imageUrl:linkimage ];
                
                             
                             [allItems addObject:phim];
        }
        completedMethod(allItems);
}
// detail


  



@end
