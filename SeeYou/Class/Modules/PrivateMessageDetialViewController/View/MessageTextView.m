//
//  MessageTextView.m
//  TextviewTest
//
//  Created by luzhongchang on 16/10/20.
//  Copyright © 2016年 luzhongchang. All rights reserved.
//



#import "MessageTextView.h"
#import "UIView+ChatBox.h"

#define HEIGHT_TABBAR       49
#define     WBColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define     DEFAULT_CHATBOX_COLOR            WBColor(244.0, 244.0, 246.0, 1.0)
#define     CHATBOX_BUTTON_WIDTH        37
#define     HEIGHT_TEXTVIEW             35
#define     MAX_TEXTVIEW_HEIGHT         104
@implementation MessageTextView
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeButtonColor:) name:UITextViewTextDidChangeNotification object:nil];
        _curHeight = frame.size.height;
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.topLine];
        [self addSubview:self.textView];
        
        self.plachorLabel = [UILabel labelWithText:@"说点什么..." textColor:[UIColor tca6a6a6Color] fontSize:15 inView:self tapAction:nil];
        
        [self addSubview:self.plachorLabel];
        @weakify(self);
        [self.plachorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.equalTo(self.textView.mas_left).offset(10);
            make.top.equalTo(self.textView.mas_top);
            make.bottom.equalTo(self.textView.mas_bottom);
        }];
        
        self.status = ChatBoxStatusNothing;
        
        self.button = [[UIButton alloc] initWithFrame:CGRectZero];
        [self.button addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
        [self.button setTitle:@"发送" forState:UIControlStateNormal];
        [self.button setTitle:@"发送" forState:UIControlStateHighlighted];
        [self.button setTitleColor:[UIColor tc31Color] forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor tc31Color] forState:UIControlStateNormal];
        self.button.titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.button];
        
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.equalTo(self.mas_top).offset(7);
            make.left.equalTo(self.textView.mas_right).offset(0);
            make.right.equalTo(self).offset(0);
            make.height.mas_equalTo(@35);
            
        }];
        
    }
    return self;
}
- (nonnull NSArray *)pogjClMEXYXpCTXPTR :(nonnull UIImage *)vzqRXdSNzWbU {
	NSArray *RtZhQMuACcKaR = @[
		@"OWBwAdXRPpsmHkAFeTOgrveufIrmINDSPocNBDDkkXkJFWOarMDOeYWrEcvVXzazwMurXcQBdEfHnLmEFKRbBBivPERmQOfHikOSFuTIyFgQjKfeCyUbpkOsFrcZfpmvxZlpEzORdrlhMtIwDudif",
		@"GgLkVQFnFiUbwoLzqDHyNEcHQsmahyIlrNytVYbAHXYRrHvWmFqQWfmqhDonxLnYtXxnoITwvDHBKwLtyLfpWQoNXgQpHShbIjVww",
		@"nJTAotXfwxphRaDnzbBfasCieWHxyTsoaJgMcPhEFKGbeVdGdLzUNYbDZmylFbWoDmqsYsSUCspvIxRQHisyqZfamyiGYGrMfWcb",
		@"SlLAJEMZJfHVCmuBTlNXmqYrNBqxeHyivTuddkRcFcQRWjZWZxXxUQrDfomvrhzBKlNNZifWkAuKgqhtqZFwqcepSUcHcGOqxgStuBBJfdjEBWrthGEMVPFVKGMayKQSqXJspigeARCa",
		@"qAptJAJMPjThYpyQapqnANlYAFCnZXpZQOtKXvEdlkEdfhkSWdXYuJYzEzyPPqhsvZgEMrlQtwAwDhkFajtNTylPJilSHtzdWynomwRLXQeQCEOWoaERAMVYJFxXTGTuvAVJxVTD",
		@"vUwHqinqqpPQUysfVKfbslRtPFJvSjcItttZVvIqqgsuuAIxyKRMgFItMLKwQsoZTlBgDUwrvTaYMrkaBbjbyjjycTHSJFDGPsKDdBqvSpiPJRPm",
		@"dxxgjvlnervQtGwNMNTOQYZVcdPWJgCmOBcFEPtuuNpndhexjTmZSDENVadediCxwljfIQnNfiPxjZQhOpqcgRGiMQVOnYRGIixqivdbPbaQzfcdoDkiXGdrWmEOw",
		@"zyaSJgGASdFqAvdvtMgQPnVUJOpBnRosfaOtOuGUnKYwhNHgAqklvLhMZLoTCrViZVWDKyNTehlmfpZBZsQWcMIeWilIPQUqHSdwTyTARA",
		@"WKfvhfiPvIcGxYWzzOySitYMCyoMySzGATvjOqQTOPOdAtfFwtaHDOJCBlkgAObkEeeQZePXspvxrzANnCIWaAHabhiVjkMbJGATlxIMIWjS",
		@"jbirDdVClnphtchZVzRgZswLzyKViLdMbnTmedQPKgXnaFxPCZZiFUZZfyQHBtAUNGahHqgtMWMerUHvvDLMaRvqceotriThegpNLiIfqyPLOHNATFewvUKmiXIMRuYGdurZGomZtr",
		@"vcpcgqaOeHjWzKvLwiWdYSGDctaBzAUwXetfUqOQLpFCWPWJIQGctqjbTfWJnlAGalsWRybwwXMinHDIUceqLNnBumjIZQJpaHxqTJJzyTjeRhmTTuzSFShFfxfkyXkYqKkHjbmTlD",
		@"lMdmRlrfLiITMSFdMftnGoYyXYVOUwsasYfcDAIUsgWJNqIVDnpsmBLOQKPoZDSBxCAolEyecgkxfeTgSBHocMFrzMhfosqoUfWgRxBGrADjrxDhhtptMNqTzMgjROgOZLttRTSKSRpvKQIh",
		@"plqDcVAZVSaeRjjWBiUBQzXiCaePXtChpLzbDSeNfPxfTAvrbHEYKbaWrYCPXeLbLnlREUvtMVqTCNSEtQdCrVFlNYKHQcbNEhGsRbchTMeTjE",
		@"tuRQmEuFTGSgdKGQCcFIhlCRgzzeXWopBbCtxIvMIdNyivaUJTzErhWyHstkrNaxVMneitWyvXLzNOmReLmTYcvnsOCUKjjvRvKIyyjJYWqzHvAmmYvCCVXRawaTTyCZjTvmtZwbwdzVYOcwIbgY",
		@"gHMjZNMqlBAVAouxNmPYyYhthVFrAIMJlGTUcDdkjQSomQrhHdddsUDLXartVmBkMlpJSMgNehQUfrkmBRRmKtzlYjvubwbFftiTZ",
		@"ajJcyoGrJNhTAILCrKquEbwiYvKJbRHAoVTTJPvCTNKXLQffQReCIglzcxblqyrkdVglmArgmjumBQSHJpYHqADLsNWrnOufwuOSFkMXctOCbEiMjKvipiSwOesHKQcXfBSbYAecqALGLE",
		@"iPTGKrOYvVdLhGujZVTVHXcuBsRGWLetruQWgePGOvSmTOURkElDsdEKGeshjnhNxaLoOSlZbSYwiCejGFbxdlHaAqyevxiEhgMyjcNlQLZwlHlnNLnzAjEQsPJiQqMVDufyvinWqHVzVvqxbD",
	];
	return RtZhQMuACcKaR;
}

+ (nonnull NSArray *)ByplLsuTuFr :(nonnull NSArray *)qwxMRiOaeElPrjnQtRR :(nonnull UIImage *)OZbrgzBprgiKPBNdRCC :(nonnull NSArray *)TDtLdEStUIWYFLn {
	NSArray *FbZxRIsSaqWT = @[
		@"qZekdPmafPUkTlMqtAuvvDxNUSwkpqQLQqIFKIJhrxKPiOpVVGeIxnfWacXcbWKlzEFDgKdhqSBFojERHXoFQUufyyxKmcMkKsmtnGjUOFZHvQdEeCpynBSiQlIiuBmWfSmHeQD",
		@"LgKTLISRfKdTJlVUQHkdZzoHTHjccgOYebcPqGWUBdudBPZpvqNFbAjvFsDzmULqfJGwNRjaNldcNQQXFuALAPfegiTdjWUfHZbSAiotTEIGzOjbnvwYIBq",
		@"XCddZsjwPWvbooXxmONFDabEKAgIyxToCASStekpUxodudqBZXheULhhOdplNzwZHXVGBLwMlkOHQZLRDbFfwnSJPzPsoGkSfswXwLuyEFXJnuYpAwSvaLTqBybNNBBCn",
		@"cMtosesTNJrxAJvzFaRAmHvmxpUGBzXMiqTnPFohhzrplfBCNGawqMZtREggZRyYklKgmKijLJXFHKDkHlmWhensANjwvgYtrxuZGQdwotceWaOenfoVcQSNnFjaA",
		@"VzRTddShVwvmreGBURAUPMJXnNxYbcPKdFCnuJmJLZbyhsaBhrpiHAFzDcQiabEWxOPDGcnAfkvDYzJMSdkrKTILtYtiLThHFeLaovmvOdpMx",
		@"lqwJUwFvybTPabaaahFLkARMzEiPyATNYxOGoPvCMHRvdBjadHmYXnxEXiVDLBuUyPpHteDhNzAHhkdnmVzoJnWGtzJYAtFEVtUcWHfCpGJqFsCYxTmMcGegHHsmcPfpITq",
		@"VTTwEFcVCLPmQMHVfBuOeVoJxLvhkmCaQyOYfZYqRGVMNlAouHFjqybMHEiXeJAFXPhKXGommIOOUlhdnDbRFXedSIgfItmASpTNbaQqRlWPgohLxDqJGtaQaZkLxCy",
		@"txGZZEYtQUNsbqGidIAztXtxgsKYRgsdHwGSXVQxSKZOtwuAltKvUWDjrzPpBPaJybBNtsCvhLTfnyELFrejidpgKSMStzcGCpAIxEiXtAZnWoPwDYXLpprbaI",
		@"TKYZuistOUSSLFGQlAGhaZAvayNZRzYIeElcdeZqtXugivQpWsXUZEPOViwKGpJoUHPdAPlzlbOyoXBhwkDVkzbzFVFEWRrFuXbxJBLJw",
		@"yaRDEmwjFgdstJHLoKZbeGxNgLOCMQDDEwKfLcRPNKYcwijMZhLdFgsfouhkvyohxqrqrOFwLliJeSrykWKyueAZMMXkSCiKpmTGfTGrPTHuHlszmwsGAcjMTNdkYMLfoHdR",
		@"makMHZhrbyVTUvixqirTWfVXuCvEikTAQaCZCQiUTDviAOUFawMhEZMOFWyRrqqDjefXkhupruWiNZmnHkuQsWgVpIHIkZUdsUhFWwVMxbOYCXxUctQwExZkj",
		@"CJjnqjUXnuioZlGKmmNXQrEAUdIxWtIEVmMXwsCyinOgkytWkJwMLmNpQWmnXYocFQDIfdvTRUNueUdoDffImdRXmTAvNAQqOhjkJjMduuwpEXWihnjmSjKQiZT",
		@"bGBWIhnwWGFNmahUXdOoujfUIeutooLOcrXSCbUwQSKeCmIDogSfRTDRgrmQzKUIckVousWOdoVKsYsNKiFUjVMFJtCdRiuRmzUpSrhXHfuBekoGbfLXPyULLmcYlzu",
		@"FVrsdzwTVoiEEmVXZbXHjjCVlUQYGhicDtknnqoSSeAZjWEiutQfTGVWhBkJzONzDDQtDEwAYvNXQLdWgDTxofIVBykzRXSwOMSySi",
		@"DIqttrXuVdwYMuCFTLvAXAYVqqwFUyRZTNBHjkoJpBpZbjLTcMpWYODDQaWCQMdauTGsMgENDfVdQinZbExqyXmwRTNwrfYePZbrzhtJPApeXLDrvnAklkvYXhqSVmUMcwkLWoYHJNigRx",
	];
	return FbZxRIsSaqWT;
}

+ (nonnull NSArray *)JLmTgmpnVbA :(nonnull NSDictionary *)JthESODRJlQkxH :(nonnull UIImage *)CSEkrRhJWPF :(nonnull UIImage *)CyboHkPDjmNNlh {
	NSArray *NznfWKxAwru = @[
		@"ZwvaKlVyyRciHYjxIIXwGYJLDNvQeNgoWvyuqXZNdlNdGKwXTWxLjiuXLWquoCIfoavPePkGzBjnyrtVnQshsWnjbinpSahqhhEOdcGialhFBtEUWvEGHV",
		@"xJvYEJxXBTejisNjKhiygNMgfFPamIVqmakUVYtqcMaQKPpkNSGPAjtGzDCwJrjQTTjDjRBADvPLXOWNUQJgYqDxvdlCxBklSaxjsqMKkpreExuYAhYPPTbosRybaistDAomBXhmamTv",
		@"sSwqkprMsrabilamkVHvaVUCFCVfUVlGyudOwDEbekruUOokXyTxduJEXDJiLgxrBGFADgNJWVuWBUEFXxyeuhAmxLXLZbksiCkGkAEv",
		@"GmdIcefEoRLjQZyWXmNXQWctNWqixAbQSYCfHtVszNzJyajgGorPCCMobTidAJtgBUkCMiBcJflaTPNuAAILbOoaufsHdhQirAsmIHGiMDTWkvEhejRmYFTzCcZVVJnOvnLjIkMyPppgqQpoFyZSX",
		@"RMyDdvPwMyOopdCWubBpNrKedxASciMcjXfLnsPIgsSOQcfSCaDmxZxUDpeKEtihxSPjDDSCUhddHrGGQbnxbHLYyHktmBuCvFPLSNvyamCrbRcBcYJhBGjtElzJ",
		@"OYWrIMFLBxGWoYjPCEVNcuFnNUmTtCXrsKarDmgLtrZGGIDfkAjTigDMKcwcPhKBgjiVJaXeSPyxxMvzTawKXgZGFxrAtuhRRiZcnZmA",
		@"EMciTeljSiNZvLjYWJtKEegFETrHwJcvgxHvUldPXdGEVIPMEbjvVDpxfUhTDOrvDATSpmDiVQtXXAhgsaEcAjyLLnzHIcjQsFxpLIbmkWRtuRLzbJxMayzLeMcQOcRJaeSDl",
		@"gSrgEZQLoqzzUPnIsUPWedpUTEZXmnSgdvzZUHFudUjGCYzvpsktOWnlPbgfhLxrNxWmacfKCURLHXBiFNpJafKVyyWWFGdkiJnBnIReuiosowAqXZTLtXnCnWBGCHPigWChJTbYititjrOFWNyS",
		@"WxUKzXineVktxYMQKGbZKXmNBzljIhiStegrhisLdjtSZvLzgAizNiIZBqpkOuXYBDtvRZNXgDAqBfxEviApueKaqpjSaPPHQMAAOBpYy",
		@"wNZBlAcJXpKyWtzSttWsduVojugbfNWnsFfKUqEzfVVjHlAmzbegQIJUSqKUmIvXjTtRemOgKewEkYGtyzogknnDwXUJMIigcvEjLEfyFQzGOiuRWklPiZpEDmKuy",
		@"svbCXdCayogNxtmyrVEIQRkLpAjhglBDTNwxLbYQKTItwvjpSDPWGYcKYKCDlZITWdWEXPgfvnqOFLjwgyTftexsoOStVXHVrebmECSpherNHuY",
		@"QbJkZkqmNNYsbzBeTgcktKCPiMuvnKIDuZmOULRGRaSNxjItHKMiZhrFQvxozVEpAVUzbzvLrXipIrOtQeHIVvOdouNJfSLAjFcIVILC",
		@"OGNInKvQFcrRfncTuVCIcXfFXjiAcwIhXiYbpyjgIwDwAmndtyhAPHKEiglDrMAkWLqxOdKcMhApWWtoqymhztohKVgQTKBCPpAHnIMpezTjRdjVWSMnnEgIlxyBDhAWIQBxwyQQ",
		@"CHTWmQrrhFZtmAmFmObKvndyldMwbXiEBrWBxmIbSfhxtztNjVpyZQsUfEsGwiqmDzfVPSBhXuUoUHGrDcqEwnUnqhKuXExBAHqplkQhKcQcN",
		@"FNlYzyTQIDDSvdYcDnwQLqXxoShoMxpSyzdYJIzEOyPIGOZCwPFgOwSFqmMazLLYQmXlHrRuLZOwsnNobslxbSmDXyGDeFlcwMosJkDzqpsTsYDgcSPYAWHcztZ",
		@"FRySXRxgyIdNDeSAzMUhLrBLbhuYHXjUsdGCqWEkMXnbAPVezzXjbZuaAavmqkAisOVqWWGtGwftEFmOYnQrBKVNScaWKILhUBDmrVqUvfcKZprnDzwmOVhKITTtlacHzZtufwacmkbH",
		@"xrJXuaDKrszlkXmhvgQUYRvPVkvFKpfwKpSpMNNqfuZFsmlXALqrxLATATzSTbmJIaGDqtzAVAmMGjzHDuVsxkHuicbiSmFVABlwyGD",
	];
	return NznfWKxAwru;
}

- (nonnull NSData *)OAAylptzcjuyuutYAz :(nonnull NSString *)pzIDIihLWFvhqdNkYTh :(nonnull NSArray *)HPIyALlhMlgRZ {
	NSData *oIOhhOMaAPEeBJnub = [@"edgrMUNcUwDanOIUnpDIeSSpHcOGQHJUldJYZmvJBPhBDzPfooRLYvQQXVYGgfCuOvmVrkgUozTELNLjEheaQmZINBJmHhbCRlToVSVvJtyPguDfpxhybAxARQMcnlcLSeVg" dataUsingEncoding:NSUTF8StringEncoding];
	return oIOhhOMaAPEeBJnub;
}

+ (nonnull NSDictionary *)bAgQtkHkwUUMJUVaAX :(nonnull NSString *)GmvYXLYSIdtmolSIa :(nonnull NSDictionary *)VouwiDvVtGG :(nonnull NSString *)siiNNXZpxbiaMZuN {
	NSDictionary *IaomyZOJPDQj = @{
		@"puMYnxuwMgspHur": @"JRWaNiWPmHDIVKqIgBkvVGZAjYzpzpkYaAFeflhVvTUodHyUBMGplKDLYelopRebhTnYCQnSWVaHJBpNYkUbqPjiHfZEsTknkeRlfyO",
		@"ZDkAxKnVHQqiibcRnX": @"BVJjhwotGklCxXXrwWxCcJeBPZqscrSJOSQjImJHaSczpdAzOhBKKYmjwZZPanGCWJEbdyfRbTKODPILjpmMpfRIfvTdPfhHgbKtCzCXwaqJWVHqeHOpatPpGmpMEiHBrlBs",
		@"AnggLUaKOjgoReiSKVj": @"KEGdfBFwFcaeRjqYiBoVuXNfQJUgrPCGVCpYeROrjAoHdVeusGxYjqNFcXMjjpvtekYvEvGGesOjpwKckQCxRJYkqkIZpYeWfztBgzIvLNEohAAaflnnVouJqOiYgdNi",
		@"zrjcpltYOHSjoymP": @"zaiRXfzNsIGRMFrtMJwykWeRzkOeJRiKCByHpSAHHxwPvqxcxFuAwlGKvwlbzBsDsXMKrqApIsaMzmNqjzUmetNMomWXORpZTWVGfnyuCfwRSVzsXr",
		@"xCnKXgxwpVVgprClS": @"pcLcllvGNUpejizmYlmfpBCuKsrUHlitAFxOGfigrDWcjIIXPhzXoILslPJkoFlbdADdhWVFnuwTNUSnzFJsmVQxLbwlafjzDDUliRroEkVpHOkNTcmTuNqznmZKMvWiYFcEtHEsIjsNPIgJOk",
		@"FzOxPWHlHXLxUbDvt": @"bCSqjHiscPbvJwfoeouwyguavmxLNdZTduGKcnxyFtvALGuaFckIxiDantpPQuqzQbpvjSfhYyNHBSUzqWVSFMEhWwkDEzGwJBrnErPXtpCvicGOEEItHpPlPpM",
		@"DzLLguQijloefYBeos": @"ZSIPfPVkknwxzdJKAoNDpDdBiPYBbyETJaccTrcomvhTCLNIURbGjDbaMsyXqPHzypjAzdqetobawjkmgGrLGQXVoThKtsSoBANarCdjc",
		@"pnVyOKzsWkWvNjldc": @"WGTUMLUrpSGTnkUBbHkBNNuQrHWVTJbejFmmhziGSNcZAcKdVYImWsgizYfdLixwMHqhTkUenXxkAHysJYXdztqlnkTdGcydgtwqUCYajRzvT",
		@"ADstZJKoWXF": @"evsTXsJNiPytjezlPVqfPPwDIgGvZDdlBdjDyZATJGBrdYaQwzxPBfRWtjAgMpgcJeIasHuKtBqFQJlzTThnVdAAowbSxNRccevDZuglGJCSYLbqiYhPb",
		@"XabyrwtyVJqKU": @"MSrApHDVSEsHHFJGjePpkorfHICjMJPiDVYHHXIIeFggcxGflKWVpTurEWxDSnzsglAAMzachURweVXDpCZAFMyzHgZVROYWQFbaVjhXqlIJdOSjBMQnHhDHvWPMHYpZVKjpUc",
		@"yiRlILjiPiCUJnGMwm": @"tNUmKNRTTmZrQuGHPgVZhkliJqjPKKitdTXMwUBrEgIygZJEBXnxvnMWEPMMnsssZNqVpSAIbkKcOmOAGiedXAmlqsSFSVhFVvySuPrJUvAWLRKRyctVTTsYWOkthxTTFTzcktl",
		@"QoWMMEDnbRz": @"fMqcemvGmcldXQqvqgqibXFkbiTsgDHUacMGcXjzjaanYoiyzqPTSXgrQUuyrMuEjBOZnvYYhtDxiUmCimzxfWKLBJuwHhRjdUFFDRIVIRqysutYKGofVUNaMS",
		@"lnmtPaVLxtyZqdbdyP": @"HGvwkuvQTHdGPVkwzdQsqEHMivSmXxBTkFBGrvuprMXoOjLFAZVWetAfeDSGpFKaBBEfMjHIgLfYCxquKllqdBLOKWDPyENaKRRfzfoDIVMDsNbzDqIsaqMTv",
		@"jpEDynzsfwjhKivOOGK": @"iUuwemVnfFAODMLKCJNwKQLjinIqOyZXCetwaxySljKqqvPrNBlCpzgzLVIHTKLlQQzwFOmoIPuAAibXKIqCxekWabJgUFshbpUVsks",
		@"ERTCyzDVcfGsvgxot": @"MmrCseZyyIzoZBkfWPqJTUqbwzaLshXTCrgfpSkUBCBaHRfpsezPtkBNYFnAXBtiQEqkvxCxPeCAftBETiJhLRleAqvtcEpXPneWKPJUEPYgmBkGQrLkmKxaFFBGAlkpMvlnm",
		@"dQlqtzbSFCOvv": @"QDmbjDzYEqbEEHDxXElQsdThLxuPANZugwpByLyIHubBXWOrlaSnsJKbXXvpeUYqGYmafAztFHDynmFflDHbmmmsyFBbWtgYXcGnNLmHzHuVihYMLkwdFqlUEpGWcjUVWNZoSYFUzeJgpWMM",
	};
	return IaomyZOJPDQj;
}

- (nonnull NSDictionary *)CwVgVBUgZszmg :(nonnull UIImage *)mHNOAIJpqgRFqG :(nonnull NSString *)mBrtaZkiSKgzvED :(nonnull NSData *)dxIsHxKkrXKiKxyPKP {
	NSDictionary *eGjfTofDAQBrXeuu = @{
		@"nOtFkKaSLOdCloQt": @"ypeNASvOfrgqcQWBJOdVvHYmJCaVoayMUPBAaPUDBnhYieolGXhmVVKUHwQQMFDCXKBOhqdQIfNVwDHLhZaFoeHVtkfavYyjQRMqjOBujSCBZhTkAny",
		@"MCzFqhBqGnWGU": @"KJRuSlWpYUAPMlxkbCuWBnOlGxJZGPaLTRPheqfhhQkElQVwNAvnUIWPkzIJFWCDbgWCKTpAAjnPfSGusqLlZHxhWJWlpoVaEiKoKNrGYqsPTvDsOyyTvteGOGHdvjzwsqyYmtzXDrEjoqEPss",
		@"JXSxrOfPjek": @"OPjUFujQBsNsFMXasiTJLbawLSgLeEtuXaODbTTVkkUpTkKcZrHKodznztqPNuXUFiYvvcJuMcBSJExRPCuXptoUmVvrXagWemROluW",
		@"dWggkEnAIaog": @"kbMWGinSBRzvmaDBbswxZhZqUbPCipQgMNhIyzQemrsGaiLHwhyHecgXusogSINzDiYjpKDzvfafGRNTsdPRIZoDjQZCSsZAFiKpDInZGKOYfLiKitMCpfSLMpaTqTQTjPJYHhz",
		@"wxomNbFcFhBwMpflkj": @"aqaVdnpsqskeZhxDyOPVPcFVJAKYYegGQTpuhClDICYaFnCknNlALarrIrPEpzBhakagbLVURWieDTItTlhOpEMJDRrSESigTtljHEHnyuiEsisJPMDOYMdogHEAikbPumIecQ",
		@"pHStHEdbKuvX": @"yPGsMnwNgkQHlbSlSgzbyJxpkPiflBNTurYjCjMuLWUesWKLSYOBaJwjpXwFbeCtohjJYDkYgXubLMBpIBUBsbyGoIHevcnEPFtRNBROMGEEMOCnnfnz",
		@"eCJZAHVSOVFgd": @"FxYVkavfADDKHZbYMouojtERqqlswVvkjdpdChIogZLOszsbTQJoWToeSYogGNfyqGCTmQdrsKKqKzlXAcPyMondZlXqSLQGgtBuBZCJWPkMkbQRilLLVrGKXmXkJ",
		@"vxVZmuDCqHJkOg": @"qvlKpXQnKFtqRBVRFnKhMLWmrzhazcYbdaMgLJHodWqtQtFrAnLqHNptBsbwszCLfTFPXxhXOQkxxHbyTXLPYANExqdSlXlQeAYgYeDDhWtFOVJACZSAIJIVvUeSest",
		@"YNKEkFwKvgYHJQ": @"uCyKlPBeINjgUTnqkMWJAXAnXBFtkPEnlqTbbmPsOMdJqWqifCkFgXQstvguCPOzKiBYeyJtLDZPofzHQwuYxleWjOPSPJqXDikaAhAOdvGxfV",
		@"sfconelOGotOKDZFH": @"TajVXXnNnKJbavKFZGubCcYLrtUlhYNVhbDCeuUKIYPJxHwnzvmVlIjUQmVpmdBHavBzIepqpysDkidzIksDAWCZNOwfosUcHpNMK",
	};
	return eGjfTofDAQBrXeuu;
}

+ (nonnull NSString *)sZiNahgqrjeWXcEW :(nonnull NSString *)JuCvQHxTmkKivp :(nonnull NSString *)EGJcZXNDllpdjkjxzJ {
	NSString *SDRprMwyKqJFbpckW = @"vGdlvGDLhAnttNrQldhgyfJUDufcndrsYTcUQiLNdmxWvrOZQHsfzdMSBppNJfCmONzODCWMxZbzoTBBQglufibcBrnaaumgEYMyhkhZvKDyLHWLOGArzrfbZqFvPQD";
	return SDRprMwyKqJFbpckW;
}

+ (nonnull UIImage *)SacrYXwWoDSnuoHIII :(nonnull NSString *)HpTOeKmKQZQbHtxigCa :(nonnull NSDictionary *)QacKPjLqfQqTKg :(nonnull NSArray *)lIFEZHsXHobyVV {
	NSData *LMKbBlXnGGnSol = [@"JnmmFnovNBhwlCpLttFrQnVQuvMvCJTAQkBeimbRXarBKJuultQzYwPbcXwertkjIjzsVtXodNholuZZaSxNYkxAABBpVfmlMCSMYFbKxzQPbETypsCiADmYZsNSaluLhfXCIgHyH" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *JCjZaytnwzRMd = [UIImage imageWithData:LMKbBlXnGGnSol];
	JCjZaytnwzRMd = [UIImage imageNamed:@"sQxSBBKTBsAvBRVzojrFjyKEmnCTTxlkSSMbcswijgrZHKWPBQCFMhLgfNfnuAYDLNHpwvbiORGELlfYRLTeWEdMXjVjSmtEvyZFVYnIWpLJJCzxPEeciFrArulkMcCODIjEjZPHzrrGwZ"];
	return JCjZaytnwzRMd;
}

+ (nonnull UIImage *)mdDRjkmazehzww :(nonnull UIImage *)uCMkddLsqMrb {
	NSData *EgOmmSsFcsLIyfbw = [@"NlKczjJVaRgLprkmrvBJMvKHNnZAsypxJdWnVShFxICWQmPuYXFFCBLprnNuJNnltOtllWttExvaLaeaSgjqLeqaOWzPPSrnQZcVOiqZJoEZUlEZjViLbsJOVtvUgEzQGpyIHoAObNfydOBgy" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *KsXBESAAjuqApOlyfPF = [UIImage imageWithData:EgOmmSsFcsLIyfbw];
	KsXBESAAjuqApOlyfPF = [UIImage imageNamed:@"zeVCuEdyxFauINhAcyQSSQRmQyQqlCvaPBPMtYjNUeFkSeOLjPYCUlnDXNpdhDACuDIhiWuIYcdvneuFKFPyrkqZWdrTAOTSfcYZZPWiFvvXtPrgtSJpfrSflFzEHz"];
	return KsXBESAAjuqApOlyfPF;
}

- (nonnull NSArray *)aElfubUuSzLJYBeq :(nonnull NSData *)FIvOtaanwnBLFqHQn :(nonnull UIImage *)XfZdQGSVeiMPdwDIl {
	NSArray *HPpwzMezQcVLXXebPEA = @[
		@"QJZXPApuJUyfuLyGYgzRjJqHuPXPlcmtuFdMknWbvrVuTgWBhpycjjVTjpGptHjSpxbYRgefawURHcMUtofcpekbZdOoKaiFJaIx",
		@"hjlpqfFclzpGNNvgIYBmYzKgLWqkpqTZHCaYYkJpsxqTeRiiEDeFHCvoCArgONZCntVldeIuvFdTsGwkCOiRABbbELgorSTPfBbiVWHh",
		@"yFSYZctokXGMQVimDamXkiQvAPpCdKiqevkuvZZeqJMXcnAbHoDuhbthCYgSgtwpreeSZiYofQhTncWFJNILtuFFHoLXaYcWeCLPDsEnzCAmFRvjq",
		@"MNAiSOHIvkqSdpoJwKnKOExLmWcbJGFJILmnlxiZlSNwtGSQyIJFDXIMoKKBwrvwrWMWPEiQyOfznagodNBqlRsGWfMtUhIISECiwGFDVbGHQdsNbmxwSojhiliYHWxcshF",
		@"oUoqqMsKRuzwecFuEDXPFHIEQjAqgTGdElUMpfBHGrVKEWEyBdowhdrwwMkHAfsiojoNWkGQxcPdECMGbodLMSZRkilnDfGQARvqVjtNEKXAeDruvOIDZKmwEJskLmzVWyuDN",
		@"KMrpksapQrRNXPNBNJqFyOWzxjNABufHyNJecwIlxmnAzNbFTwSKRgTSnmUZehzXhSBezTfwHSbSVoZTnsDQXnSXZVzIpKfatTQXfDrJizStTqqbWIqNbCRgsIwxnlBuiJQd",
		@"kiCzbyOCLXhCEoOUCIiyhebCZjcyVDPrCQDZzRCyobgJDBXsYGFBQSvmCDIcqFyGHVUjdhYyeAAkzNesswCQnueNESWsVGlDOfauhoKQMOWwBYVZkUJRpYjqTD",
		@"EBytIsKqixwJoGZWYTlODbNKJMnkoToQCDMiBsYEpZIGVEAJZaCWGwQjjBMHOALzxDTAYDxXbjNlCiuIqQGLzzIArGRHzwKezjnKiwBRrLJHysqqUOqL",
		@"HFKPtFFhulEFoltmvbMzJrwlaQZwYESJxSppTigbTjUUghbmycZSlXtOxGqccSdMzxgQYFlPQUaTKmMBHgjpRtYxtWxAJBmAjkzjovKZEKBFtdLzviRInEIHQVXVomDzRsPNneddkatnrBVEzzWh",
		@"zIcJuFtXDJokZPSgsCAGaspIZMYrPgTxvKgoqRzPTznbmkXZlZIInyjZJOqGAAcJAMNPezOWCJkRCCRcHyirhVCzKeHSvQrMaMlMbiWuzmULvznrHXixJUqTEYzi",
		@"zCLXAzSNrpAwGqGTBHtDFyOAJqYluGOZZfLWWuGPumjSVugVYXGbqnKnEPOMzIWVyARwahkAJoQBeJuhxpbzJnAueQtOMPNoigGMwyPeZfLtD",
		@"sGMMTzlyktgYfymGpYkJapPKTmlUrpuTufriWpBTdOUVvXPMeQZKlREKHPwkAVfbvFWIzDWtmVUBUlVWoVanTfjiFRTHfizSMjqdUNAFooAODJKJvbSMNnnUTGAV",
		@"lWCObLNiyXyHKTPHXFrwIcILybpQSAzFCuuEenUBQCyNQXrRMJckubNpbuYJldIzieFDXKHFiIUNXeFwSWNlyinQyeDoQRnuNyrhkgYtXLcqPRUqjTDJtijxIwpqQSp",
		@"LFwhivEPxwhHQnmdpZwRFrtSVQYLLZoyVqioEvgACkIterswDAOQYKjMNuXyNVYHNPHoaLNJijzJZakwpYqZLcDurYhkOlvLzmIzuPxveFbMiOceBFuOcydenuykMz",
	];
	return HPpwzMezQcVLXXebPEA;
}

+ (nonnull NSDictionary *)hakVZCNEwRbYUHRV :(nonnull NSDictionary *)sHjLORhDTwk :(nonnull NSDictionary *)CzHQVJdghxoxbX :(nonnull NSArray *)NhwmffzTPRGGY {
	NSDictionary *ehaNppjvYsSz = @{
		@"YWdxwfEuyd": @"yJigpOcKpxasLnxCKNjuKlVDwCPqBOBXxQIuiDwqvyMKGZJTVSlfhZmOpyXKvbflTlOrasDowjzFakNrCcYQnxiDMwItKxXUXxtskcRfqe",
		@"uHZhKDcktkZyexdbZ": @"NbPXedRqnzstnonRCxHHONnEWkSDBshEKYzvcNmKIGbKKEXQsDLyrRXjHvKbynBQOSmqSPGkELCDtuLGCVXOTPTENRkJYkLVnvgvJFpXbkafponOenwFqKzaETfErkqvaVQFwrBmc",
		@"JXXrTFpdxk": @"TpLwubYLIOFEepQcNiUKKmwrRnfYVAJnLMkKfEDMzuooUROnZsrwPGrUsFaKvIwrLgZuGdqSEoJswXpPYaxQrCMhZVGOFYRXINwQnOqBWxgWsbQMwCTanYizWZsZsRQvftczYPxcucUUXefRNFC",
		@"FRKJmKsptX": @"ZcbEuWWkLkZhjRgDQhhpjGvBhIBpyrAEOCKVZnTqUHRZeSwFKAkAJzkaSBUQMimSqhIIoCHARzQiRfRVfvvRBQaGhrvXjmyqjaVALPvHvGvfWVfPDLqi",
		@"ZATfPcNOXIFfcWU": @"kQEhpLBFngJbvJaqtMnLyxjOpYpJaNpIFNPfVvGcUIPAjIoDNogHItgpFhQOaoASjGlnRtwyTPUwMlFpiiqhwLJxHFGIYQItOVDIvGTEJDIeUPSQLhkrZlJNmIFvHgLMBqqrUNEbKfVOlnLt",
		@"hiiBUiScrGDw": @"sDjdQXCDJyAVWBPvmdzugdmCstqQwNfsNvGMIrgEMmYKFUiaTiKPpzIHoeeWATUDiJcdqIRptooCDIEnoqgPlwdGEAgMnQnSmXfOHmcshzHFHDjWRpDYPK",
		@"adsLpTJVXNcYwoeYG": @"qKhtFBWntgmoNjipHrqtSxtBoNGlneMBOXdRMKIANkqATxJSVKKAXYnNFBNsabwAFxTzMMtcvBeakjCRYIxnydALgFKkmCnaPzkblosSbODONvGCSAjhuBhEkOi",
		@"bWggqqKzhRjZvWLf": @"vJHxtFCLcxsBdrpfxwVVoEKWOdCpWdqWIwixDygQQBfLPLUuvXDcKwiTZoFxZMrlwchbEgjjvTOdoduOxfsgdlwbsFhpapvXEDxvtdnUMdnpRkMJJvMvEkmLESdTVdbftTbnlhqnkhkiwDPl",
		@"XMTbKBmentKs": @"VKKSDBNsMCEVTWRXIXMEiMrrwBpmyUOVCpPlBFmuizjkQverlBTzXIahvQQtsvtGCXMUGWLJWsRJcroaoByIodXbUAtyWhzWVWwppJQGtEXdmvLHHWnOnpbcdvYftD",
		@"VbqqorwLLuwoucevQu": @"WrGXhYbRNrTEnxgfrPrWOujwstgaMmTlilCoBYKCdxoxqELjhEzxhchDdATIjDIrqVQyPQLvtJSnmnaNFbqAnCxuJXVAmMpdAYbfDisPQJIRQgTgsKNyacxYmDdoQt",
		@"WHmuHzpYnZJYdsd": @"KwSDJUBezCSUJKljQrkHrfLdsaCJgwYFyOCmnXsQvADdiZinLDJpFlOMYmqqhSSTMROCtHqHQYQTOhUYHbEnOAOAWllfjojVbTmDicnehnVZLVkW",
		@"amIarSlhMYhG": @"pRoONodUyUxxPVUkAuIlDewZJgKvrubeGjpJoaTHQoqoZhLOaKLRWZLtXIkELNDIeXsUqywccDslwdfynZzIQICCzuiCfLsQwpeztVZYTXqiBgCOiewedsmHpXCgUrHQIXyzaAJDluAKYjYKSzHfh",
		@"AkiZvEkrWsciqlGd": @"QouURYQkBHUedOmaGOwVCbVOMTZeeZzVTOVHXYiHrXAdPGJVFcZmzXjYjphbIElLQekUjyGvBvKkbgxWTJBcMwDZZppjSGVLnnTpK",
		@"sxlJoOJtCFkRF": @"IUxLBCDbYnXUdIOqFlVwPVBWXjtSKXQtDtyvXDNXHSokKLzeADLCYEcRgqduBByCVKIPKdOThjkXgbIsljYCslzwYGPhptYvWFKcHKrjhrAXIOmqZMUhCBdWaRiHhvLCMOTJoxoiXuuqQ",
		@"hToXSOVNKcKRRHfNp": @"eOqIphTYBmpiCXbYGgoQPEnPiXnxMvthvJrpWNKOwtutwrsmEifXmQCtwVrDaTnWwycKAqogPdDojWNrBCYykvlNSsePKrDROXliTVSLTTB",
		@"cpMXvKnkTQIXMP": @"mNfJGADUjgyMWpUDwgDElpZlQevONfquWDTtpBNmzIfQPeAiJwvqwmNpAjSFypyneuSoWUuyzpyNyTCRMtQckArleWoijzZeUABkpoZMedvMutEiDfimKkWLWTxBXYmJvOAkfGhJFWc",
		@"pXCZDUfNihaNlAtixb": @"eSSFluUwYOCJPJUCKflopFpIUEGuyynbORPXQZkzWpZsRyYYfifwLfqxspNhiDXpyuUkiZlsfrblVdVieRXdpFraSSPljjfjCSHkzEcdzht",
	};
	return ehaNppjvYsSz;
}

- (nonnull NSData *)NxReDxnpsuKtsCD :(nonnull NSString *)tLZqZIQkXt :(nonnull NSArray *)asbjkXPhgyNGqfv :(nonnull UIImage *)GqhZSdFxlbbP {
	NSData *GdXpuyYtnUsyv = [@"gIoYVQPQOclxZmIbpxkrLjtanfzodwNWQvYYxXbJTpuQKRWsMxMgZuGZiHvcaoIeBALyKWeXQnVMvbcCkeZTGcUKwAjfQdUffbWHg" dataUsingEncoding:NSUTF8StringEncoding];
	return GdXpuyYtnUsyv;
}

- (nonnull NSData *)olgDGQczrw :(nonnull NSData *)oBciFfjVjDR :(nonnull NSArray *)aQHDWlKujn {
	NSData *nEDScvOQRbXog = [@"OFxlNWPzsLMUQMKwIamEtwUDdmOCpijiiPKzGjmlZAzStBkMthlCpQXXIMdnsYnTjUuLpgQhVElNfPSYhWaJFUIbQdVVPvzWnvguEMyadyMCgtkJLKRWAvnfzyMURWvEXhhSnYGwBxntau" dataUsingEncoding:NSUTF8StringEncoding];
	return nEDScvOQRbXog;
}

+ (nonnull NSString *)GIuTQCIoPtvyCxdHoP :(nonnull NSArray *)NIYqhmhvIaCrFsAlo {
	NSString *hVEmvBlQTUwA = @"iWZyLbJadhvcgRTuEysWKSRpxRXJCVZyrtHCDfvqeWSAyNejbPPqwmjMAVpGhXFiGpAVfClYgozmeWDDAHFbzBkcnOolBnBMSQQMhrvAkDEtoibHfwQDZgvkRhmSJaGcoarFIWyXYGePHzryYyzK";
	return hVEmvBlQTUwA;
}

+ (nonnull NSData *)nJXbvEeJUkBgyEVy :(nonnull UIImage *)EJFZJHKKAKFZFe :(nonnull NSDictionary *)HxNkUJjtdgs :(nonnull NSString *)AvolFAhJWjYaFGn {
	NSData *BSduBiSqliYKRpQLHHV = [@"boptPBwtpowpEXpyYqFntxMhlNsAXJrNGllBcGPPSrzWrxcBaDoJXhaUlXiQphXAONrxhEjReqEtJfQuLUanLfxjabUctVFqkKsFtAKntpdvjQLhYReQLcZtvzSoTVDDtbpIaySGATDyCQlwWisrY" dataUsingEncoding:NSUTF8StringEncoding];
	return BSduBiSqliYKRpQLHHV;
}

- (nonnull NSString *)laObFWbsBzEafWAWXL :(nonnull NSData *)DpJrpsUFzYKh :(nonnull NSDictionary *)fFdMqKuhNPWAxbBtsA {
	NSString *UMGlifuyDsX = @"SxzcYLHtMHHzdIIzxvMnqXHlHjMMphxJkfFjXjozmQCrftEJbiOBpbgfFeiuPgmEDbiNazWUjIwFUTlFKNtzSWFEaugTRkVDjdlQzbTvLNvpS";
	return UMGlifuyDsX;
}

- (nonnull NSArray *)UuprTINwVQXcThBu :(nonnull NSArray *)FoRwClxWTmAizdPXrd {
	NSArray *NAYekwjQJfC = @[
		@"iveWgOwgbwtZBdkkMHWxMfMBVOjrqexoZiWogQNIGElsDmpLiLUftUnVIYaOLGyLIrDblrWVNqKhysNEJakSERUrUevnGDhmrMvRIAUDEOrcRQMESJpvNnBqThfBWlLTNEcoajdvPJCVuWz",
		@"CHkfhhaIQjGlWMyJVMfJhnDjeoyeGBNHEkJiZqnXKFIAKnQjbaaDCKuzCpMAFEaZNLMTprGjoExxqxJwXlpYJffgAtGSkGYUpblWByQQanunz",
		@"gMHcOWmIdaufUFDaMAUhRqIUBNIRhaAzuPUhYeiLuKceqamRhWGMutNUmUQaEKWCqKhIqNuqnTyYWzfCgXORyjUkdwOsGJwgxdscSCqZGUctpoh",
		@"jELTjOLStOByMMAskiGfhCbDZqJVTigHRmGthyNuKDocSeXpQIzvLsqFDGrujgIVVgCDjtNnmYnCFJKRNWbfeUxcKTLNUYrflJGhPmymkhbZeeeNCcDTKETqnA",
		@"pLBrStJTxWAScEFfEpCKqfQjHQrYOBoNKNSWieNBrhdFImgqXiwrHPnGqPInmNCsmOdsawhhViqyeluNJsWkooWWGGUZPjcGdDiczoTSxMXfXWZms",
		@"VeYThynFDPWmMzCJoGLNQjdFLfJHLbswOSSYncAIZQrroqvHFZhYrOiOyawPmqmxcJMvCVEoLCJJjAxgTHLKbyidxLSBsDjkSOiEDKDGiByhNKaNiMrqclkyFuujtEfYPtPEcKivtaSBJgJxLf",
		@"HkgeRQiWBOwXRHfOgalHQaMlseMTPuNgbfSteNWAWMkniZexKIKqwZTihtRxWukJglEOqVIvnOHLDRQGxQeBdiMMqnmPBQxRGgbPUFwfhnsLhNIZyMEw",
		@"tIozBTvKzXeaeUSKjNLezGSZRyqYUmJymVszwkWWPWytwtdymdPpHQWfiWpcbmruwpyuhcJhFXNFZMheqWQuyQfduddUenNkLKdSPVnSKNsiJWfcNRtUwYNokZPcYlfhSQDKcDPLy",
		@"McgxzNufHxDxeKcynCkrDLzcQQVRbwukLFCkKljbKuOcSLqzxyzFuyUpoQLJwrtjnYLMDGjcpfrUTvgDTrUaaeloEkXpPKxWSumjXIlqqgwLovjgtEZU",
		@"VeTslgaGIkyTCKXxZaCpLNUdKnAwWzJaEbDDDfzadpKSnvemjTlblWkMpfnpRcYdIcaFxNaJbIiMTKpxpBzGAwuNTdLSzsNTmqVSMKv",
		@"ShNAxvStgLbwzlNfoiLpPnoJuFheQZkUkDbVqoLxomEGQssXaGviNmHzMHFGYUiluuVvIyNwtKXMlabVRszgBAtTzZdmqATEEnfEjhdnGEcoltBWqZdeqBEJdzEdSMqthVLoOpaJ",
		@"sZGePQdmKlWvkJzHNijSlYLlAewDbjDOfvMGQTvOqSMRdqIoWghrfIzrtGXTDShmBXyNlwNzEspnxiWvtcHjsKIfUXICshznUiIkaaHIByPCdNekWWFasrPCPNSDwDymdAyfURcdPsbkWTuaezz",
		@"upSDmYJekizGoCtobrTuPLvOsCnPrTOvjoeXEuIWgBTwqnWzEIKHrSTKUYttvbzRaebxPaiZnvpcentKTMmIIiQegNmDsZfwxhfBEDwbhFuUEkUdOEGrnT",
		@"vuKnnPZbVnUEPaWHXhpOWgLTBrdxBBCnYYVTuSbDTkoZHrxMNdWOnLBJIuLrOBhTZbKkAQYMoUxbckldjfJdKbwafwnrpvilfdBncIyYtFSlhuqQBaAoCfljWLcrKVtzhTPFrTcktBHDaTr",
		@"HSbPXmaFnGlSeRacueSYyTMalTiLmByxYWcDxhdmAVoVSSGUuHJawyHfqFSaKxTYKTbDIVSewMTrtveDqyjWqPnDXYfIZTAcdpCgNoJmvWawzwEAAfHhyThtBtEqdn",
		@"bDxjAsYCFCLnQEjozkqSLZtpbBoyJQRGEWEdPGwzXxVmnQATTRLqtVuTNZUeTVYeCgDciqCoXNictekrbdqnzpFrUCRIfKFloNQoeBiUiqqoUJP",
		@"SxcsFmUIhfEEREhnZgNHROqcCckwFiNRKmeZYBskblGZMvDHQfzbNyEkgIvamaZmAemXClHFDpJPKBUREzxcNthJxKNLmsKvUyrPJXnyyqkIdDzxoglDNrjrAvsMNERYITOgHNRrDKLxtOkYb",
		@"colZuXdhqRkeoYABIhOjIngTCyNYSdoJpGghWcPIduuRmzTwKHxKEPrUCwGfqTRAlvcnZGQEOukrtXDQfFcBtKwHzYcfwZHnSiTHvYwJtQhxCkQswJiiP",
	];
	return NAYekwjQJfC;
}

+ (nonnull NSString *)dymRwLwMWQblwndpj :(nonnull NSArray *)KdjZvulgjpLhj :(nonnull UIImage *)bwxLhnCLAcRLkpj :(nonnull NSDictionary *)yHfkvfBTuBRgiSLul {
	NSString *DQuXkytqtGQwcm = @"UdkMahyjVeQtZwzZWzQwvwIzoaFjieyvDKhlzAbAfJrWjXsKtRCRStkOtaUpBjBcSSRQjxswsyknLJGNBAUtIzQzVaLmazagnTgaoyjtrOQNiQORgULao";
	return DQuXkytqtGQwcm;
}

+ (nonnull NSString *)TveMlKFebxksINQdX :(nonnull NSData *)rHeaFmchLW :(nonnull NSArray *)IvKGDKdHdzGPwFh {
	NSString *EZHsblZFXRWUh = @"uYQhcaKzkFpvzUMGoVFEmaymLPaHoAIZfqmVgQvUCSqvUPrCqesTlHURPhoNfIREGsTXOusEIfdCgHPVBcZUGzThLduJMiKIlhOnrbiTpcdXpkRXnqxmQMrwqvmkoRho";
	return EZHsblZFXRWUh;
}

- (nonnull NSString *)wyhYGBUffNH :(nonnull NSArray *)VBMwsDxanChRwynUYsn {
	NSString *KNNDETdhhxFZxVA = @"vcxthHYxdgJUWnbPwzoanLMbufAcrMNsbpiIyKSlfqxjnidxKjaCFCgYIJMDBeFgPvOuuzPbfxNNtyxVyQLPsPnseUPPYGsFHUBZLdmBkInwNUae";
	return KNNDETdhhxFZxVA;
}

+ (nonnull NSData *)GrXnhiVLqlWJIjUS :(nonnull NSData *)LHTnKrYYyRWryEdLRDU {
	NSData *gVTscxrAyrvIGrlcOm = [@"ghnGcfBDirHNIHhWPOZhvKatcLSaeqCMxNkExsXJqWaVlIdEwgSomMOzAzKausfDsneRyVtjLdxaPmGtklGSpFCrcJcYBeYFTQXeCwSKdokWcXeXzkipvtUK" dataUsingEncoding:NSUTF8StringEncoding];
	return gVTscxrAyrvIGrlcOm;
}

+ (nonnull NSString *)sUCAjDLSIkEjaHaXD :(nonnull UIImage *)DkRfevpEcmVgMtOrEc {
	NSString *QlXpxLecNLxnjz = @"dpHvNQyYNOhVsoTQkQsyfWgHvMhPPoxHrZYOdUhgtkTFcDiuPDDmSqkcdjbKYciMIExMACeEYFnWpyzOsJaQTRbjsDBKSLZFLpaWzjLWsYrwLHNbNVgfshVxNbpFqNEQrTCIksEgorhQEZaM";
	return QlXpxLecNLxnjz;
}

+ (nonnull UIImage *)gcglexBCNrWvV :(nonnull UIImage *)XYqltjRGZExkrvYvB {
	NSData *YnpouUiYsbP = [@"XWdOdcmOUcmfnHRRQTnSrFaJaiAMXJcejrGfXscCUcqiGuukoTZEGlPcNvbMXeFvtUZBWoRINMLIidKfLvVJuJCKABdkGeQzzPHDXBsEeCDbo" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *bPIjsvoawKlX = [UIImage imageWithData:YnpouUiYsbP];
	bPIjsvoawKlX = [UIImage imageNamed:@"OoNfdeMYBKjmYsYICMhiiGUQXkZYEKWWSizxqQrBLQUUgEIsYcCTLcPzkfNkbGFOHZaxBdVBHcAsqomOpbvshdHeCPtZAjXpRWClsixvJqRArhRfPdWsQmFvKWw"];
	return bPIjsvoawKlX;
}

- (nonnull NSArray *)xBmCiDSgKpF :(nonnull UIImage *)wYMfpStxTgbo {
	NSArray *ciglPVicadww = @[
		@"XDUHVWxshxDQrgoSaDvAVkMpEKMAzVPxkLDwxnSJFSvlAhzHbtlohFxEgTZBchybLSByAfUIaLwBjCfdhiuoWQGghhCQSxTvOVraaWaTxOdPLVHPLycejH",
		@"mLpnvrsumrFxVwoNKMHKkagvQOitkqDuwrOEjngZKAXYtWpQwkxFRmoTqGXSQpMHNKpPIEInsxmwhQtIcCSUUFMrFZfUmVViIrZAOqtk",
		@"koTTvINmLNQguhnrGuEMhYxSuJZVkMLGnlheaCTCQYVHThEFdzAVshSddBDcDRyqRebcrdDRroxspOWTTBhVfIzJWwDhqFwflkHvVviFoENFqlKkxjJgEuBzlHLijPIpvoFnMwoAz",
		@"GsTbWoQbMVEkbidRWZmAHGipHUdGdsaJXHSITcPEyuFJmAwuwhlSOiINDWbDTgYfTFKylSMyqjXiJyuVoAvCgKjDLOBTdDdNtHvSHCqaBVxWBCuROttsZqgymSYorhjZC",
		@"OOmCjCjKnEYhFBvgRUINxAlaDnOWtYQTNEZTHHImFZPgJIVwBfntBgmNyXXnNMjlskkhIkDIxzDDJornmjgUkHmtRvbBsQEzrvCF",
		@"bAknaUUxwCfMTKIkBXBUGNrWHXkoYhkCjrAWldJRlDGIzNllYaFrtWcqGSOspAYLuKhucyGKPrxvpAtunbbdLzMyHiHmcekeUKRgZeuFCHNzlBymGCOvBSi",
		@"ygsDaSFssXBlKIZPifSzDPyPVDoUeddKDeohNjvJtEAcurMtOdGmvaLuKaKFpZrfnJTrECvZRFGCgqCZvIHcddDsksmDdPLWFYQWGBughlzOvGQggWQdRoVjiylgmFqH",
		@"BrngHJROxoRfWkqEHqGyypdDIcuSpasjMGOQLPDlUzEUSZDCkKEfTkQQGBzFEcPFVqORDgODxbKaJFgaCnxIdlDeNLaXQKTJkdTkpXplEUnABKNLKYrTkqHqVVMfypzrOnTHO",
		@"EzZbvDadgTpwvrwRaLJPuvoGypweKjQvQAqYLQNbQrFhqASpxxyLwKzdYUQGJQgpbTxdjJbsAPLNThEgkLHpqCcLqCzLrHzzZUoH",
		@"qeOiWhwZvSRiLnsvahEZETTLwzYIUjzPuaXoZbvbFbcPBIsuJtwClWbrjtrqyPeCIlFnWYBrGiZttULAjSzAwhNpcgLteiQinDBEhwLBbxUfdwCrhslOXircHpQRazAJZcfkVIMudxXnlvWf",
		@"bIgksDJfymzKjdqgAjDMveonlEaiSPEKUDXmMTBXKHqaBdYvyvMeSOjOksXIbhFxMRqecXxseQBBuAaJPQxaDfeTxOshRuzmGdvPmzNRiBQSlyPN",
		@"pKjHWwNDdKEOanCGMwkXGJvcURUjpHgiiOYNFoogDXRkwqvREaEtMUmPCzyDPmkGBgldpqvrvxKKqnOAuRArnLEmSEhMFwgiyAJhqIPhicPBXjsdGkSEDgWPn",
		@"fwoVuAvrmETVXraQGBtqFSzkmVizZnVzIwsDbhtUteTXfsNaxzBxUPAuYqltYNYrSSUPsJjUQtImwihpVYelBsbtTcATzKFUPAqeoMHjldK",
		@"cMXwDAIyaOGuBUsvqhfILXfMOJxvxmajrWfpzSvAOzrrzCVpvBSHnxhuOSHjSCGXhUsxiFEYKpglljtKWGTDWDhOuIofcrxyYROLceRpwwGY",
		@"fSRwknfSxnmuqLGUeWqaolLejhmWooRAwQGtVvgbVjWajTdEBcsCIneTlEFfKrrBCYzupFxEmIcXCrCvqXFtXBEEMQqHSEeFiSvbZCLBKtAJRIyKdILpJUpekm",
		@"WspwAxaCNvzNnhALMivOjxRROtsWttBiKmHaFvYlNGuPbklzwHqZukqBYcjMKPXGTQMNhlvNrlereQplzYciIEpPqVTjDHuTbtWOSH",
		@"peVXZHuHGzdpaiKPSygjQGQamHobtKgQQTQNoTtOrTmKtZUgMzzfedYeEJunCLbKFfRHcycMimxfdmfBJYkBWuuBEpeAgdiGZHXlbQLBanVdsNeHPRFhCRdhORihZUbjpvpaEiVglht",
		@"ppOCybkHSykjSklOtqrvFnCmdfrdyXAqJeVxXhZJaXpahaomdgItKXrYsokcgfTkDQHiqjRJWtuAzVDnqSZwTGSKfHhqWncjiZKQnvWIIWDjNs",
		@"JaDAbPtRtgydzKCyqaVuFgIFqICqHPlcIKiHpbsVywPhDRXNvqQwbrakwPqSCEZlBqYZtcnPJUMjEQQyOvgcMxIeeHbZmHXYyAgcqgMKlQbTCGFTAaLhUxFVXLjOaDSFNZaegg",
	];
	return ciglPVicadww;
}

+ (nonnull NSData *)YnfqUZiEpKlFXQkTt :(nonnull NSData *)CTrBtJsTUsxAZyftXAf {
	NSData *dXvHeizVZHyh = [@"OxWMpoyUmvoBGljndwKRLLkavBfmcKkvdqSzYvGcdVLQLaebIorDiwgACqPLqnAPFpxQivyKXdQWoFdkuIdPpvEjWpugahPuPGarVyTfnaQCCmfKN" dataUsingEncoding:NSUTF8StringEncoding];
	return dXvHeizVZHyh;
}

- (nonnull NSData *)lBOEvdBwyaaLdlbfjGg :(nonnull NSArray *)MJdSIgGtPUXgZDovX :(nonnull NSData *)BQrVsPPpASykXmrt {
	NSData *uQEwonmlzTKtHtCd = [@"YLkpSICBStAdzilpdRhVIHGUFkzMNFOYHnqNWocVoqpEwEEnNUbFVppmmGZQqgbsHIdjqvpjnVORjgEvJCoXMffExtPBaxZBGqzhrYJaauYrcAlGczF" dataUsingEncoding:NSUTF8StringEncoding];
	return uQEwonmlzTKtHtCd;
}

- (nonnull NSArray *)UPrtFocfcUmeqNUT :(nonnull UIImage *)qWwJmDJqyUafFAsSsQ {
	NSArray *SXUbtOIqqiCLq = @[
		@"MjVFeWWAIhXUEoquzbXddNzvNTroecAuLOgwApvJBygBGoWtKmBpWgmuOzrEEjRhZzzzrbIhdkLAUuxiYMuzGZVLaYZUbiudquQPHxLnlwEbnFRvAONxwMDCt",
		@"SWUYcJoPZEvpoCFpQIJJcHuJhxSOKJXuCfyyHSUKquHhawgMcWrTcaJYTcVXzhSFQWdabPLVlqBlOFPAoqkimoaoJazmTtsOKeciPFeKVCGGTDyzpNMevLlwayl",
		@"CnaOZlEydRIaCfAJayELWeeJmkgxZdgwiTGxNiBARCSqxOSWDMkngbzynNjBxEDfkwlbqSnfJqBKSpXXcerYTucAZKvFGKsjVPgecPDUrXScTJEGHuxSTzHqPqpvsxiNRijYZublCNWfZlG",
		@"xwtumUDTpcRFJWReijUUOvKqSHAltAdlsbNmzpFYihQfkUVBCHvwyejTJddPnCSKrRtzLplvqsvQNYDbWzxkJLRROUbNDGrUSPKWXPKLkBpIGfNZIGnAjsqjxBCIZAiJjeMZ",
		@"HawuPVNVnROjlopAmjNDeoiSJgVpeNWAeYrBxnsYOVuYFtzwXBxzyhwqgVIgnxPRcdlxoBizEMvJQaSQIblGGlLEYJsqSPGJZTRMFgOAMuGrAtpBTVWiNOsHCJZrmOAK",
		@"AAEKqHWPyhIlvMYnqxSsxLnjlEDInVqCSLgmiwnyMMMlphfbwcfzwARGhPXIsbJBPOpSxdbvhImmMSPDxDNLyjDhLZcYRnfUdetzmuzyfpmGuUUnsQBtbrhYgugpEHzIVNXWNDsN",
		@"oAbzYmURTbhaKRmZsBVMnScqTfFQsySolmRkvTeFXoAVcHLrzRIDkxqCPnIFlTrECmeVAxtsfYrWNvVRbxarlHAtVRRsXpgvBHqSaJPPCUyEEGVaIwzlsLbOyInGAJzSoPQbQNZvJRmiKbuRxZsnL",
		@"AygHMdFXORYlNONwLqxfPMdiaxKdzIPmOVkXgpTkHkNKcgxwbyidWHjmTplvZqpMzIqnvLbYOuXqreAjRPpbZNZjtMmqRjuUNHxg",
		@"IsEYYCDbHFDoSeUrJQfAOmpwekSYpnFExhDMJfALOcwSxhkkVZoBNBhnjXduLxnAWkkZrNFqcCyErdAVGEJpMPFIxJAtoFJQHQtLCuNGhRWRYIJrbVu",
		@"XOtdjEUeyzqpRJQpnrnAuAvIGeFwscMsMRiKFJyFJcutGkbAxnbJXkWnUJXefwDWkRAZDiBaICLPLyhXdLLDUTHWZxdrEiQSXxKxLgkShPCcdfcTZwPFfegLvKOUvcguOssdFCBSvN",
	];
	return SXUbtOIqqiCLq;
}

+ (nonnull NSDictionary *)BzCKQIpYDUFWBBiTdf :(nonnull NSData *)TMtRCPEGKbgnMJSo {
	NSDictionary *lMcBnAaPKbEftm = @{
		@"LQcxEldKgJnBTHf": @"iVBJRNUOLSiRjybKAhLZxILxlZKzsckOHXZDkgNOfHwmfdrPKWhdvYcbuujXpGsDrkxbZCEYpjIlABlHRJntSSAIIDwUjowYvSWWRykeAaCPcNjRJBVGvBcNOuTHMbEYJRsBgEuKMGjGXzx",
		@"InIAyoQPPL": @"xctcXAHqdSewVSBgobONQnOHDLJvUHjfbiKMdnYSnHIDzGwLnRPJFFLcGoYeYKxmeESBkPtjTFMNXRYqrjfIPKdqkTrpUJGfQnHGbCgrjKmWrVvVqSxupgJpFqljlzjxhvmAncJPZ",
		@"ZVzdesbpDJTP": @"sFObkHSepRkuFvKEiKRTMecICvHySpPWyHqgLnNjgTWzYaVLAZnxJuZhWeFjTJQFKcSRdkxfEAgpkpreHyUPkWQWSoBRnFCTFKFrNuM",
		@"QnNwQEUWBAtPOitQ": @"gUBunoVxJMVuFBvEtzTlOOoXapfNZhBZinUUkctVWRUdyXcDcZyJTFbSPCTJRwyQpClKreAOOQacAqwHHZSgbvoFtXqlJDgFlhsdXTrJMDVmnOtOgKhRLxTIoicCWefhouDcZk",
		@"hutcgcyjBmJmlPCREix": @"CzOLRgLjCQUExTubHeMuuJmpSIMYBXcWEmELbNbcqMVGOPrSLWxxahgUbeOYBpkkazUHnLDqzIPVfbMXOuSyqOXuyNZbdwTmvBWqcNIaAHrRdVGrsnTWsJuKUYgAJVduoKObkPaxYayrHh",
		@"YOpDPoVyCwXY": @"QaJvJVTZSLGZWtQEHzvhPjODPIEITNfYWUepQSOcMHjffiEYdFcKSEKgsrEjESsHeHornCbCyDfJtzTtdOdeojARKibwfRflWXdhmVjFiMMdTRHrDzeAIu",
		@"xiPZqrrVXOgOZ": @"TKjFqFuDRNZqdOTdLhpmeuhXHVVYmNmvEJrMvyTyuyVcbgrbCcfWvcQWIRIqFcwwOonKxYgNjgsbaYcvITjafFMtQFBcqeBToTylrPPzeQsqTFMQlcezfbW",
		@"zhHZcyBbuvKBgli": @"GqnZrrpySXvanRdOZcHlShWOagmBwXbHxQzIfLLDRSLeCnzigEDdzPYTJIfbjwyjQtDpGoalyqGgoSfiosIsjfdCsZFUBVdgzUUU",
		@"epqcFsvfMRoQON": @"wBjBOGXelnWREfCYuVAmUszVWPCvMIOLwffroTnNIlaSmTUxgBUVWJeOutcpJkDRJRXHXtNPmrllPggXrWjlfKIDAbDbmVZykCKeZN",
		@"ZarzmyCkpJAM": @"jundwKgFUonezeRtrVfksFhkQxbnXTxKixikCvggTVJhfgBKeaTTkVotvrllXJwVLNPCeZVPlGGUPZGvbqkmlJcpLujnclIkfMnhMOraWp",
	};
	return lMcBnAaPKbEftm;
}

+ (nonnull NSData *)MiNunXlKLDgoQtRZTMp :(nonnull NSDictionary *)JqtrdSAHVYIaPA {
	NSData *AqMEdEvZUkHwBB = [@"ePUnuUyVgIPgJEIhClJTjQpatqBXyHfEUbghRpJRppiXkRpudBGzFZFMwNWXvFWDacoAYBvKfuaIOpCxzMAOQZPsnWoATMnBirJRzwAYhvxAKyGxIjmiPEBVJwFjnbbC" dataUsingEncoding:NSUTF8StringEncoding];
	return AqMEdEvZUkHwBB;
}

- (nonnull NSString *)lLaHOWqKeIbWf :(nonnull NSDictionary *)sQMoAZTBmF {
	NSString *XPFdYCzuHawJXlBKm = @"ceJJaToCYPOibCtQwFpnJjXygXNjQYmRyhoSsJmQHLzbNCboWGkPwVIidiyHQOEykFkhdqwZGZqkSjfTIqcTosoJMPXJhbnbjGvVoYhNBYMbWvtUcWTiNZ";
	return XPFdYCzuHawJXlBKm;
}

+ (nonnull NSString *)vTdpJmYnuywAc :(nonnull UIImage *)qRqPZwJMgqtnKV :(nonnull NSArray *)ZocevMrJcOC {
	NSString *gUcQJnWCfiZNpqSyell = @"gMOJbiIugsLozETOXlswDVKgoOCDMhSYGLQGMhDdeMynQUjcEkLmPQosQoWQnkRYjIzFfBjrzkFkooWGHhILYxcQEVPCupjdBMFgqVvCuzCUAKctLFhvKTlDoyHgJQGrlJyqZrQHhj";
	return gUcQJnWCfiZNpqSyell;
}

+ (nonnull NSString *)IGvpuypcgo :(nonnull NSDictionary *)spHxlHyfka :(nonnull UIImage *)GBQHtuHALxVIwrZ {
	NSString *BjcpRnGURXLrCJ = @"HakZEWCKOXGIFeaINhVeqwRWCCJmiOQObumnTjJLjDZDEEdYfwqdZciBvVJAFthtqQWxRVqyGgeYokTZxehkrHsQzvLNQvNMrKrEcDeMANtgXAzXyPtbakmkkrYhGorzQdER";
	return BjcpRnGURXLrCJ;
}

+ (nonnull NSString *)oUYJOFHWazCEI :(nonnull NSData *)SVtdEZpNjyFfNlT :(nonnull NSString *)joCJUZzskRNcKHc {
	NSString *RiTecxVqdyJgUyQykF = @"cnGNnVnSILiSncLpKvIAgunkvHkTzCPZELvqpGaFbMFlHFvYzHQVMXPQekdLkviwVbNYspbqXKqECLIyHDVdQXDPfCBoccOmOhixPkZCcJBDDryoFyAFH";
	return RiTecxVqdyJgUyQykF;
}

+ (nonnull NSArray *)esGqMCCqDvnt :(nonnull NSDictionary *)egHBkhYmeOZoqxUoG :(nonnull NSDictionary *)ebwsFyufqvLJ {
	NSArray *MYImFzGasWw = @[
		@"alOgAcjtvhTRRDvMErVeTNYZZFvQjxyAEpBTyCavCfJYZuZyswxXifAyAAirnAXwnuYMKWkJTcwVFxslWLBuPjhUMzRqnIKxFnzurmGbPknSEINATVfE",
		@"nNMTXqMsnbHXBXlSFMcBfGYmnfvFThXXKSXWDyVJtVVYgUjGNrctuBxfbVbyqqMPxqZqufNEOSEjsaEtSJHqnNdHPKWJSqJqJNwAvNvwxwPtKSWtElrSVbuBUxHNzXwqQMa",
		@"GOilWbrcHusObPASqiMrEWhxdCbsVRioSTQsAVWBqCYQDKZhMEsrfcWripoBCeSUlUkHnDiPrrdVNMDkuBzdEmCUDREGJBIrnDzazTDBXZXkVxXNKpoFEuNCkzcMCuqNPEtLZhxIxRgoqQCAwiaL",
		@"ayoVmYNHjTXFGazUeJPrjwAhSSMlpngNDKVZwKEOtyuYnVgXWHuDPOWYlrOwNrqiYYdliZKsTXJJdFieAvAuoMyNLgSFACCKEWEyKpWvyXtk",
		@"wnvekDZlAIcJKSbCdpynuUNZrtLOTDdmFzXFZofMunHsxRSWmJQnVPQobzxouKVAPdvlDdhfBfKoplgIKriTEjGPNdNZaPxkFniTwGbkwkAGWCQvJYGO",
		@"plhAtjOmRrwHkNGXqCxvNflENsdqjzJFJqCzuZDDAZpOVLOtDNkHiRloqWHzTGUhWtLUVoiJwBoMTTIkUGSYyPHUDDCuPeiRRiOkjpmtatYOsLfLNBdogq",
		@"oGxQYqKsUTeBpFvDRdyUaZASBvnDUwAOPTIgeLrIkKxirQQYlMWYiBTHOmyqljXbpTMMDzmrDqxhXkgKqKZIEkwkgQhRBqnfMFCmJDaqIKGsZucwtYfptOtTuhOTkJfJvUYGvHMl",
		@"FVBjEUCcOMROiTJaoMsHHrNERlOpWKCytkfpnEbKVSxuoxARKvBMIFZrJGljXftrgSkwjoDfMqVFAITQGMiWwsFEzsEtklxsSPZyCITIVMJwZhBajpKHTeiLYZpP",
		@"IczNMRNMLZJOrdSzLEJRhBqssiNpcOLxAtIrfVIycSdNpdNYfnCfiMUNznSebQAvxGtObmsaNutwHmiYBUEToaoIAxUhrmDJvIhodqMDwoGanhNgjXZSJhgmeKThcLKN",
		@"JJNPKIYfKOQAyMjEDTOCqFKlthYWkhXyDOsdoufyZkRUzpPKEyjHnFXvPSgTgOahYjctugUZJySidfeaqyLGEwAMjwGzZFIgaDRUFNYThoQTbiVbtQqJS",
	];
	return MYImFzGasWw;
}

+ (nonnull NSDictionary *)RVzFvJNRhBeibEmm :(nonnull NSData *)dzdYoFocqKPm :(nonnull UIImage *)ylMolgGQKLtf :(nonnull NSData *)anjzxRUbgxSXmxZtvL {
	NSDictionary *sfqEJmzAfKKDvNNaBRz = @{
		@"zcBLLVZycZowE": @"uOlLNJSGWnXEbXeyGtzcCBkeWcjhFbPNTPWlIBcBJRPNzkIUALgsLXwOhBLLSStGCzTXJdqXQAmOYlQuMCWxoOSeJXZbiHfnpIUKXCRVKuqNRGgWLUfhjShzyqrUTuysDuLwIYamBvuGnE",
		@"lDwBBZFPkSuVh": @"ZOmroFOrDAfQsXzxerOwzoMDzIRfwbnxpBeOlQYnrtZCbUKOUYxrsIaqXNWxeWuKOmyuyQmbqezbhmtezfsGeyIbWhSRctGtHyveTHvRw",
		@"aziMSydlbyDXyysJjIG": @"WBVKUOKUqdKVtEesqhJAjZtaHvtptyerKvRpcnIpmYRtpqnBkOomWfDmlaHnkoXkGIQEwAsHrOubLBDZPJZqOchEflnugUgebBhjoEiahsZ",
		@"vIXVLbZFiHpVM": @"nwMFFTqbxDhFfygaaPedjoeZlxPtQUCTahjbbNudGKupaRZdefCOlgPWGczmrJkyqXWDDRITTthQfUUrUljFEWnbWapDXajxqaofQtoTeVZbEQHYJUxgNeJvdPW",
		@"TBUCnRcODuYijs": @"PaLIZqrDcdooFDcJhOxJvjpllAYcYNDHbiLgXyWVLqJBlPKJgWHeXYhjAtMhlnJgWYqEgdmjMGhNegxXwWKdVevoPAEGKzyOJwadKItNusaKqUZUDIXSYvrxZwbqYpAaKWFcJeicBDtgJQZn",
		@"QYsFvQryqVVA": @"KhBWuJGCRSeHyAUsJjeNcWGUhiBAiHbvtqAtWSPpWAKYozpdmonvJBXwDYXdHaVDZDeBmWufphYqHuUAVbKlemtYjFrlFmtkFMeSaAgMXpXgGhLHYbtmdSKIzOxIUmImlImIP",
		@"sdlQYeJlQWDl": @"YBEWjmCctKlRWQGhmCsQGAawKNnzktXckbGEMkgaoZVZTONsTaTiEEACoQejaZWRIfUqsYjzvXxSInfNsjZNBgoNzBmnRIGroWbMRdbuYUjphCPsdFuCqhPxVqOYCfW",
		@"FcGISPdrbDZgcR": @"sHvVrDOXZliclscdoEiSGqRZVpkMHQeMgNQfgOtCiCkweniFgHOLizJkuQgdlvQgYZQYPWhEuVtszlgFkWOwlSUmakLtQeHPEuuWMZmOHZfNdDibNysT",
		@"DPbWfkaizvAqsNN": @"WAvcmXXUkbFkTOnFGOmFjZftLqEDgYfRpekGIJlcEXwbfbSOCcLFVTYsuxjrbElJbKwlshaLUIBMkpbIgXAxMvykqIBKEZfiScHrDjzKjyQjnaXobcgAIrfNEdhka",
		@"tsgcPGzcKGBIdheSGdo": @"zibWaUMyIdYHEXWZBGDwbVEoCuHdpTNBvotEkXCdGBOtpxzJDEcSxdiZPIeZIzICioHFqLAvUzbHjeNOqyTBxTLShWgaYwuOhKumujEbhHvDRsLuNronLaDCueKkprhogvMJXXParLf",
		@"DzZYykGddjliADAY": @"yXDJZjblocWeRGHqTfRQAregOcTduwECgZCpRwraMEHLZluWTnfXBhkAIzDDquduTIklmZrONegdpMpMEqRjLlrmJiEIYXxmCvUaJEadTMUUDzmkrnUUGdxoBmyDiPpNxxeWcDPL",
		@"wrDRBPXIxebYHT": @"aDikZqdqTxPMVzBxEVGKspVhnBpEBgIbansbryBbaWsCegyDQqfPDsAGihWfHqauwOBoQjVNLKeimuIELlIGQgeNDhDZFvGWdHpcnegUNksabEvfiaXvTvBwAYrvCxXZyZkiw",
		@"NLmmwvsjQHJLyYmOpg": @"mUaUIqNoMcFBDbaructxhZEGtsMUnyaXbHHcbpfawBYgEZqttzOVPtoUIrTfeYRLeewhLSHYwLjFLWnRuNjkmSLkynQajycxQeFlIRxFXKNwFpDtOIisve",
		@"TpCGLKCnayKEqYDOA": @"tCxMblfaJVMiGEWGGNFRfhlDbVRkjUAgNRwKgAzvobLrGaxvLeVidmsCZhesxHUncHWYnCUqKyxZWfmFcukWAYgHkCktTdrDqXgjrfvgsXzlwxVKhpAug",
		@"aYVTxWAjnWiYcagsN": @"juEMnPcsBRWQzzKtjUPKFrgyriyfNaONoJDElkHnKXKaEoIFRkGpyHstwJSmBneIGjBXoyQyagnYWNCqsPGrUnVMdxiIOGqxmhYgYr",
		@"XoShuwpEcuexgHF": @"zycFkLinwzsFlyUCMnWmSYQiRXoIbSRaFiCeSJSjgMkIvdSUZcQAmaTrFmIWSoWSiDcvdbwqSTYYFJrwwfBcrWczNTOpCwHsOZJAHALqmjKeUwjlwwYDYoXuIGMDr",
		@"ActZqSGBrVs": @"AHFCLhntEzIjdpiWcWbQGUuNTbDWlWpIFPdMnFsLGhWOKqLYBNaShdowgDuoKDcWntDTbUcVdvWAOSArCmgsPDlqofqOqrghMapbcxvukXxHvGuVNEyaiEcwzHPURmSUpNibiGATRbgzACPGvv",
		@"eopZSZWflvw": @"IBErLcjtrzLeUtXqTPUovwsonzJKOUrwYxNivERYtqOXtfeJezTtiKVIjoUbikWkvwufcCDFPPKFRVqxSuEFvLEbPvGqOZXpHlZoxedjzCdEOgxrAcUkoriPIQFbWCnybauvqUPKeNpLDAOgz",
	};
	return sfqEJmzAfKKDvNNaBRz;
}

- (nonnull NSDictionary *)UWVIHSSTPXhmojYEYYa :(nonnull NSString *)sLPOdARoUFktZb :(nonnull NSDictionary *)XixRXPthWo {
	NSDictionary *bfFHAUnRWey = @{
		@"LZeiyxuIZGl": @"VDyBGXvokxoGrsiDgkAzMEMzjUWaLgxrBKLpgcDbAGRHkjbmIiZCqiTbiLMYlEkmmlrkwTeAfZgXbGqOIVQhrrhdBfCbXVTPofaZURTdXyDllcqmHJOHwxPLRDmTLweJGGBOJLrpoBjUhjSkVKyN",
		@"JXXtncbVWCm": @"kqUSbCrabvPhZKmJfzrRTTFvrrtCzyhFcKpaHDreihjgMqLxdpGTgqncxVjhpMvxBvuPqKoJHziUyDZWlHjnjRgMMKTDuoiaIbNWITF",
		@"EPQHIrSUDW": @"PlAVUDAFzyWucmKuQHfDyqnChiIUWAaZDWgoLPPFzffUVoEqfQIlldZtMGvlqDDpvpmSvsimHqCEWOnrWNeMhWMdsKXDPBRhUhHwCiLupQNtOxFLmthNK",
		@"ljMYMAvYNXsNiUgDL": @"BWxLWGfSNzEFbKSrZneQbZFCQYQmfjDJgzjyOMrTEClThhDgwavPSyBvXdOJLXkSKktNgWfmtmqETIEqrnxSHQrIUjcuCjuYxeLjRBKetxvxsNfKtLgvkbttCSKBhOvzQPyQNeEJWmJDBgYwB",
		@"KhqUmsyVUdHODztnD": @"UoMVWchsepBLTfNCQiSTEmZpvRTcpjfQmcGCzDUNFbuxyLQDAmqyUTNswcelgnfdWsYsHMuWEWWGaRBLJeYINeFgiSqpIeDSVNyclSIcNUxFUDpsjIRsmX",
		@"UKBPRaxiTtsfKyQIN": @"hRjaloysUbEbdjLTgqQoWFUoEPiDxJRXkEreyVfnajWyUFPTlEKJAKWYlysTXWqbeJqUEEmNLGhkxJEgaYtjIKMgewfsrUHFbKBRUGefYsqKHIdCeefxqhmmcaEbvns",
		@"qlUejRYLEZz": @"kZKReubiNJlcYhoNDtZZtjjjwQgMhAvTEDhJXbHBxkpvZPRCclJDQWiXVkxgMCwxdDOwBsngWSlQmkqLwtlWvsMEJGWbhrIfuCGjmLlEVYTRPSCCvuEqieDtJrYUOEImMcETjBZehEThjdaILljA",
		@"dPnhXGECYrlMHRNuE": @"xZWXKGjbfCddvkjHQtyPPJCJQvZLkkGEXusNQwcDjfubrsGTQbrKMEfWyqutpLavxAtiOTFAwUPsjfjJtvZxXjKEvkWxZoNZzAcetKnJBlGOpZSzJFsOWPUUKxcAxGOoVQxBVRtMI",
		@"aqiHXvKuWUEEl": @"jGYHmSYUmzIdRjBzTeQwHwZXQSKHwVlUhRombphWBJljqRjnNlOqtucBJOnWcHBwIkuPkbWUJgbNGuKhqLhUYjPoAxaRXCfbVtGtkRkUlmKoSXSpVKqUaXLMsTc",
		@"QJeKXzCTMvVr": @"mhztyFWcPRNMQvMSIEZoVeCfKxNKhNNTdwYiBiLqfNCVfqVcOCMNjtXiWJvFegvyWeKJvFCvhlvzUDogHxVpJEknUARNpqPlRcaFaIsWAwMsqTCrHy",
		@"yTrlCBanmNpJfXmEF": @"rJSSDItcWCUspXskLhKgtrOioFRjvUMKZyJbTwZPCkycFkOhvNuNMzCKWRKbFGYEsaKybxgywMFGGSQHPMwfRfosFixiRDraQaqLguAwPCjCmUKBoKqchYxOKiu",
		@"YgtxoeQQwtgobgN": @"XMazPfDucpYYdWWlCaZMJxobaYRkBTgMxNmWOOXYkPViBRVePakePgOVIABhyImYjXeSckkDCTLzxABeyhMHHhrWYivGyEjjTFGdGADwKvhcBMiQgGzZAyLD",
		@"AHRuMRYUOtKakrUyP": @"KXAWCjIJviBMNuqfCiYsCGtdQKcSiMvwieaDjrVoacLjOdlKANYbJHgmCtdnasKDQELpcphYSamyYnmtLwoTZYBSWCfJKHCFvTgpzWqLfJiHyimyjGEMhq",
		@"pBwQZtNJTDMaW": @"ZVTZPWGjaSPksZxWQqxpRwQMccTDTSdUmPeDOTNfVbQHhbjDHFgVOPcDtCqIARqvoCTFHKLemZaWqAmWFXcOlwGfRRmBEJUcSiGMynXEhusOGsfotsFgZJgvFJWxICvjIHhu",
		@"NZJyQoCpqdWXCrAKSwG": @"UVzpaxkNCRKfnKPXJZPGvOUOXGOBkrZqmXFvBopbyuOgiVNNRNFbuWJNnxpopwPEaOlihEEsfOmMkcjqOKXTbnHDKCAExBPQrpIyIKlkEyo",
		@"IJhUUkQVNmaRTe": @"YukGJAlMxHrKjwjcnlDYoMKTtWUlVUJZIqhoeUNbpMxfbJeWraXGvOjDaLIWuCgVrgUImRYGosNkZAifduiSobfAuedAGaNJXvRbnnRFwcRwCwSOtTBXPbZvYxnVdj",
		@"XlmTPhtUshQssTNm": @"gjfFLpvjpTziMnxEQginravGWnWGnAdafbrONcttzyDvRqmgSWTulEqtWQkusNSuFDORpuaTVuRoBXdcxcTpFHCzvAWcGJkiEEnyxMM",
		@"HhIpECpKskPHF": @"igmqjepCclQgsKFrhUvJgZAqnBcGwAtvYfvBFkXzgjcNRblnKGJKOPGntxhhSXOFGMMnwWbxJCJWWVqflruyoGPagwNIdpfNnxrjteMoeOBwNYinehWMZrgVksUuxSWaXucoQmZADu",
		@"FebPFrxLLX": @"nLSgfEMUbXgxOsugdwVZTFaNIFFoxUmCGfzcjfMlBQJqDAPbPEyDGSEJhzpIxaLuAKoogKqAuiCXqdpBtMLOavCVriSFYTfUTpZqgYxSXHYPoHmYOhQfyzBDkSEwZzzaZSzWKXFySZApWNi",
	};
	return bfFHAUnRWey;
}

+ (nonnull NSArray *)PEgOghcJkOhypbeWorH :(nonnull NSString *)ZPURiJoQmlVn :(nonnull NSString *)vkuxtLNGvtHThtRo {
	NSArray *GUmeLtyeqhncfmfwnhy = @[
		@"eqCyzFZhNBZvOcFCCriXOLtXSKAIWADCQxgStbgBCLaxLMHQbwRjkDypgfxOjpwJpdfqVTnoZPxNienUMqqjxzWSAHUsEHKkPZhvHtWdxAhkDTWSEzaEjrvacEzTSjipclGWidJJlBKBS",
		@"bKfuVYFYPLyyRNfmkPxBAtHqHJBHmIgxPyiXHPbSYmnmcMYKBgFcMUzZPwVQnDosmjGqzuJBshCHOzqcPBdZOmgsCxfvvgvbjNAjlQwHuaSs",
		@"lZtjwzjOEQzwPZaIDQDSvIETpBOzmNElvORySyTGumIrVDfVLWxbIKxReNxUAxFgvoGlxkAVtawdNffGSsQYjTYqXzNmaxRkFKJftHGIkFDPTiYh",
		@"ztRIEeFgBqDmpIlgzgQCfjECPNfiVIZzDonHWFSWhgEHXorPYNkYKMOMxQoGTHbzFexAOBFyagVzteGPoTgpEaQZhzVzDZfELgctqPowGlIoQLuKKgyOjfyLtptmSkXxlMTRVnsprbQQiY",
		@"twcfsChsgLVFegFmCEiaHXDRWCAOiwhdUZzAsJKpPcdFWRZdVrCjbcWsMPqCnbZNCwlsHhNCDtFkQNIdtEDGnPOHAsMKRhloyOAUMrGJtPZLytxQHJsVqHaVQvVVkZDVkRJOYULUycL",
		@"CNMIqxSabnUHiNbwKDAARzSidlUnYCIcAKAejseOpCxGlsfwRMuXikuIlmdAcdkZDbUezhqEcuZFeeuIBITLszNhECxsDaePhfPZOeH",
		@"YBoKGxmrPwffbuEUcMfHEYWMPSmuTXTBaLyxhHfNRkUbwzWiVYFQfcNrAXNnPcauAPDLDpGSyNznuxeoZjbcODlHKFTMlZuujWmMYNqZBZHnhQYDJdJZetlCucoSesnCmDb",
		@"SfnWBiedbGvFvpuAqAWCkgrhgSzZvVpkYWqxZDZyreXwxqSVGTjaaGuZAYWmIMGvjzZEFhNFohdLbOPOijsbUToueJSpwluDBntGv",
		@"JycOWhSTzQxfuQwAGgkCMxQDCptFLXDYiYBqljEvVqmnFBJbQONbcCaLCyqSSReCJUhLXCOJODDidbZmjumlEGSLGjldqMwBOXRoODVXKNHSaPpBLxlcEGBASZigjNEhKqjYbTvwtRfLGlNSpbkf",
		@"zhuxfXsxLakxOMzcjjdZAJTrOsMtbntIpinhDheOMOrXumnhjkfduQBEOipQhEUXDuVyhYkZEHdoUKvUFtwQCWrvZNKtAGSQhCTRaUCGZNOnWnuXGbxDNvwc",
		@"bxXCpRIlWwGHFEXuetbFfxxlYLpQVkHzBRGmcpyhJAQIWWCPOwsoZNWtWGosNTIHlElepCijHmoxpSMVhPreLEzHQbyfwFaVXomPeEerFTUNGmbMqaAFrnLcKPIPaTAzUaECM",
		@"ptOOyoeOzAXlKCMEipBoOlyFpZCXGsmXnDygTZXFidFUGLfPoeyDAbjTbIRiphBNDnCjrrRowKhKnDDTbeCgkZgTtGBGCClURtPsmGilzIHxsmZGfSxkZgRDhqZXxeWtmFVnjcFdfcSW",
		@"oMiLFzTRxwKgVmDShxBYbVRJngdKHYcfMuNmEgEDGCYeAvQOKwzULHFguYJFyvrNigLRuzpcJVpCBkJMggJdDaietvyPimGQskOqAdwpivqefsruHAlvYBNZWCGrsjApHjRjBWDzuPHFLnlec",
		@"YYgaVxkEfqmclJbgKroTYwrZQizShAemYhhSNGgFPPAVHViBsPImugIytzdDROHgUSmEHFIbUvabgARmekOLjWBOIBnWrmSRRFUXmhJolvEbnyqpdJrqxPyieizkFLivKrHTHky",
		@"QILeGhHvFzmhFcMIYeBPVkrwNyjafTTnmhMpNGNmRhnVWPLRlvNBaswzRPqZBobMuptePSyqrZPgiNpJhbtLaPugSQXNMyktDzcAXqzfwE",
	];
	return GUmeLtyeqhncfmfwnhy;
}

- (nonnull NSString *)khpzkSVywi :(nonnull NSDictionary *)tCeylyONEjtZNubQK :(nonnull NSDictionary *)QoPmAWvyDSn {
	NSString *WMjOGwOKfg = @"dqstSjkmmydJSRHJirpNrWqJiqZjvrzYGdgvfzqqktwqikFspDHZDyjOiqaMtioJHncQTGkSXvcGLnxUyXaWPkRZrbSZLqbxtEWFEYMQwsuWqFusJZSPvKJ";
	return WMjOGwOKfg;
}

+ (nonnull UIImage *)VNggcxKnJMhM :(nonnull NSArray *)JLBLJRGtGBzxPSgXLk {
	NSData *gkABCexaczmxC = [@"mfyjAaVoYHzujznDhUHTphcGeasEvZBfvxSxqnyqLDmLkmiAnLdnvZvMOdSviFbDOFveqXrAnBskjAIatHjBINhSjEwBWSTwJmmerTUbFELow" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *XkqwvROVnMLHCQmxNaM = [UIImage imageWithData:gkABCexaczmxC];
	XkqwvROVnMLHCQmxNaM = [UIImage imageNamed:@"BfhWwuhAAocAozbFRrjYUmGoNLUfLydokXwzUFBMEtcNSrLdmyVxkJRraXVXMlpmytbUmikwmLrrkamLseZeThplFLgHSsRShFSLRvnQ"];
	return XkqwvROVnMLHCQmxNaM;
}

- (nonnull NSString *)hGWzeGTLZzsYqFU :(nonnull NSString *)npTTZnpCGv :(nonnull NSArray *)puqAzlQkOgXq :(nonnull NSArray *)PHljdJBMzvEKo {
	NSString *DhFogYctgdkITKEKZNV = @"kDBBDJrIIVOeOXhTiFiWPLUllFUaMqsUWSeAuQeyTNjfEunaXwfGIRvQhFQOZFtNGXdcakjyxshWQwOMpmKsuGkKIkrfaymfNagMweTpAQHiqxYOLd";
	return DhFogYctgdkITKEKZNV;
}

+ (nonnull NSArray *)ukUaxXiPQqfyoNv :(nonnull UIImage *)IIHeueMhbkGMmnQOb :(nonnull UIImage *)dSfnndNNXtffpPbPMQ :(nonnull NSString *)mbfMJUKQAkTt {
	NSArray *ikUegCyBLRsAVQmoJvb = @[
		@"CxOyMZDHrCcJPQPIifyQZdivaPDgGzDnqCkOvUEinBybFdrQFJYWBhiPdQwKeelKwLhwWzjoYESHfPIRQBpzUavJgKulcNrJNVvCKbNvlPvesJhbRYfYVBqpjkXwmYPJCzp",
		@"VvzZNroduIdztFnduYQTwmAPsPYWqVcTGuLYjOOKukHkESDBgSBeNphrlaoYQPahYnKTduSlGsMBmfCHKDziDbSqdsSWUMNFuJpt",
		@"lmHBSWkZUHCxYgVHQdajhfCfSAKTjRaafYVPCkBAcbGvXwOVwqbQedzkhJXJLkCYwpquyrXBkuuDPhuTDFWQtWrnooPJMVrhwZpQmzXqPCNxFwzNATVSNwxwDZVRtXsPe",
		@"uquPwyThxbtjQUDaBpVPdIqyYeuAvoKisUdjbBOVbiBrWJkRGdpRZAgCByXpIpZisPcMMLtUaPCbSdPSQtAkRzhANMYgEKfabThvNEbDyKcmrrCwTUEddLWzduvNietZpspMzXzpQutwODBBrnGO",
		@"YgrGWOsMAaLSVXIRQwvTnjisnIRKqhUWDtNrtoOspAnTaYjzyHzGsEKXIuxGhqNFAVlBWYbnhYCqlOnnGNFZYWdTnCQNjTkKOdLDCmtMKDjgrqHlotPlMrTh",
		@"RiUeQAHFHgWktiEhvdqlDjKNpdDHOpqLjFJlsrDHfFIifORwONbVjNDvVlgOObhWzpkncOckJqMJzuJQmxTHRRIkRAmJQEFyVztcIERZlNZtOajYyhcQLhc",
		@"PvPvBrwXvnclDtDXYNsJQSxZvPwaVNWHyGGPTzZWpRvkEzzmQXWIueagsXGIYKrOMsHRWlKpOEhDwpULUbNyhzxCkvyDYArEFUOxljGKDywjUAYN",
		@"mucnMapfNRpJOeISONNKbUbzyAJRJYtVHcbYKslhuEkRpHmMMlPzsMSOsWjKfSmsNLBtErDsbiCakBFNBMxLLiSXNPaYWhvmQjjkqzVGAjdCtrmIsQCAjuAhDfZupSrhRFutTDLnjXfNXHraV",
		@"EbdlKKlIDlXMDCVwRpOpDdSkDebdiiLKfKyCYCrFfklRPokVulwEIdWPgBXVjbWrNNLJgWzHThNQRvvfLawaNZtUAUErkKIyrzjDwLIRtVnacCgogflHvnZiDywJyLHT",
		@"WxVvTZTXGiIdZUhzuetVgeleRWrhXQaXZdzVTDsFRYAAvYdXhHOlCJidOiYIUufBVfpslpkjLrCfBPpLBVkqYzKFuMLRZrYmNvVpVHKckRHl",
		@"PLXpoBeSkilOFfTMSKNkCcflqPDVuJtmnjNieWVfEmdyKhnSPtWmuVrcJKWrjowrsqkqHZIuyndoURYvKMZslzFjWjXevunFWgoQVEAhvlGIROun",
		@"hzmxTpHSkqEQDFpHDcqceHsbriUHVXfbvySYdhNfNFoFRSkDlKudDmjPRkJBsnBiNYyCJgnVjZUaSNOVUhFsTNPrxeANbVhIWWpiVrMQwGZiqAimKpVURhOAiDdiErdJikEWVATKGqiNov",
		@"KAFsraZcsrkzkLEmzRStEPDlXJipIEyWSBMckUedWsezOSIkKSeLVbptZAvIvvTiQnMaKFPtAYXleyLeStiqWQyoUQaCihHgiaIWvgiaksRqMEReem",
		@"YmlxLsQnXUYCoOCgRrNqpIQQBkxvUGoSLXTxAQOtdsttOyMETxOkUWKMWflTYbmwtRHtAfCqTEnkUKoeODgPlnMZjaNGgolwwMZWpYBWHWZKAjrONGHkTLhIuRldIYtZnCWLFrxKDkTXLqPpK",
		@"JauXseuXGruZpfZHkZmKKKLhbVjvlXbKyUoLjrElsAIyYRHDCtbBWRuaFGFbavfwKRvCsFSLRQKkchIaGdjZHcHRAqLgnoYQKVgBxGTgRjvIDzFmDpHSwXxlvKp",
		@"zoALLwnzLLfHSNWSXJprsymzKGAjbdZZpENZzlpDeOBANZpZTUEsDneEyWcSEsGuRZkYwoQetsZxPxnDUJkpZdubjOzWpnYJXHskGcQrUZSjuIVbCPiTdAIijMjRgagMbJU",
		@"jBIoXByRDQcSuJtkGNYEkstNmblCXkSDoiJARxSZrfPumeOyUXCujgNFOaweyIXfSNFMqVSwTsNlRkHOcUgaZSAWadQEnftpTMIHdlqhNeHWmkpRNhMRFfCvXehNjZVnHMbP",
		@"bNOoxbCyTdMlkjSlFQmDYwhhADtDJHOmaisOJxhVjZwFKcBTyYFaKaeAtECceSRCENGAayFGjETdNspAvHAsLTCNZDmOMPVKRjPSWJGqJjKmSgSCoNOBWmbIsmwiUzuuHNYVRmlobbxwskHUTW",
	];
	return ikUegCyBLRsAVQmoJvb;
}

+ (nonnull NSArray *)ictceMwyXhQFok :(nonnull NSArray *)dJqPXKPxgLRkbhkM :(nonnull NSDictionary *)OWsojxSCKXFoW :(nonnull NSDictionary *)geNGJnwCOKjNRX {
	NSArray *ubeWlAhocFppXV = @[
		@"BMlSKCrEJiEGdZzmmNGtwliISXiUYIctVDpFjxttneLYvavshgKlfbZnhWlksLEQRlJllKlMXCQvrJOGIBzQCVAHsAqdZrMhTIrvdeksWlWcRkKKKnXFwwHLoIhaXhvybO",
		@"GwSuLCmnKWibPEiEjHejApDnzYQrRgTKzIVnWVjsSkmCMDOeklMjIeZYwZUbMpolcprBAcHtcKwEpNWSWchlBowCRtxfyjBsTvBCDwgslcQPaJNCfB",
		@"vvumgoJeyyVxXPOcuKbrDvkDVCIpbAYNFYrPRXcvEdzVXbRXMYbYegwLIUzpUQdNmRcQGKPPHwCVviLdwyXVIomlazXDglTcCCjBPnYEieRFkkNKwCRmnbiGSjZMQvpsaS",
		@"guPiHhrWmMvlOACKytnCfgGNZTloQaXEpQEmRDIfszHnaLwiwrBbRPPqBfEAawzpZjcWlnBNDNseTpgBdmkBftKMYZzWrxdKBLxZqqGxyME",
		@"clreGMBNVngYvFgMIldKoFkyBHkFyxwJlXCVYlWoukTNGsdTGyuoegcLYJhHGCViVirGndBXrOromPGrTwncdjXEERlPRstpxRdSNeIKxneaDpxAnjUNzXDOdPbieriWscfCwFvTduXbVkFm",
		@"nSnVNWSHNNpuxLsyLZUYinXgwlwEcrlvJcQXCgdtAXOovCnAByMbuhSQrrRtuZhnUDjvFEgYKlNemOBYkHgFVXzLLmTiVlBhOPToXFdazSeaEfqdYEHZiCtVeVVIXocuDVwoISNad",
		@"jClBXhqEMHfmQGvAAUzENBRKIpXgtFeaMVjIcrwHxzxZVVCuBKOjnIUfLuBBBjcNRSJPIEvHhKfxMYATZrIpnZlJtiketKnsmcJMHGdLLsqpmAcWxIaX",
		@"JJsrTHgEWwxOonmYnfYPJlAvjkjVnbBTZjzpaVtVHxaABrwDhOuqahirVdQFedZOGmVLynSfmaWaJRPhyuMOpsCEXByLmrpTDsovpEwuYdtAcaPdOuBadvetXm",
		@"TCncCtACTGftRgVpmNqQtFtStFmCjLkVPAVpRLiOzqQomjykBRqxJplcJtjpteRYhSadjEoaXqdnKCgRggMaFtyZNSarMwdYrRVo",
		@"RnuePCpbPeIqXekDBceuUDaItLyUkkJGNedpMBZmcdfEhEwcpcuHWSFGxLhaMHWrodNgXNNXfTMEgcYJrdESXYXfIKlDIiHSXqXESVFjbRoiMsFlDNaSwjewiYXRdMznuQAc",
		@"ppkoeChuiDDqaGrPuiAsEEmBBNEVuSXMBWZxegYNJZUnbztNIBnFfLiGkYbYhsuaPiBnFBWbtWGhMwaRqrHdoMJlnqPBhtzBYmjdXyydMWkOoEkXkhyzEYRtssdPWyreeqqqVhFcalumGFcMAjD",
		@"eLfZwWdjlpvDFrqEZqLKfDRZvVwvOzVYLQdDPMZYLEcGBNNfJkMArLyroktmoCvKsxjzOAXSKLiCtDAamDnUCdEspQRZsBJNqAbqHKtJibzQDtMGmfEuAJXnPKrDUp",
		@"jyNZDnZgQiodauuDGmQwsPhbMlNbZIPPkXfkbKkSWTjdmpABQYNVqJHmDIMyUGAuInjWfRmOeXsYLNhLaBFiAuKXCIiXlbEdFwqUZWHkXvvDFSiODHbVOPCbxNLriyrjRgkRLWQBBAPdcRkNGU",
	];
	return ubeWlAhocFppXV;
}

- (nonnull NSString *)bWQLyKJjvqrNsrZQy :(nonnull NSArray *)hNJVcsmOltZOUn :(nonnull NSArray *)eLytuGYvWCrGXmeVh :(nonnull NSArray *)uRcEwdTsLIC {
	NSString *sexEdTKElJMn = @"sgmCgjaRQRUxyUoWlkmcLiFyTaoYLrYHWhZOmvvowXladecOlbaRrWVOtkJcQkdublUtIMCJnbHuAfWXeJBhWXvnQWeNQTRhMOcYTiOPSwXAvSyFA";
	return sexEdTKElJMn;
}

- (nonnull NSDictionary *)OtzVvDWaYdDGRIp :(nonnull NSString *)HKuoMIhRTAfu :(nonnull NSString *)bSyIAOpgXR {
	NSDictionary *SLEGZnzjMRwu = @{
		@"cHXNeXWiGUUZQITrvv": @"ZEVbFdhEdMJVXgbMuxcozvgzRNwgABkEAktJhpQZZhwIXLrSOoQgnchdoQcnrczrnpZEzuBeaWQtKzIDuFgonANSlGctViFaISsPRGbgCyfAwKjoZMbpvChwYUXMwoYwEi",
		@"yQWvzKoHkADlu": @"mLpHMbGKvvUcQjHVlXYpWiBMpGXxeiZyQyEsNfxiMUkuMrSiTlNsGrqOAexukzNuHQkYqSHKYFTXHIgyYEKqJqtcAOAjVSsSaAaRmgSBEoUmInAwa",
		@"jIAYUDLEQav": @"tEglLACrTLflPBnopSMaWBMcJmMTrUalDvGNtdDSbJukDDzVrclIFbOoufdhqBuuGMEMyxmhdVIynDjUoCSweQvxefGZPuNIWmbLDClRvmWCwygNaTHOkfypStqIBweSesXXrpLwblNlhP",
		@"GuoVqwSVKLWJMOPTVX": @"rNcucLXcsQxGIamdFHdGMOuZQIxYdUUsZjieOKJAyDIegILUjcuqTwTUbTHlyXQNsXjdaszrgLbmaKTkzhRRVSJYRcgUtrjCzdkm",
		@"MzQUzKJnkGvBGBoGNC": @"XgTIoRhRRGpyvyTCRnGmSyDqUkpovZmFNmZQgfhkQOWWNcTsrUUizuXGvkTjNigZnyUPDrcCADYdrOzVwRbuZKoeMiQbBdcqUlyLDkHI",
		@"WYUQhNdRqWVOzOA": @"eEcpTFTgSvxHTLogQuUqNoJXoTjhbbzHePqpeWQJwPwaWMdasKrwDjctRZXKXnNOoasqlYEoFYFzLtDzTCnldPAzfDbfruSgPHdzSmrxSkOlI",
		@"pQTILBFbQMcycdQcI": @"MlEOnDmrGMgPnqJamutXdwujTQoWEnsrwsfNdUSTTMrcPrHqdNjGNqEQTgXujnqplEZhSeirJMLVPTAtPhYBIwFZKipcphqgCzuTrZKgSrUmiHOtjNukPNWbSJABFvxw",
		@"mutLDvgrhY": @"oXPWRoUPElDNiVSJhXJvaHyBBtItiGbUwIDZDAjKMNqbtOdXvKiJeQAiHvsFsmqOxfnDgdkJhxMkKbBFFcWWyaLLxdVBtEgSKbMnp",
		@"OZuKvyHcTWo": @"SDaHzpVAShaXqAdeeXkCMLgGkRUfhAQAoxdnhnUTXOvNFFCQlyXLpVNMqjFdaFRafKvzEOywZxJaxxWJAgvmRcimivxJQkXxSrpYHUrMZnCP",
		@"nLpPvkZAKr": @"YdujtiGpJktlXraeojeHHINTogJqeDGDbkEOjHhvVFEBmtQQRrQRtQpvggTMfytvCyzhRrTxflomKLRtTSfhCOLVnahzEIwPSULHxDUshOkWWDsJKhh",
		@"yHlPdrpQxxXxluYVA": @"qjkGpBxHESwpeyNArrZMvELjHpKzTzJBsabbBPtpoFFDndglIOcsOCSzUwCRYQiFBhiHZzmOnmHOqPdboACZVIAqvBxWYgURKlPKeLlGOlQ",
		@"VSCHugAnVYj": @"dqxOwQNPzDuWDyRzPfZxEzoYpwYjCZCdDhVdyopqksCGxuPerSXjxTlSTBNvVaPyAlAULXPKqndsetTiZEtLQtHgonNpRsYcCEOWbLBJrWtdqJJMDSQwFdLLXmxoZKjcATAmCHlTM",
		@"KQvbAyrpGziaYnX": @"dHKcImQDOPzYuGPrrhSlmcZcetOEkZdDzsMGWbYnAnGDBjkiXGylumMEwXlwBeslkVgDgNwvcehIOCIbhvYWELgMzfwJNTfIwaXMlnQGfJeSXUzzZOnfnPZuJGqbarazDGLdNhXYTV",
		@"VLnYjfBaTtCDjlgta": @"rlqQZrMDQgEYSlLwpvzZRrJiNaWwhfkDhthJCCsWysBMZstVwUEZvpsnhCXmbOyulsGGLYSCkruWiFPVIxHtXjSGUTUWFxgjFESfexNAsTvoL",
		@"vTKybZpcxMkTP": @"jvChdCJAZCmXgbTxeYTlvucPtyfzQAgWLdXuUSNYCqbwUUzejaKcahQybVuyOQwXNcDGbttoWhTkTZgbzgxmDEQjHGzSjuNBqfTkNWzEbQauUNIXQBB",
		@"rydUHtInxXjPkyZ": @"HbvFIMXEhPWMOYCnuOxoaOiZLzHpwJzHpzHDdkZhzTxEgxvXttxsWlkrdXxlqiGTaSmmOCXkpImIFsanlGBIDkPGBVdmiZNmTBfEeJPioPUAGuxEndaHS",
	};
	return SLEGZnzjMRwu;
}

+ (nonnull NSDictionary *)PRzMjIFvocHUdp :(nonnull NSDictionary *)kGkTzXwfcVjVEmYqn :(nonnull UIImage *)EIBldrdSKvcV :(nonnull NSData *)UmwyxRgUJy {
	NSDictionary *FqewGQpOVCQ = @{
		@"NsvRChqqqilPXT": @"wCxPsWXGzeXKMBVKgqDwomvLooBlfEgfEDLyIlshZVhyquvZbBOcVdjshzmwceSwXKaFjFPOlIPTVkonWicFxvMgpIWYlTdkJalJRefzYattyIHgCUGQa",
		@"SEYqadhIVYGFNZmX": @"iWkuEUrBJwxGyOfwPdWCKATWVQjZKAOzINTEyeeKPzfgOJQtQxOXKOHsJMaCVJCVgEtyRDjWqyYDvSGDuBJnrmUGKxbosLzXhYYTGytLPjASXfyJRSktj",
		@"NMVMiGprxmzeKuELPj": @"sREwqujtOhOeAbnRgsDqYVPHTwzkZnpdihRGdlFmxdftcoaKFhdxipPmuUrUuXJyQIkMAcuTaNmhxGwEGQTNWuLQZwZIfdWIOCptdfbmrKDCbWvUrPBQvxTfKghTVXGEnWVmSHMOyWZxoKcvKZX",
		@"CazRonDEEYaKkaDERK": @"TUtJgQKAsOJRiLZCVUpPafTGFQtjtBwpqipSgLKguAcjoDgBsfhYqmPIMLvKJYiuRdSsyxAQElOmRqlRtOqJLMwRPEacSupqfWJEgIzdzfjB",
		@"ZpqFvYACeQWAQxtP": @"FCaEGeQlRTqIHVXhkrtpmztLZwBTdMywIcELWADhcmUCQOtoYvItWELDbZlMDHJyBbzLJutNrWCSKzDSOltDrKWxowuLBLaCabVusAzdIZaBgWXzAXVZJYyaQFhjbeGQLCamtrhvgygmXFmVR",
		@"SqAvlwFxggwHbI": @"OdfUTTLrZHPVTcaVfJZCKMbmnbktMkBeyOfyPhhrOJLotyGnzxwySHUrlRxbZohBroSLweyFeTnXiIKfjrVoBXezmStLwgBIxKCGbtWirUCLFBccJDcThmYcMABxthVJY",
		@"pdBpMgsOYGc": @"hqxrfeyGwSxnOfIrvkkSUtszWhxzaAQhroYgJhQrttTaWfDWGjZhSgLTWHFFwqfcJPGpwzOJiZkxgXWIrLYRHsxqKjEkqZKngpyLklkGnzXbmzgSHhlIprVWiqhyNaBBEpxxTIfYYaQFx",
		@"edCjEzBandiTT": @"nGzrkdcuGSeuQvcBDctikAngxNNShVVhFLrVVVRFYhFouPqOCuVMBvqziabyVagQJsreQRtboWwLyFXVWXjvlpUCxylXwcFyvUJpKzeKetEakqRkDdfDGIzGVI",
		@"OJPtMEfqVRVTtY": @"hWRBcKynHSUpgXBMzGZTHhaIWjugQqqNnzizDrTxbqGQuUXqnBAGBnhMCbjwNvFHMmXhwVnATlQkaLiVMqcRfjRzSJkDZvDxPKGgUOdTmDxjdsODOaxJHbqNuzrPAnsJLwB",
		@"RxvLvEXUNUxuLXhFe": @"xtOnMgwSlQzvREUCItKWZEgkFlKmEfaMOLQTGWqICqYRjVNwNFuvpZfecIXJGrcSmUIVUxSfJarbnlBTAZEkrXwEYxCQfLYeHzZpNg",
	};
	return FqewGQpOVCQ;
}

- (nonnull UIImage *)KYfpthUSZgAISAK :(nonnull UIImage *)lTZDOthdHQCsnzaQEe {
	NSData *noRKByCrHqQuKFAdFII = [@"ZhfMlKjECjJOBKYYaqFCDRWOBzeapeITXUeHowFPDmkQtkyiJIJDkyyEIDRTAwtYdnvmujtIutijqVVBaduRwKCtYMWJPUZbRItjYrlmUdoELKOGzWYJn" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *lYKtZZneQtqmpoFt = [UIImage imageWithData:noRKByCrHqQuKFAdFII];
	lYKtZZneQtqmpoFt = [UIImage imageNamed:@"JVtiQAhgDhImxfIpKiFleNmeISRbxPyuvNgpYCGKhnkdgBsNlGVjTEjbQAlUtGJOONnOoUzmqhsphEBNcRrsAfyPsSqUOTQMXcCaWMqcfwALtQzUMVBqOpjOpMiTfHUhbtVhHKXQxAqd"];
	return lYKtZZneQtqmpoFt;
}

+ (nonnull NSDictionary *)WISrqIOtkXuI :(nonnull UIImage *)guxqCoaefHb {
	NSDictionary *fgOQyxNtDZsCvhaqQtU = @{
		@"nVgBgdUTORxSzGvG": @"aUGMGslgsopexdSDcMVvmHSftwpayqutFSUbMyBGaDZArUBcMPJCOWJZYcJoFMpFsGXkrbUvrrdLaztsjFOHzZwqbimfQYiERUGYKkKoqRFqVgwsdQVjIADFiVwSZMsGFwRFWMXuWHlFHAiUpys",
		@"fEXvBDcFRMOD": @"iyXImRilarxwKVSvkpVQhAJMkQubZyZWXDhQzjuywytJTIGWTAsmlZhByXBDZvSdXLBFvnSxZKLETshXpRGxZDyItnHWIICiiYENaxhbSGQSVlCkgQtEwACUt",
		@"NPZXIUBVLmp": @"zGrqNOZYiXOTcGCYbhvlCdPFMNsKjaCpkxHSgNyMAnnYhJqiKSQYbTWTpsqdwQNPGpyvmkFTIXCQxGPawuCEaRvPEEXHwcALxigxyKoFxkYQXDnXSrgtXZGaGGHxuweEqeJwdREhUgH",
		@"YgEtyfrrCa": @"FnQNrbWAZrjrqUCaZLUFLmNFHBRcnndCsWsjadmIBVRVGAlqWXsDTcwezJOsgPtgXXBVWZhcIFYhZeMFhdqIyNdCioJzmPDsDazxYSeFtQJPjRKkWIXFNlLYtgttVUEAUCWHRZOaOOQvRDPAznj",
		@"WtOKXalAgWiNfh": @"njbFIfPCzinTrAZyDDPVcQYDzlbxSEypZKNtjTiVgpMovCSMREsIRgtmHVfxCeNvuGWAOQtCIKizDwSIqtZnFavXUBidfxpjWyHiZAPfEdMig",
		@"SxSZBgSNeP": @"XzfQAWSyeZOtSwrTtFjWOZkTaVFyxGQPgsBwTRpxIBHCpbrvfCeuclLpVPYscDSMRFteBWuqTbtlEoORlXGuqClJKyLppZihzgCkLCRoLrmFYlccAQrPlCfjvQgjwaBUGPTtyiJIazYx",
		@"qORyeXeeatQxXnfQs": @"uxfrwiNSsbgvOSGxesNXlmQVETpPwypcQYSUtTPonJAoRDikZyRHmGjJwZMOPvhlRUXUYXbVjlIVrSJyXuwDHbsJcwSnOBLBGbxvOuzpDuTWoQLOfPfqpXaFBnALmZnudBanxRbUobLHzzqzwFJWN",
		@"RIVBqKZRzDF": @"ZHSITPNHPJoBJewycqpNWNASLHGRqFidMyOpluGfVVxOmBEAiNuXdZGhpnMGyeahRAJtMtnaSrKhbBdfNCIrfPvsTNuryhfIyUmdGUSqJMaQEAarGBxaTyRYrpZqbhcCm",
		@"fcENPgLupley": @"eTcexoXETQTkIdvYSengcyrBolDrchlqeGoDUjZPpGAqonyxnPTdaesWGyCrBmoqExSxypojqYafddrzLAKbgDanLbEuskTEzftXYTaOuHyiycdrKMMxQsyJR",
		@"zaZezuSUaQdCpNOf": @"lsJfrzsfshWGhLYQyaKJrVXzuHzeGEkCdUVkLNlXdeNzPxRVTEBSpVTvGvwAARqPteknQxINYtcIGjBYaAibshGVBFpXMrzlnJhnXkcBuiFAoSVDjeUlzvCPeUIsmyiGQXAFdHPdxSV",
		@"JDiItDoGdSRH": @"yewlXroMrXzfJLUeIrHApwduVrglORowKUohgMIgfSxeciLFTHkhhBPOQpvfacyjndhcPyDBxKramjxqYCcqxWyVHmALUhcfpThvjWJKWsfYgxPekWcLwPJpumM",
		@"PhEZGqNvNbAVWy": @"lDjbUZyVctduNtLZpgnzLKWBDxEpxKjVlvKiXELbzeqIzNGzySQgJTxTyFwECHbgjfmMZvEOGTNMOmnajaIhhutEnwxJmpNxGDuVzPFIDqAkFDjEaGZpARnhyNGzuyYuDdzDSRhHwgqNarJhtdv",
		@"eNobuGmAhUTHvIlMWZ": @"voRpvDSIUlBGHAEPNJIgpxjAWzEamEILOcJIcXVpFadrRLreLSbrXNZINTTSUfgkHEbNtGJEXmPWpsVrPUkhpQFNdsIccPuqvxZutxpgStSUezzzxZcQyQOpBJRFITaQQ",
		@"gHbhrCSdNqIMEGls": @"XHzaHcCZSEEYHKJIzFjQBbjAKdqpGJtwpNTxevdUzDgTREMEijaegXTCWuXThVCYQJrgAHpNpFgZNJioSsfnNmTVptxzidvmeTVu",
	};
	return fgOQyxNtDZsCvhaqQtU;
}

+ (nonnull UIImage *)DdrRyHAHEJWrL :(nonnull NSDictionary *)dYxLlKwlDCVsDLuKO {
	NSData *ftMPodfPiLaO = [@"kylmPOIDpIpRJKAZhKLLfPNVrARvjAyYMeRunfWxTynNvTnTVxMAfjvxjgLftuAPPRVqWkCmTHNimDnMkhVYNViovYcgXzZRSeFbOhMLodvocPLVLHlVvUFIfGgcunwfSFsOWv" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *wTNhmbGIsLeyIs = [UIImage imageWithData:ftMPodfPiLaO];
	wTNhmbGIsLeyIs = [UIImage imageNamed:@"AoRImQYFERWcysTQMRbqtKBohKoResbwNIWFlVQbCqMTYyrqAYswmIrPzrcaXgaSIvwuyfvchjoMPHCJZTTzceHxKJYEBbYynoSfcrSliYrvlNRHDaEtuXpJlbldLiuuhoGQxTAWIcvPditpAWDu"];
	return wTNhmbGIsLeyIs;
}

- (nonnull NSArray *)getaotcyahGqKoekG :(nonnull UIImage *)QKLzkoczbW {
	NSArray *moOWWMjmDVDzZV = @[
		@"DXizIcuxLCLiUQttoVPvHkIDnhcFzxeAAjRkkdrgYzWGxQXcsipoSSLdBXUzwCygZRjDhHodUAovPFOVKdvdwfABLyXIwzhMsowtBeCB",
		@"nbZhWKTCgencqQPTuJJgkyOrxedjRsJbmFxZICuwIZsjMBzkKNrIKRtqrFamcpaYCqkaHQWnSmMNqAonxKqZfhMldkQZYhcsltBJzuFiKdhpJGVJuDMAaz",
		@"NmmzPInphkSNPxWzrNCzysOnuAIKMlXZggPSFxvOAUbAmMNFgRPgeTTcVrNtpIfCJiJDIxFogGOXFiQAKsMTUNmLAmPiXxswKbzamCrVbqfsRqlEDTnTptEPaACvxfxDFmIj",
		@"PoLBleMmvDaoUYfIrZXmWvddFipTMoBfIbkWqTfPUccsOsqvMXAMzbXWSvYDUzSgUWAOWDjAGvqnCQxeLCnAYQGMAuGqJkZoTTShFgUjyewenDSSdgQXfBrpOXzfDfWXCkaWIxtXgZvLYu",
		@"ZyoPWgSKTZCrGQunqPmSwBLJQKvsKhGGdNgqbkbVpZWQvZvoQaojzhqFifxQBHiSQwENsnIUPFgPXfzICRGmXaRdfAMwCcjgTczpSyQvKwbyIrUMeUFNlfyRxFCZBCRZogyc",
		@"stwxUCMiOkWwQroYgMeUQVvfyJkMRCGoOkfKXOGQHJnTaRZGxXqSFgbpYaesrizLbvdfywaerXhaKSnvMydZictxvRycBvgBPROxHdRFurzKiWVXY",
		@"hjuooKoejQMkRQAYNMrbFbULBbbpoMkcxGQekuSAlLpYekeujJFNNxYYstHHJQzASKOwiuRdAxLhIsTlAeDhhVGYOudNrdjwLtaH",
		@"UExTLAXskNRTlLZwBtxVUowGTpHHeiYPDkSIcepjKGuVGmFFTmeloTeRphmdPpkDUKIkjnHDJVyVXgKEWtQlGAoWGBQPwGbnsdCKamxVOQAFsPYNwS",
		@"JQoberFBxWpGNogTetkHanwyzHTGxVzdiamiOnsIXbXoNyOUrbawjDWTmWFpfWFCDkwKcBWEmyHmYwEzcrjYxvnxJVFIQIIBLGjzfJwthWIiyCbfTpVWpZCwzbLnifSxfBnipBvZxyRzU",
		@"LtfUtsWQIwdjZPpXrALEResFBmLNEpUUXmeUdQCkEWZYthrfzkvmrPnVUoClcnLsdtihftqZDvHKpgjYmKLpBqhEVwBVrhIFBvJlaTobOajiMvkpErQKcDhUMauNcWvqzEt",
		@"RsPukPmBbHbuCQTwzfrjwkHGICLEcqupQediOYPZvZwWTHEaTKIHCdeJcXrsaaZzPqBiAhSgzjwTEBroLnOgnuaixIiAmiqayyBmdAAIHuRxveNFDKSLLavCyEOJImycz",
		@"NoaXanXtOtdpwjgRIUlpGIxLPTZSMTPMuRzPdOTKIeCLQCWFyNlQICvpQfcnSOzUvyejFNYLZSAoKFJCCTLUxszHrRemNSgPfvvvjRhZTyxDjWCGelVukNQDwqyXxHRyzYFDPsVSJKbLEm",
		@"tyFOuxMVSzsRCFTmJihbjgoviCQAteBSOiboskOOJGgTZDAHeaKcxZEbbJhfOjGEgboJHDqTwRNpKJpTYUjrBGcXJDURDVtOMkxdrhalKuD",
		@"eSgWVvZBytKhsBGuTbjpsUAxZEdjytsGpoehUAlmjnMygLdYjxxYtGGAwRYSEOJETgCZKRLsJgLEMFjjLHEgIhldEMENJLbhnmyyAiSjWAUXGPcuPGkVPjK",
		@"yqdvVfNcvIwsZepHRyTWzRvrBBjlpWpSCnAYJWOtRWoRVlGoiFqOeanzSEddjDgQzSyvHItscElLZPOGtnhfMJWisFdFpjnEcOjIYkL",
		@"seesFuRMSIEpOWEsbbuCDeFBwHSiQURMkcZzfcLorKIspkUibCJAfwhQFdNHKoklFnjQhqnvdcjRIkKUbhxKYmAlxlgrjUdxYcIRjLaoxpRkQoSdQIoryZUsYjZy",
		@"YGxbBCftRtvSPftuyXSLfUbNzWvVybrKAowlzdYlJqYuooMtcWyObZXdvlYvJrqitcLMeOSOzIPJRGtAtAtIMndZBPkPylUoIOHRwlJGXhVWFVIJUCRPvQvCGyryrd",
		@"JHsufMIydSLftlapFuCaMUXMXgfjZCizwAOOsdIlOpbNTNqBljslCMASWyQydgZSCMQZONMGdxsBfujJVAAlIKWMEUWBzPPumutoc",
	];
	return moOWWMjmDVDzZV;
}

+ (nonnull NSDictionary *)WvjyhBLmfAOc :(nonnull NSArray *)TmKfLLaTyxexguHFkR :(nonnull NSArray *)jEmZMPnXbgILBdaOU :(nonnull NSArray *)oIzrQjYdNiZQFrWxE {
	NSDictionary *dIFWFBwFLfdRxYbhO = @{
		@"nknjVNBxDbIiptDfWO": @"SfSTcAuOozRSnVjKsdcTbIeZIrdKTPHrRaCtrNzkGOiBBQbtojPDXNRJzHXCNpPFwAHpRIvOLQUvBfJLZOJFfdwNjobLZbOoxpEgBUVqvovBhNMYsEMZeRsLrH",
		@"WXAgGrgwcjmSPrI": @"TrMITSeEnOZcmASHJDGmjYSNZarsVPsgvnxUPuVyPkZVwlrsFiYkGFtBLnHZDgbjkxnYYNRSAvZoKjOCffzfypUttpGKovkSOQRuSQXJCkIlZKNMaoTeSNzvdzzXp",
		@"VBgcuoofnQ": @"xQJDHcEknjcBTfDNGSxCiBUoGekSbaIkYQFGfpLgSlbIhWXXWYlghhgpFtdWvKyoxPDRKQNBssOLrJgHWgLninIlgJXGYTQqstqWGSORtvskNIyBpLcgiXspaiFGIFYP",
		@"RlsWufTklB": @"dahyBCZJJnJFYpGuvRnZeMAogJTpLpuQhmgbOzkfazowDCAQTaNsEdQGHRLzrztGhTubPviLhgmJAdcKvblJZTXWnzxDLyvihfaXcJTnQsWKluWC",
		@"YcAIwCpcQfM": @"oCNbsBTtZhuhWhbdmWQkEFcInPSkNnCLDFDXakOMVNVExEcYbjEXCYYmHsFyrYxILWHvcANPjIUAEmpYkByvXTfISvhmTjhgXnUhmWpmzDupbQhgSAVfOeqlNyacUsXHJUYvxigABWl",
		@"fAkwnPtvNiUknYuJjUz": @"tAbIaiMELGBhlhUkhJVXFdPngZOJeOejspdUDxQCiuCJTzJamUtyzQsjQTMDYjCNYoQgjsFWZcIbjhugvxVooNdGmVbGnwfMAZQYrGfkQEXzYeloPxxPCzqNAJmUJzSJafEGCOipc",
		@"uXiyWnzghGaNUUgCm": @"uMDnrPHBgqnZJPwGdjVMxubURckuGaDQMDEzRQZivSYzNEarmROWynbjcVoERvtUmfiSefXUcJDkroGhtvLWIkrQybVtmcvvrqTpmWmPYKiUVqQoKnTcq",
		@"HlmjgopaOdotJrOBJd": @"SNNXcILYUuIUbYcqQepLiOSKMaWpiJOeGNpJzKVLxhtAoTbiUyDIJTCsBbAXQyDRQVJQEpNfwUvqzGGRBfmspzwfxnTAtFEiJPdj",
		@"SKqOtLzhxsIkFdzfJ": @"eFNZJLMRcatwclQeiCtQvPkSFNPZnWAAxxsUYXQvzAxOXtBKWdhBxNaddyLIGyJxBivRmGILRjyABaBNTcIueVfjApqGjoXalsfhKKKjKWuiykKNkAxZvTXiOgNcZoaG",
		@"apQbHdTdqeRW": @"yKjwjDJoJmIPFLvxBjmZZjGffcbBdIwHNAulUBgqzmdMPgysLpkYGGnLxUJYldKewqyQXXwHDSCgMrKeIwbgEIzNxboqiCKuFlIPyWisChyEVZWYrfG",
		@"wHdRyfpFlpnM": @"GVjBGpQBOVYhFNFsJHgPyVsefiGbiHchjVJHYeqaKVmaUJGnDPppwmwRvCuoWxVzBuqlxBMMjtqHeGiyVBOvHKdyBUuoSmTrlUNuhAywPYSnDmvPoYTuebmOVZy",
		@"kPqNeoDdnhLZasKpP": @"WOFBkkmLItrczyatJMGkrjsZJmZJlYbcVMraVUDBKqQlQJpHyXqjTbZEjPJYHUaYVPFQPbeyywXtBGKRxOnkyiPXWgonPqRLrNNrlH",
	};
	return dIFWFBwFLfdRxYbhO;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}
- (void)setFrameWidth:(CGFloat)newWidth
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newWidth, self.frame.size.height);
}

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self.topLine setFrameWidth:SCREEN_WIDTH];
}

#pragma Public Methods
- (BOOL) resignFirstResponder
{
    
    [self.textView resignFirstResponder];
    return [super resignFirstResponder];
}


-(void)sendCurrentMessage
{
    if (self.textView.text.length > 0) {     // send Text
        if (_delegate && [_delegate respondsToSelector:@selector(chatBox:sendTextMessage:)]) {
            [_delegate chatBox:self sendTextMessage:self.textView.text];
        }
    }
  ;
    [self textViewDidChange:self.textView];
}


#pragma mark - UITextViewDelegate
- (void) textViewDidBeginEditing:(UITextView *)textView
{
    
    
    
   
    ChatBoxStatus lastStatus = self.status;
    self.status = ChatBoxStatusShowKeyboard;
    if (_delegate && [_delegate respondsToSelector:@selector(chatBox:changeStatusForm:to:)]) {
        [_delegate chatBox:self changeStatusForm:lastStatus to:self.status];
    }
}

- (void) textViewDidChange:(UITextView *)textView
{
   
    
    CGFloat height = [textView sizeThatFits:CGSizeMake(self.textView.frameWidth, MAXFLOAT)].height;
    height = height > HEIGHT_TEXTVIEW ? height : HEIGHT_TEXTVIEW;
    height = height < MAX_TEXTVIEW_HEIGHT ? height : MAX_TEXTVIEW_HEIGHT;
    _curHeight = height + HEIGHT_TABBAR - HEIGHT_TEXTVIEW ;
    
    if (_curHeight != self.frameHeight) {
        [UIView animateWithDuration:0.05 animations:^{
            [self setFrameHeight:_curHeight-5];
            
            if (_delegate && [_delegate respondsToSelector:@selector(chatBox:changeChatBoxHeight:)]) {
                [_delegate chatBox:self changeChatBoxHeight:_curHeight];
            }
        }];
    }
    if (height != textView.frameHeight) {
        [UIView animateWithDuration:0.05 animations:^{
            [textView setFrameHeight: height];
            [textView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top).offset(7);
                make.bottom.equalTo(self.mas_bottom).offset(-7);
                make.left.equalTo(self.mas_left).offset(15);
                make.right.equalTo(self.mas_right).offset(-52);
            }];
            
        }];
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
   
    if ([text isEqualToString:@"\n"]){
        [self sendCurrentMessage];
        return NO;
    }
    else if (textView.text.length > 0 && [text isEqualToString:@""]) {       // delete
        if ([textView.text characterAtIndex:range.location] == ']') {
            NSUInteger location = range.location;
            NSUInteger length = range.length;
            while (location != 0) {
                location --;
                length ++ ;
                char c = [textView.text characterAtIndex:location];
                if (c == '[') {
                    textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
                    return NO;
                }
                else if (c == ']') {
                    return YES;
                }
            }
        }
    }
    
    return YES;
}






- (UIView *) topLine
{
    if (_topLine == nil) {
        _topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        [_topLine setBackgroundColor:[[UIColor alloc] initWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1] ];
    }
    return _topLine;
}
-(UITextView *) textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 7,  SCREEN_WIDTH-52-15, 35)];
        [_textView setFont:[UIFont systemFontOfSize:16.0f]];
        [_textView.layer setMasksToBounds:YES];
        [_textView.layer setCornerRadius:4.0f];
        [_textView.layer setBorderWidth:0.5f];
        [_textView.layer setBorderColor:self.topLine.backgroundColor.CGColor];
        [_textView setScrollsToTop:NO];
        [_textView setReturnKeyType:UIReturnKeySend];
        [_textView setDelegate:self];
    }
    return _textView;
}
-(void)sendMessage
{
    if (self.textView.text.length > 0) {     // send Text
        if (_delegate && [_delegate respondsToSelector:@selector(chatBox:sendTextMessage:)]) {
            [_delegate chatBox:self sendTextMessage:self.textView.text];
        }
    }
}
-(void)changeButtonColor:(NSNotification * )info
{
    
    if(self.textView.text.length>0 )
    {
        
        self.plachorLabel.hidden=YES;
        [self.button setTitleColor: [UIColor tc31Color] forState:UIControlStateNormal];
       

    }
    else
    {
         self.plachorLabel.hidden=NO;
        [self.button setTitleColor:[UIColor tc31Color] forState:UIControlStateNormal];
       
    }
    
}
@end
