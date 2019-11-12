#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  中文转换拼音输出类型
 */
typedef NS_ENUM(NSInteger , ChangeTextStyle) {
    
    //输出不带声调的拼音
    ChangeTextNomalStyle,
    //输出带声调
    ChangeTextStripDiacriticsStyle,
    //输出首字母大写
    ChangeTextcapitalPinyinStyle
};


@interface MatchSingleton : NSObject

+ (MatchSingleton *)shareMatchSingleton;

//日期格式转字符串
- (NSString *)giveDate:(NSDate *)tempdate dateFormatter:(NSString *)dateformatter;

/**
 *  给时间 "2016-03-12 12:12:12", 输出不同格式
 *
 *  @param startString 如"2016-05-03 20:25:30"
 *  @param timeStyle   返回的字符类型(1: "2016年5月3日" ;   2: "5月3日" ;  3: "2016年5月"  ; 4: "05-03 20:25:30"  ; 5: "5月3日 20:25" ;  else: "20:25:30")
 *  @return
 */
- (NSString *)giveStartPKTimeString:(NSString *)startString timeStyle:(int)timeStyle;


- (NSMutableAttributedString *)giveAString:(NSString *)givenStr WithFontSize:(CGFloat)fontSize WithTextColor:(UIColor *)textColor changeRange:(NSRange)stringRange;

// 截屏(自定义截屏,  全屏 --- YES:含导航条, NO:不含导航条), 返回截图的路径
- (NSString *)cutScreenForCustomView:(UIView *)cutV containtNavigationBar:(BOOL)isContain  photoName:(NSString *)photoName;

/// JsonString解析
- (NSDictionary *)dealJsonString:(NSString *)jsonString;

/**
 *  给数字月份 返回汉字(如:给 3 或者 03, 返回 "三月" )
 */
- (NSString *)dealMonthString:(NSString *)month;

/**
 *  小于10的整数去零
 */
- (NSString *)dealDayString:(NSString *)dayStr;

/**
 *  中文转换拼音
 */
- (NSString *)changeTextToPinyin:(NSString *)text ChangeTextStyle:(ChangeTextStyle)changeStyle;
@end
