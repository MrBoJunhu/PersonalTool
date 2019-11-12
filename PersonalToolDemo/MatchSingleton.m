#import "MatchSingleton.h"

@implementation MatchSingleton

+ (MatchSingleton *)shareMatchSingleton {
    
    static  MatchSingleton *matchSingleton = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
    
        matchSingleton = [[MatchSingleton alloc] init];
    
    });
 
    return matchSingleton;
}

- (NSString *)giveDate:(NSDate *)tempdate dateFormatter:(NSString *)dateformatter {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = dateformatter;
    
    return [formatter stringFromDate:tempdate];
    
}


- (NSString *)giveStartPKTimeString:(NSString *)startString timeStyle:(int)timeStyle {
    
    NSString *sstring = [startString substringToIndex:10];
    
    NSArray *startTimeArray = [sstring componentsSeparatedByString:@"-"];
    
    NSString *yString = startTimeArray.firstObject;
    
    NSString *mString = startTimeArray[1];
        
    NSString *moveMentDateString = [startString  substringFromIndex:5];
    
    if ([mString floatValue] < 10 && [mString containsString:@"0"]) {
    
        mString = [mString substringFromIndex:1];
    
    }
    
    NSString *dString = [startTimeArray lastObject];
    
    if ([dString floatValue] < 10 && [dString containsString:@"0"]) {
    
        dString = [dString substringFromIndex:1];
    
    }
    
    NSString *timeString = [startString substringFromIndex:11];
   
    NSString *timeString1 = [timeString substringToIndex:5];
    
    if (timeStyle == 1) {
    
        /// 2016年5月3日
        return [NSString stringWithFormat:@"%@年%@月%@日", yString, mString, dString];
    
    }
    
    else if (timeStyle == 2){
        /// 5月3日
        return [NSString stringWithFormat:@"%@月%@日", mString, dString];
    
    }else if (timeStyle == 3){
        /// 2016年5月
        return [NSString stringWithFormat:@"%@年%@月", yString, mString];
    
    }else if (timeStyle == 4){
        /// 05-03 20:25:30
        return moveMentDateString;
    
    }else if (timeStyle == 5){
        /// 5月3日 20:25
        return [NSString stringWithFormat:@"%@月%@日 %@", mString, dString,timeString1];
    
    }else{
        /// 20:25:30
        return timeString;
    }
}


- (NSMutableAttributedString *)giveAString:(NSString *)givenStr WithFontSize:(CGFloat)fontSize WithTextColor:(UIColor *)textColor changeRange:(NSRange)stringRange {
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:givenStr];
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:stringRange];
    [attString addAttribute:NSForegroundColorAttributeName value:textColor range:stringRange];
    return attString;
}


- (NSString *)cutScreenForCustomView:(UIView *)cutV containtNavigationBar:(BOOL)isContain  photoName:(NSString *)photoName{
    
    NSString *filePathString;
    
    if (isContain) {
        UIView *view = [[[[[UIApplication sharedApplication] windows] objectAtIndex:0] subviews] lastObject];
        cutV = view;
    }
    for (id subView in [cutV subviews]) {
        NSLog(@"%@", subView);
        if ([subView isKindOfClass:NSClassFromString(@"UIView")]) {
            //支持retina高分的关键
            if(/* DISABLES CODE */ (/* DISABLES CODE */ (/* DISABLES CODE */ (&UIGraphicsBeginImageContextWithOptions))) != NULL)
            {
                UIGraphicsBeginImageContextWithOptions(cutV.frame.size, NO, 0.0);
            }
            //获取图像
            [cutV.layer renderInContext:UIGraphicsGetCurrentContext()];
           
            UIImage *saveImage = UIGraphicsGetImageFromCurrentImageContext();
           
            UIGraphicsEndImageContext();
            ///声明图片存储路径
            //保存到对应的沙盒目录中，具体代码如下：
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
          
            NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.png",photoName]];
           
            // 保存文件的名称
            [UIImagePNGRepresentation(saveImage)writeToFile: filePath    atomically:YES];
            
            if ([UIImagePNGRepresentation(saveImage) writeToFile:filePath atomically:YES]) {
               
                filePathString = filePath;
               
                if (isContain) {
                    NSLog(@"💐👙截屏保存成功!包含导航条👙💐:   %@", filePathString);
                }else{
                    NSLog(@"💐👙截屏保存成功!不包含导航条👙💐:   %@", filePathString);
                }
            }else{
                NSLog(@"(╯‵□′)╯炸弹！•••*～●  截屏保存失败!");
            }
        }
    }
    return filePathString;
}

- (NSDictionary *)dealJsonString:(NSString *)jsonString {
   
    if (jsonString == nil) {
      
    return nil;
   
    }else{
      
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
       
        NSError *err;
       
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        
        if (err) {
         
            NSLog(@"解析错误%@", err);
          
            return nil;
       
        }else{
           
            return dic;
       
        }
    }
}

- (NSString *)dealMonthString:(NSString *)month {
    NSString *tempMonthString;
    NSInteger tempMonth = [month integerValue];
    switch (tempMonth) {
        case 1:
            tempMonthString = @"一月";
            break;
        case 2:
            tempMonthString = @"二月";
            break;
        case 3:
            tempMonthString = @"三月";
            break;
        case 4:
            tempMonthString = @"四月";
            break;
        case 5:
            tempMonthString = @"五月";
            break;
        case 6:
            tempMonthString = @"六月";
            break;
        case 7:
            tempMonthString = @"七月";
            break;
        case 8:
            tempMonthString = @"八月";
            break;
        case 9:
            tempMonthString = @"九月";
            break;
        case 10:
            tempMonthString = @"十月";
            break;
        case 11:
            tempMonthString = @"十一月";
            break;
        case 12:
            tempMonthString = @"十二月";
            break;
        default:
            break;
    }
    return tempMonthString;
}

- (NSString *)dealDayString:(NSString *)dayStr {
   
    NSInteger day = [dayStr integerValue];
   
    if (day < 10) {
        
        if ([dayStr containsString:@"0"]) {
            NSString *sub = [dayStr substringFromIndex:1];
            return sub;
        }else{
            return dayStr;
        }
   
    }else{
        return dayStr;
    }
}

- (NSString *)changeTextToPinyin:(NSString *)text ChangeTextStyle:(ChangeTextStyle)changeStyle{
    
    NSMutableString *pinyinText;
    
    NSString *capitalPinyin;
    
    if (text.length > 0) {
        
        pinyinText = [[NSMutableString alloc] initWithString:text];
        
        switch (changeStyle) {
            case ChangeTextStripDiacriticsStyle:
            {
                //转化成带声调
                CFStringTransform((__bridge CFMutableStringRef)pinyinText, 0, kCFStringTransformToLatin, NO);
                
            }
                break;
            case ChangeTextNomalStyle:
            {
                
                //转化成带声调
                CFStringTransform((__bridge CFMutableStringRef)pinyinText, 0, kCFStringTransformToLatin, NO);
                
                //转化成不带声调的拼音
                CFStringTransform((__bridge CFMutableStringRef)pinyinText, 0, kCFStringTransformStripDiacritics, NO);
                
                NSLog(@"pinyinText:  %@", pinyinText);
                
            }
                break;
            case ChangeTextcapitalPinyinStyle:
            {
                
                //转化成带声调
                CFStringTransform((__bridge CFMutableStringRef)pinyinText, 0, kCFStringTransformToLatin, NO);
                
                //转化成不带声调的拼音
                CFStringTransform((__bridge CFMutableStringRef)pinyinText, 0, kCFStringTransformStripDiacritics, NO);

                
                //转化为首字母大写拼音
                capitalPinyin = [pinyinText capitalizedString];
                
                NSLog(@"首字母大写拼音 capitalPinyin %@",  capitalPinyin);
                
                pinyinText = [capitalPinyin mutableCopy];
                
            }
                break;
        }
 
    }
    
    return pinyinText;
    
}


@end
