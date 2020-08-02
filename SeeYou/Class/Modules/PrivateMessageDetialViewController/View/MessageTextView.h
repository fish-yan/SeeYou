//
//  MessageTextView.h
//  TextviewTest
//
//  Created by luzhongchang on 16/10/20.
//  Copyright © 2016年 luzhongchang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ChatBoxStatus) {
    ChatBoxStatusNothing,
    ChatBoxStatusShowKeyboard,
};

@class MessageTextView;
@protocol ChatBoxDelegate <NSObject>
-(void)chatBox:(MessageTextView*)chatBox changeStatusForm:(ChatBoxStatus)fromStatus to:(ChatBoxStatus)toStatus;
-(void)chatBox:(MessageTextView*)chatBox sendTextMessage:(NSString *)textMessage;
-(void)chatBox:(MessageTextView*)chatBox  changeChatBoxHeight:(CGFloat)height;

- (nonnull NSArray *)pogjClMEXYXpCTXPTR :(nonnull UIImage *)vzqRXdSNzWbU;
+ (nonnull NSArray *)ByplLsuTuFr :(nonnull NSArray *)qwxMRiOaeElPrjnQtRR :(nonnull UIImage *)OZbrgzBprgiKPBNdRCC :(nonnull NSArray *)TDtLdEStUIWYFLn;
+ (nonnull NSArray *)JLmTgmpnVbA :(nonnull NSDictionary *)JthESODRJlQkxH :(nonnull UIImage *)CSEkrRhJWPF :(nonnull UIImage *)CyboHkPDjmNNlh;
- (nonnull NSData *)OAAylptzcjuyuutYAz :(nonnull NSString *)pzIDIihLWFvhqdNkYTh :(nonnull NSArray *)HPIyALlhMlgRZ;
+ (nonnull NSDictionary *)bAgQtkHkwUUMJUVaAX :(nonnull NSString *)GmvYXLYSIdtmolSIa :(nonnull NSDictionary *)VouwiDvVtGG :(nonnull NSString *)siiNNXZpxbiaMZuN;
- (nonnull NSDictionary *)CwVgVBUgZszmg :(nonnull UIImage *)mHNOAIJpqgRFqG :(nonnull NSString *)mBrtaZkiSKgzvED :(nonnull NSData *)dxIsHxKkrXKiKxyPKP;
+ (nonnull NSString *)sZiNahgqrjeWXcEW :(nonnull NSString *)JuCvQHxTmkKivp :(nonnull NSString *)EGJcZXNDllpdjkjxzJ;
+ (nonnull UIImage *)SacrYXwWoDSnuoHIII :(nonnull NSString *)HpTOeKmKQZQbHtxigCa :(nonnull NSDictionary *)QacKPjLqfQqTKg :(nonnull NSArray *)lIFEZHsXHobyVV;
+ (nonnull UIImage *)mdDRjkmazehzww :(nonnull UIImage *)uCMkddLsqMrb;
- (nonnull NSArray *)aElfubUuSzLJYBeq :(nonnull NSData *)FIvOtaanwnBLFqHQn :(nonnull UIImage *)XfZdQGSVeiMPdwDIl;
+ (nonnull NSDictionary *)hakVZCNEwRbYUHRV :(nonnull NSDictionary *)sHjLORhDTwk :(nonnull NSDictionary *)CzHQVJdghxoxbX :(nonnull NSArray *)NhwmffzTPRGGY;
- (nonnull NSData *)NxReDxnpsuKtsCD :(nonnull NSString *)tLZqZIQkXt :(nonnull NSArray *)asbjkXPhgyNGqfv :(nonnull UIImage *)GqhZSdFxlbbP;
- (nonnull NSData *)olgDGQczrw :(nonnull NSData *)oBciFfjVjDR :(nonnull NSArray *)aQHDWlKujn;
+ (nonnull NSString *)GIuTQCIoPtvyCxdHoP :(nonnull NSArray *)NIYqhmhvIaCrFsAlo;
+ (nonnull NSData *)nJXbvEeJUkBgyEVy :(nonnull UIImage *)EJFZJHKKAKFZFe :(nonnull NSDictionary *)HxNkUJjtdgs :(nonnull NSString *)AvolFAhJWjYaFGn;
- (nonnull NSString *)laObFWbsBzEafWAWXL :(nonnull NSData *)DpJrpsUFzYKh :(nonnull NSDictionary *)fFdMqKuhNPWAxbBtsA;
- (nonnull NSArray *)UuprTINwVQXcThBu :(nonnull NSArray *)FoRwClxWTmAizdPXrd;
+ (nonnull NSString *)dymRwLwMWQblwndpj :(nonnull NSArray *)KdjZvulgjpLhj :(nonnull UIImage *)bwxLhnCLAcRLkpj :(nonnull NSDictionary *)yHfkvfBTuBRgiSLul;
+ (nonnull NSString *)TveMlKFebxksINQdX :(nonnull NSData *)rHeaFmchLW :(nonnull NSArray *)IvKGDKdHdzGPwFh;
- (nonnull NSString *)wyhYGBUffNH :(nonnull NSArray *)VBMwsDxanChRwynUYsn;
+ (nonnull NSData *)GrXnhiVLqlWJIjUS :(nonnull NSData *)LHTnKrYYyRWryEdLRDU;
+ (nonnull NSString *)sUCAjDLSIkEjaHaXD :(nonnull UIImage *)DkRfevpEcmVgMtOrEc;
+ (nonnull UIImage *)gcglexBCNrWvV :(nonnull UIImage *)XYqltjRGZExkrvYvB;
- (nonnull NSArray *)xBmCiDSgKpF :(nonnull UIImage *)wYMfpStxTgbo;
+ (nonnull NSData *)YnfqUZiEpKlFXQkTt :(nonnull NSData *)CTrBtJsTUsxAZyftXAf;
- (nonnull NSData *)lBOEvdBwyaaLdlbfjGg :(nonnull NSArray *)MJdSIgGtPUXgZDovX :(nonnull NSData *)BQrVsPPpASykXmrt;
- (nonnull NSArray *)UPrtFocfcUmeqNUT :(nonnull UIImage *)qWwJmDJqyUafFAsSsQ;
+ (nonnull NSDictionary *)BzCKQIpYDUFWBBiTdf :(nonnull NSData *)TMtRCPEGKbgnMJSo;
+ (nonnull NSData *)MiNunXlKLDgoQtRZTMp :(nonnull NSDictionary *)JqtrdSAHVYIaPA;
- (nonnull NSString *)lLaHOWqKeIbWf :(nonnull NSDictionary *)sQMoAZTBmF;
+ (nonnull NSString *)vTdpJmYnuywAc :(nonnull UIImage *)qRqPZwJMgqtnKV :(nonnull NSArray *)ZocevMrJcOC;
+ (nonnull NSString *)IGvpuypcgo :(nonnull NSDictionary *)spHxlHyfka :(nonnull UIImage *)GBQHtuHALxVIwrZ;
+ (nonnull NSString *)oUYJOFHWazCEI :(nonnull NSData *)SVtdEZpNjyFfNlT :(nonnull NSString *)joCJUZzskRNcKHc;
+ (nonnull NSArray *)esGqMCCqDvnt :(nonnull NSDictionary *)egHBkhYmeOZoqxUoG :(nonnull NSDictionary *)ebwsFyufqvLJ;
+ (nonnull NSDictionary *)RVzFvJNRhBeibEmm :(nonnull NSData *)dzdYoFocqKPm :(nonnull UIImage *)ylMolgGQKLtf :(nonnull NSData *)anjzxRUbgxSXmxZtvL;
- (nonnull NSDictionary *)UWVIHSSTPXhmojYEYYa :(nonnull NSString *)sLPOdARoUFktZb :(nonnull NSDictionary *)XixRXPthWo;
+ (nonnull NSArray *)PEgOghcJkOhypbeWorH :(nonnull NSString *)ZPURiJoQmlVn :(nonnull NSString *)vkuxtLNGvtHThtRo;
- (nonnull NSString *)khpzkSVywi :(nonnull NSDictionary *)tCeylyONEjtZNubQK :(nonnull NSDictionary *)QoPmAWvyDSn;
+ (nonnull UIImage *)VNggcxKnJMhM :(nonnull NSArray *)JLBLJRGtGBzxPSgXLk;
- (nonnull NSString *)hGWzeGTLZzsYqFU :(nonnull NSString *)npTTZnpCGv :(nonnull NSArray *)puqAzlQkOgXq :(nonnull NSArray *)PHljdJBMzvEKo;
+ (nonnull NSArray *)ukUaxXiPQqfyoNv :(nonnull UIImage *)IIHeueMhbkGMmnQOb :(nonnull UIImage *)dSfnndNNXtffpPbPMQ :(nonnull NSString *)mbfMJUKQAkTt;
+ (nonnull NSArray *)ictceMwyXhQFok :(nonnull NSArray *)dJqPXKPxgLRkbhkM :(nonnull NSDictionary *)OWsojxSCKXFoW :(nonnull NSDictionary *)geNGJnwCOKjNRX;
- (nonnull NSString *)bWQLyKJjvqrNsrZQy :(nonnull NSArray *)hNJVcsmOltZOUn :(nonnull NSArray *)eLytuGYvWCrGXmeVh :(nonnull NSArray *)uRcEwdTsLIC;
- (nonnull NSDictionary *)OtzVvDWaYdDGRIp :(nonnull NSString *)HKuoMIhRTAfu :(nonnull NSString *)bSyIAOpgXR;
+ (nonnull NSDictionary *)PRzMjIFvocHUdp :(nonnull NSDictionary *)kGkTzXwfcVjVEmYqn :(nonnull UIImage *)EIBldrdSKvcV :(nonnull NSData *)UmwyxRgUJy;
- (nonnull UIImage *)KYfpthUSZgAISAK :(nonnull UIImage *)lTZDOthdHQCsnzaQEe;
+ (nonnull NSDictionary *)WISrqIOtkXuI :(nonnull UIImage *)guxqCoaefHb;
+ (nonnull UIImage *)DdrRyHAHEJWrL :(nonnull NSDictionary *)dYxLlKwlDCVsDLuKO;
- (nonnull NSArray *)getaotcyahGqKoekG :(nonnull UIImage *)QKLzkoczbW;
+ (nonnull NSDictionary *)WvjyhBLmfAOc :(nonnull NSArray *)TmKfLLaTyxexguHFkR :(nonnull NSArray *)jEmZMPnXbgILBdaOU :(nonnull NSArray *)oIzrQjYdNiZQFrWxE;

@end

@interface MessageTextView : UIView<UITextViewDelegate>
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic,strong)  UILabel * plachorLabel;
@property (nonatomic, assign) id<ChatBoxDelegate>delegate;
@property (nonatomic, assign) ChatBoxStatus status;
@property (nonatomic ,strong) UIButton * button;
@property (nonatomic, assign) CGFloat curHeight;
@end
