//
//  RCTXfei.m
//  RCTXfei
//
//  Created by 许侃侃 on 17/3/16.
//  Copyright © 2017年 xukankan. All rights reserved.
//

#import "Xfei.h"
#import "iflyMSC/iflyMSC.h"
#import "iflyMSC/IFlySpeechRecognizerDelegate.h"
#import "iflyMSC/IFlySpeechRecognizer.h"
#import "iflyMSC/IFlySpeechConstant.h"
@implementation RCTXfei
static IFlySpeechRecognizer *_iFlySpeechRecognizer;
static RCTResponseSenderBlock callback;
NSUInteger i;
NSData *jsonData;
NSArray *arry;
NSDictionary *dic_json;
NSArray *word_arry;
NSDictionary *dic_final;
NSString *strr;
NSString *sumstrr=@"";
RCT_EXPORT_MODULE(XfeiModule);
/*
 设置参数
 */
RCT_EXPORT_METHOD(setParameter :(NSString *)timeout langage:(NSString *)langage vad_Bos:(NSString *)vad_Bos vad_Eos:(NSString *)vad_Eos accent:(NSString *)accent domain:(NSString *)domain){
    _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
    //设置听写模式
    [_iFlySpeechRecognizer setParameter:domain forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    //设置最长录音时间
    [_iFlySpeechRecognizer setParameter:timeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
    //设置录音语言
    [_iFlySpeechRecognizer setParameter:langage forKey:[IFlySpeechConstant LANGUAGE]];
    //设置录音语言区域
    [_iFlySpeechRecognizer setParameter:accent forKey:[IFlySpeechConstant ACCENT]];
    //设置后端点
    [_iFlySpeechRecognizer setParameter:vad_Eos forKey:[IFlySpeechConstant VAD_EOS]];
    //设置前端点
    [_iFlySpeechRecognizer setParameter:vad_Bos forKey:[IFlySpeechConstant VAD_BOS]];
    //设置代理
    _iFlySpeechRecognizer.delegate = self;
}
/*
 开始录音
 */
RCT_EXPORT_METHOD(startRecord:(RCTResponseSenderBlock)newcallback){
    callback=newcallback;
    [_iFlySpeechRecognizer startListening];
}
/*
 停止录音
 */
RCT_EXPORT_METHOD(stopRecord){
    [_iFlySpeechRecognizer stopListening];
}

/*
 结果回调
 */
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
    NSDictionary *dic = [results objectAtIndex:0];
    for (NSString *jsondata in dic) {
        NSLog(@"%@",jsondata);
        jsonData = [jsondata dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                            error:&err];
        arry=[dic objectForKey:@"ws"];
        for (i = 0; i < arry.count; i++) {
            // 根据数组下标访问相应的元素
            //NSString *str = [array objectAtIndex:i];
            dic_json = arry[i];   // 两种方法一样的
            word_arry=[dic_json objectForKey:@"cw"];
            dic_final=word_arry[0];
            strr=[dic_final objectForKey:@"w"];
            sumstrr=[sumstrr stringByAppendingString:strr];
        }
        
    }
    if(isLast){
        NSLog(@"最后的结果：%@",sumstrr);
        callback(@[sumstrr,@true]);
    }
    
}
/*
 错误回调
 */
- (void) onError:(IFlySpeechError *) error
{
    callback(@[@"error",@false]);

}
/*
 讯飞id配置
 */
+(void)crateMyUtility :(NSString *) id{
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",id];
    [IFlySpeechUtility createUtility:initString];
}
@end
