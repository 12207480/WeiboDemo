//
//  WBGeoModel.h
//  Weibo
//
//  Created by SKY on 15/5/25.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  地理信息（geo）
 */
@interface WBGeoModel : NSObject
@property(copy,nonatomic)NSString *longitude;//经度坐标
@property(copy,nonatomic)NSString *latitude;//维度坐标
@property(copy,nonatomic)NSString *city;//所在城市的城市代码
@property(copy,nonatomic)NSString *province;//所在省份的省份代码
@property(copy,nonatomic)NSString *city_name;//所在城市的城市名称
@property(copy,nonatomic)NSString *province_name;//所在省份的省份名称
@property(copy,nonatomic)NSString *address;//所在的实际地址，可以为空
@property(copy,nonatomic)NSString *pinyin;//地址的汉语拼音，不是所有情况都会返回该字段
@property(copy,nonatomic)NSString *more;//更多信息，不是所有情况都会返回该字段
-(instancetype)initWithJsonDictionary:(NSDictionary *)dic;
@end
