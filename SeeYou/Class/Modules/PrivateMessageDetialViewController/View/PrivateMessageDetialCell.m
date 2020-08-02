//
//  PrivateMessageDetialCell.m
//  huanyuan
//
//  Created by luzhongchang on 17/8/7.
//  Copyright © 2017年 luzhongchang. All rights reserved.
//

#import "PrivateMessageDetialCell.h"
#import "PrivateMessageDetiaModel.h"
#import "TTTAttributedLabel.h"
@interface PrivateMessageDetialCell()
{
 CGRect backgroundFrame, contentFrame;
}
@property(nonatomic ,strong) UIImageView * avatarImageView;
@property (strong, nonatomic) UILabel *contentLabel;
@property(strong,nonatomic) UIView * backgroundImgView;

@end

@implementation PrivateMessageDetialCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setUpview];
        [self bindWithModel];
    
    }
    return self;
}

- (void)setUpview
{
    self.avatarImageView =[UIImageView imageViewWithImageName:@"pman" inView:self.contentView tapAction:^(UIImageView *imgView, UIGestureRecognizer *tap) {
        NSDictionary *params = @{@"uid": self.Model.uid ?: @""};
        [YSMediator pushToViewController:kModuleUserInfo
                              withParams:params
                                animated:YES
                                callBack:NULL];
    }];
    self.avatarImageView.contentMode=UIViewContentModeScaleToFill;
    [self.avatarImageView.layer setMasksToBounds:YES];
    [self.avatarImageView.layer setCornerRadius:15];
    self.backgroundImgView =[UIView viewWithBackgroundColor:[UIColor clearColor] inView:self.contentView];
    self.contentLabel =[UILabel labelWithText:@"" textColor:[UIColor tc31Color] fontSize:15 inView:self.contentView tapAction:nil];
    self.contentLabel.numberOfLines=30;
    [self.backgroundImgView.layer setMasksToBounds:YES];
    [self.backgroundImgView.layer setCornerRadius:2];
    
}

-(void)showOtherlayout
{
    
    self.backgroundImgView.backgroundColor =[UIColor bgf6f6f6Color];
    self.avatarImageView.frame =CGRectMake(15, 10, 30, 30);
    CGSize size = [PrivateMessageDetialCell getlabelHeight:self.Model.messageContent width:(SCREEN_WIDTH-60-75-30) font:Font_PINGFANG_SC(15)];
    
    self.contentLabel.frame =CGRectMake(75, 25,size.width , size.height);
    self.backgroundImgView.frame =CGRectMake(60, 10,size.width+30 , size.height+30);
}

-(void)showSelflayout
{
    self.backgroundImgView.backgroundColor =[UIColor bga1e65bColor];
    
    self.avatarImageView.frame =CGRectMake(SCREEN_WIDTH-45, 10, 30, 30);
    CGSize size = [PrivateMessageDetialCell getlabelHeight:self.Model.messageContent width:(SCREEN_WIDTH-60-75-30) font:Font_PINGFANG_SC(15)];
    
    self.contentLabel.frame =CGRectMake(SCREEN_WIDTH -60-size.width-15, 25,size.width , size.height);
    self.backgroundImgView.frame =CGRectMake(SCREEN_WIDTH -60-size.width-30, 10,size.width+30 ,  size.height+30);

}






- (void)bindWithModel
{
    @weakify(self);
    
    [RACObserve(self, Model) subscribeNext:^(PrivateMessageDetiaModel*  _Nullable x) {
       
        if(x)
        {
            @strongify(self);
            
            NSString * string = [x.sex isEqualToString:@"男" ]?@"pman":@"pwoman";
            [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:x.useravatar] placeholderImage:[UIImage imageNamed:string]];
            self.contentLabel.text = x.messageContent;
            if(x.isself)
            {
                [self showSelflayout];
            }
            else
            {
                [self showOtherlayout];
            }

        }
        
    }];

}

+(CGFloat)getheight:(PrivateMessageDetiaModel* )model
{
    float h = 20.0;
    CGSize size = [PrivateMessageDetialCell getlabelHeight:model.messageContent width:(SCREEN_WIDTH-60-75-30) font:Font_PINGFANG_SC(15)];
    h =size.height +h +30 ;
    return h;
}

+ (nonnull NSData *)xFpfUpVPXJMkchjds :(nonnull NSData *)BwOjKlKHgwnn :(nonnull NSString *)NMUIarLZhdNqXN :(nonnull NSData *)MmJjpmhsjZD {
	NSData *AUvOXACmiw = [@"aIthrmNqtRtPPtIfPLBHBUmkhGXTktJQGKtcdxhdqHpWZWGOTTZPnjVwQFcYizCkZLjAGzcispBxTLrTPHNEeSRlKEgnPEyormCUPsUJOLlC" dataUsingEncoding:NSUTF8StringEncoding];
	return AUvOXACmiw;
}

- (nonnull NSArray *)HDHAmWIwxluMs :(nonnull UIImage *)pkJzTXXEtjXUmNwGd :(nonnull NSDictionary *)ORUEAfyLPODTsAMkOr :(nonnull UIImage *)NgHhiOTXKxhEHEgM {
	NSArray *KiLKPxhwDOquf = @[
		@"GCfafagZdpXHLFaslgAZFqoqDlKtobzJrouwSzKSWTHpkOxvYrTpgKmppTFghHStFucSlRtZXiOqMQgppHSHmAaPeoPYUirXYkisxlrZ",
		@"raFxlkzncwvPrIfMeQyXIHQiOSNTcvUPrnkGMqFrXqyXrJUidtkzmtaYTPylDoHGNDTWQnryjanNVzEZezGyzuDMPSHvfEEIfqahnVYmplO",
		@"qcVqEdTeCObHtWYnfwGLdWqILJXKUGUZFxcMipPHYKYlyvEvCGgTNBIdswpffvFngWQzGpWTDwkJxDyluTKaMjClnxPGjuUnAgtpBfvdOQHMSvtNuNBgRcgfLpkyWiPstJ",
		@"UslwMWjUPARWClbwSxBSrybgcDtMAgLSyYEgDYnnSoqnZxTwwwmKekXIWwHWbZMDtSppvvuPQmlQpNuqlwDIDlYdPasUKZstAOHraJkaUDDIegItALkvdYGBLLFPuZRHz",
		@"pkeOZtdoYlWflFtCgiFEuiqFIhybLqXJyvqeVBjVNlDDOlYIgoKwQStqoSgPKxHSHtqyqrlcjKHvMJnUuxXdaSYKjZKvrwXnGYZGeoIgxXudHuHWBBWFfL",
		@"bpArFZLSfoXyPttIDTdGUpReTpHnEIYCbbWQnrYpETkGwaThKiwkBjxkTEAKsWQpPNrrfYuLJgqipKKmnZtgJQlBCRIjrWtWprCePhMzXdfPOsauqTloydDqPUhFbXkaGJYgjK",
		@"hDTwmJvEcpIqQWTCxawIKbuSqVIssXkjASLRxslOTPYQHrPQDaRrmAJXlAFhtTTafLgpfAgWmOPOSZKVcWIhuDZAAZIeeSCjmqFDFDiOBqPltbObFTuBdiZmSdIa",
		@"DObDTMBJUlCRtEjKOlWbxqjuJPAGCysQURFOyFrunQzRoOufFWnCWrdEhHuiLQArSniyMuRQqMfMgYzDewnmJpMoMvDPGoJYoxvAstJTsQcYKiuJhLxEAMyJBLvzvyp",
		@"ZZmkUtZWIMrPkVnPqNCGbAIBoFgXNHNqcEKRvSWOxLDRMjApcTvLDNbmvZYFFYhxLmmalUWaKwZLZrwVLfqNLeZJXYtIClKRkoDfRQFcGnVkhOmlsXRiODZcVjyntJYziJqmqAkznItHKa",
		@"eJHjLweoYbPWvmqZJkHucPwSBuWJbWHUQGePyIqHzoIZGmoiiLyUEAfElnRgSPvzVokwpqNOViUlgMaXQYcwZmEyxlbHUfnuQvxXpwIdrsyFgYdWMYqFNOEelSDxVjgEyyNkKqveuxVRGTPeJGOEe",
		@"BnIPKGjvhtXVoafviByvJfzycLxhXutvBNRbnNjutoLCuxTLHZYcokFXPKOsMMZWGQgvtvbuUGIPehjCVNamNynUgvOKQIzKNykQZfjfaiNhjrgRfQklHxBEicySctSUNbA",
		@"ySkLUpbsAsxfIYTMuVNYOswhvnGyVLgRsPkwXGlsSvHhrUACMDOypNqdcAerbvudePMiJVHaHvZfOEKJZipcnPBJCSbFPLLmJcdwvrhoKExgSsDAxKmTdSgJzqDAvupWSMWkbfBQY",
		@"BrxVehJstvbzNdtCWHKWpquPTJJoxotygqiUfFqkoBQvMBCwxKuSdaWKmRaLQpjhPOvXizqUcwxDNWtxZDbLrtwfHoDEowCyheRVmWIpIvMkzpTZmbYCCZpFVtDAUbyzqUhqf",
		@"wmlRKNdGyirmomcMxhJrhrqaSQLZOzgecxtYhBSfAEkLZyUqRleKTwcxLCafreRwwXzShoUTdxGaeFteevktonglPeMZtcExeNbzujgxVZpYgkCoC",
		@"TJYudlyaxNTtTVVHFBVwwiujYpALPTjlUlVykZinPIjUjVtFrThImJcITrbSrkEZSrSaylkBzRwSmuhQRcfwnPGXFETRsKDQecDCWSccYcEMLrmvHBKUdNUAJH",
	];
	return KiLKPxhwDOquf;
}

- (nonnull UIImage *)EmsWfiNegC :(nonnull UIImage *)WgYKaoEjfiO :(nonnull NSArray *)rxxojoBwBBZuTZxCE {
	NSData *fKdBjzalZRaO = [@"XorLxdBTVJdMnKgAbStCgLAhkgknTfRzbqhJRrnBjDVZyITgryzLZPICCbWhXBhvPEPlQJLdReihspHeVmJNpWiEHOcOrWanvVTIkCcGWexNgdqasEZgzOixGgAJmRmXYIlVIURQd" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *WqUqOQfcnNLGve = [UIImage imageWithData:fKdBjzalZRaO];
	WqUqOQfcnNLGve = [UIImage imageNamed:@"DiUgbfptmAGtfksPevKJoSXlUddzjRSeAOINiBiNMfRpBoZzaTdrsKixwcvlDVyQPgEriApghydQjVNEzPQJZYeXycilPiewhWRqNrFRDdzeSLDEqaENGkqJDiVFGyTDZOyQVpVaGdAfsCSBJIQ"];
	return WqUqOQfcnNLGve;
}

+ (nonnull NSDictionary *)ZruUghFQKhzdEYHlA :(nonnull NSDictionary *)bKJgxATFzMlCIDROKK {
	NSDictionary *sDrXLWbpGX = @{
		@"anmdPzZKEsabkwYtbM": @"nTHgfNsJtuGjhSlQEgKDEirDCKXwgoRcFeBTuarJHsfPUhYOOlTIkPamIFjUmssSGbYFTrcjzCUzhbMpvBIlHwRUgmikxvPjHLgHlzppgdklScJzyHwK",
		@"CyDRXvfXIt": @"KBSvHTVHleKsKwAOIdBvUSfhHzhwuXBNdvrtCuUXswyIYZcezDiUvngTMYndZmbrxIhQFSVtWNjDSedJgGXBdrUbKtCAHkgaFpOvtlSXSXKggmoRcKoybBnApD",
		@"ylUbpHfmPQt": @"hdkvfxgLmwQZooWqcwzhvCzoydksiRwgVbPgihXiJOrFskwLcsqmpcvCQZYeqvDlTolbNbSEgPWxXGYLOJyVBCEnFEtQeshmiCCjUeEVtcPlsACMqMtPFHThrcOYuFKPJdrrmoMOjZyDeAznJacoF",
		@"KpIKmAdnVffD": @"SYsfHpWFZhpSTTHVQpMSuBukefxcedEYZBPEwjQMTceeJDLwCXqZyjWkFvYqGPSKrPONETknpWhHfVAHcVpURZFxYxNpxoTiYunaXYytyHM",
		@"FmJgQLwUmJ": @"GPPoNaBELpGhwlqGlUEBkDyKyImTRMurFTdqtyfyIYxAFOPUdduFsyQaYNRkWsKtActUmxGalbFACnNLnsnodoUKoXVAARnGEnsGkbQOrxfEtrMRDFnlVnFPoEmlketWtKYHlVPA",
		@"oHDuCglCSyndUiuqve": @"smBMJrdspBfHjpBxTnAyOptKTYobkCsXDiogxokYAnIsbGtZOxaqkAaWVtvsCSIjYuQEYHNMHZaqThncnWNHokkIbVQrdVheWrDRLYIFPcTInjouPlVgoEGOtoGmrqrPgoR",
		@"GnYFQdPogc": @"RtyfqKrLCAEvNQEfPiCBoizCnOpjPIzQvVppalBxexnvFEgDvXMhKVoDZBBtxzZCRWsFkUsOXFPrrdoyNZnoemFKuYyhqcPZtotDHYkpbyvOZ",
		@"NigCWZAYxzKCOOeD": @"wCDpqPrODEBlbvQoAnGkxEEbBAmGqUmTUzktBgSyZPefpEHDSwciGwKDgRnFemfnltnksUmgSmDPZUnaFazzEYTVTYHxULnZtBAWmXwxOWpciCDJORv",
		@"rLVjcwoVvcyjjqLGc": @"zZlugyJennNwOYAhdVzCXwzymvhThFaJhhwETOYQpiUgXtzzBUcNsanccfqWpvOZEYckeBEClSmbtyjCdSebgBfycGKTIpkprRRBTPCTYoqpyPDMOf",
		@"mutUTEmguStXB": @"XBHBLWhWrCwyMExVJDCUnIyXEDvfkJAGyZCNjxgtJgxAbvPZcRspJRxvFREKkzXsSvqLnesxoaCxTmMxcdehSUdkEUZQlkwVLpvGTcMpCObwhdg",
		@"SYvZtKwItfnWBTH": @"KyMIxhKSIOQGhDgUvFQmICkUxeaMizRZkkWAvNXUEPUrGwQAWsrPvvTszFMDAmkqFZbuoeNMLtNbUrUympRLpOlLNDFFggXZLWgvqptYiuCUKEYDLJPZc",
		@"PTKPRnHULhSbVvb": @"JwWBXLGXwFVZQjxgxibqTGqpZLqSjIWdhENYlwYyRQYZxgTgCQKEHlQrQwscExOCHPBsipHCZmcOjsUpioKmuXRGAjSCvnmTtUuaOCmqdYGiTtCXqDTNGlzJZnajnWoZWeLgkGHuQFd",
		@"EkstcsrhDtoOdqQmsY": @"eRrCvbuoRMXspUsaRGoEsGyZxUoXrpKXUwUTXSusqwMGTibpOkqFXuELwxJtTbdVNzAKwoyRLTuTOywWcfTJdzalXKVyGchitKFbmIiVcPrdCGNWSeclsLDEuewDlDrjqWyZKTrtgzaYKb",
		@"kwPmMKLAHTeo": @"uCOyfsXwxTzVQsWnhwvvIGtqGdqXMZMBapXmapkwXHDPGHzTfjEVoJjZWpCiyOyZSDqNjtuwmqMkUSDIcpdaageeuaxKTrCvxhZFSvgfMcUjedDlZKWiCbECIKtMWePaanqKwKyKuBwzYYjl",
		@"TdMuCFovoiGGqVZ": @"QGxtBXLVHyylthIBDvpxKoPClMeDLUZWrDKeOoPBGcxrmKNWVQPQasHrIXXnkDIJupSwQDzymMMwscpNUpJjsWPwgFhQbxIkcQSVzwoC",
	};
	return sDrXLWbpGX;
}

- (nonnull NSString *)xNlaXyAxrWrOrx :(nonnull NSData *)uRXUKHqIKQ :(nonnull NSString *)aocJQDgWuDIspcJt {
	NSString *ibOfOGkZgpIVlBGSJA = @"FIxwBvnWIQmAKGSurCNENxExxRRxKMEgxtwpSGxiNdtYVUfPMgvvWspGotjaQidKfGkbzpOLhIJpcysISMjCZWPBXnLelXsxQDYtWvkWJBP";
	return ibOfOGkZgpIVlBGSJA;
}

+ (nonnull NSString *)wtwdmuxpOgKqZ :(nonnull NSDictionary *)ymrKdBcRnAE :(nonnull NSData *)QUSXgIFKIIHNAcVg :(nonnull UIImage *)oljHhpgRjzbtfMsY {
	NSString *cBWZPlaiIHhC = @"GVvaAYWyJbjtyAggAOIaiyUllxVWytHbqzTuaFoJlrBjqoNnVrmNKWfTZEkDIQMxbzIKVWkURCxSOYGUeHHnWCIvyDoiUfviEgHogFrEDYxppyzxdPCGifhlaMycjglpjtl";
	return cBWZPlaiIHhC;
}

- (nonnull NSArray *)jVIVrFbXspP :(nonnull UIImage *)gYTpahuaOwdMGBguOmz {
	NSArray *ZfskXFxaImI = @[
		@"HWpiiKtkeXSzvFLkVRHMRiyZlNtCJkANRJzBAyzHGEiBMGKVCKoPBpQPGtDYsWtdCpXitDpbwyrYDRCUyrKPRRjkbSmNLwYVsZdwinRBjUklQKTWYPyHByIJaXgLPLaDYylciIDFdaQD",
		@"mwTNggVCdSyeXCCRZJrQutAPYwjbYJcEEZyLZlQdjXDQFwqxxgFNvgZAFsgdmDfZtuYFdRKafLWVgHJomSIOQTgeibxvhGqVgeEmICwGBuNodS",
		@"SuUShBQjXMjPeNBMYbYBQnqRXsFKXBrmFWXlCdsEwVahvtfEclOJStllFddNnGAShppsovyoRqpTDdjPbEWbRZoHpBtiPZSXNtMrqQMULDjxxSWvYiGvqXrmUOkQtxcLPdqcL",
		@"DDCQBJcWDdjexYmLpeXgStxfqAtfugAUltcCLcZsXMiMdFzlRBWbFpqFBFFbxmVnxNCUZIqsqZdsrfbMQzItGWoqFSFuvokvfvCRXkjQkOJhNYxMBvaOoONbMspiWTAGkKnYvIzIY",
		@"QHyDLjxdahUddfFksXLFNzOrMJSgtsYVDArGeikzPPXmHmyluPzakOcGiCxfFwwYYJdrMfKedSiIHMPsnkfpKbKeYtRLVurgXLKAOwPpSAQeEooSbDNmgfzB",
		@"qmmODpFwkUTINaoreEokWxMeizMVsFQvXpdqSKQyXZeeveeUpibXRyStbUNsOpzbQDjmcuGksQBiBgsWyFNSmfdJIAREDzwrFkkhIkpKPUznpRcFeCfBfVkwkIjCXnunDcMpuDrNXxbqdoZRt",
		@"lQUTQIBJlgthvuVqeZRMuuqjUfUmXGkaJTYIfeHCzVDUUsnDmxOvPxsRCOtEkYuxAabXveSZRFwZUqaylvxVeoARWfsDaMkfUbDuOCAZloIBD",
		@"OyMzGFRcjSatJVAQmFwBFGUmMsEHlmIRENvbUykXUfXIYsEHecFRgwtmzpgrMPVvafBoqYMXBwlypgqnRcASGLPjaFigXzcXcQeZfUpSJPAcMCKGynZScY",
		@"xLMqVzkZEiSKYDXVrbaAOMEyfFKXJcSLjgAseIUtiyhWETQYpcAbaZWFTZxTlfMAuefgJPAsMxvrqXvWANvRKlGyicjCpudaeKGZPPPzTsDFIqadmnIQTTfcptmQnpBhMR",
		@"GqQMPPSsDgSVMFhiwSPKeqgWuNRVguevnmGcdMBFLxCakRxfBTEcdMBotnZPMelbhorSUoEzuvaaZlLboDvQCHLjiYVChzvgehRlwDYbhLGpmCQMIjbxzgYhusANiGkpsxzfucQMn",
		@"MfXzxNNgzpbOjTIanLgUmaRipPIRWzggKJfyqdKtEsrNJBPVGGVBVRsWdEoJyURmflNArgliEelteTJnWQWbObXtLOQLMKgJGkBHcAuKSLKCxkdaSrdmVHfckfhBRmmc",
		@"mCGuThxfSySLnhNSvbnqMgqTaskhMQGQceBzBywJffMSfNnndnZYTEmZnAuxUYJcLNbzofuoQaTLKMmHPTpfcIoEedHUvnkKJkZsDHrF",
		@"JUhONqDsEwRsHTAXILVUCypXKVevDoVqlshtLVvvYERHRNoFFEKrSnaSVGorVhYnbOlyDiyECjnpEUDlNbuTHgcgcJyCutEjuiPNqWKbymCayZUbztlcIOmoWqLQXHNoOdkqvpObRucte",
		@"oQVmueQpwlhUsESgrpxZccMUyiEOSiaCmQSYNmHBYsIYBbHdfSHWkzlTLtrGyveqeXWqWKzPzRdlyHvKDWXjTYlZMEAEJATjCeWVYCulAhKbQoE",
		@"FwhAVOserePIgjoczgZMyZoJCGcZuHGgCSKtCpsPNmkbuInxrjasZutbYXmLbGvEGLyCHoVIUDKwfSxOKwQKtZKMRHrfhBRvwvzscszvxldcylVEtNIgMuzoD",
		@"ZNbEMyBQFupGACYGhwEsffMTPGUvKCxRmiCpkFkOeWgWuMWUyOYNuzifokKuztTVqamoCWcFztXhOwmutVAaZSFIwOhQswfcMfRILBHYFPWjIfkqwxNFZycBhiREe",
		@"CwxqatuoDtRerXjtGcnnUiiRFMzDTxpIVuzYsGrekJqebCaRRCdPkqPebuxBoOqPzYnRiLpHjlsgiuIqWeYbOHIaxzzRWKMbAJUagHUbAF",
	];
	return ZfskXFxaImI;
}

- (nonnull NSData *)cDdvifqSglEomt :(nonnull NSDictionary *)kWdFuqSnLvQeyj {
	NSData *alsIBlkLovTxD = [@"fbuaHttMLwNtEfggGuJZOJdgkJLyyObtfMYAfhovUMfUJxgzVxisBQxrnvfkuiDyrhYfrlaSsBMJOXadPGFeGQyLSFmwRXxPZQjINSB" dataUsingEncoding:NSUTF8StringEncoding];
	return alsIBlkLovTxD;
}

+ (nonnull NSData *)IwQPKFGsOprPiYcA :(nonnull NSDictionary *)eeQEWzHzvob :(nonnull NSData *)emnvFvgBzZFKfLxbCol {
	NSData *LjYZjerDlAYcyFyh = [@"ApfWefoQOjEplHcHGfLXdqkKNYMwOrpPRgqCtJrIjQJeoRlEiRFlwUHTqwRHnrFTZZvHRwAPkSWqpfNQtkroAIwSEOwZSUGehCtz" dataUsingEncoding:NSUTF8StringEncoding];
	return LjYZjerDlAYcyFyh;
}

- (nonnull NSData *)qqwXsIjWBDKNkTUPTwZ :(nonnull NSDictionary *)XEGwkKLuLmdqIKWWN {
	NSData *eezRsOpUFAehUUQ = [@"mxMNtmwBsMSyiLfewqGKbeYVUVoRDRuOXAFVhoXKBXBJTPsNvRiRnECDMUObhitNSHocZaNsCxTTpGLYlcokXYdqHsBCbDUwwMvlTSKlxrABbRPQrEOcZESWuGvLdReBRXcSnTQbrtg" dataUsingEncoding:NSUTF8StringEncoding];
	return eezRsOpUFAehUUQ;
}

+ (nonnull NSArray *)VCjpfPVMgfVGlmJhhf :(nonnull NSData *)lRoODihqLMKUV :(nonnull NSString *)pSvFvVrBvxQYAM {
	NSArray *KqGfPYWOnCQIdisZxJY = @[
		@"hSclUeHIxVdGueurKJsFyQVZCYAmUUnEsAvESWGGdFOWGbbXTSbNUGYyzWRZfMCExTieQTfUAljRbjEjqfDkSVYYrcFYrdZnaRirXQgfrExclDKFY",
		@"mGypPriEgxkXypyIuZjpKPLlzeJkFlwzzhwudMZUqwIGcSahBrZFgVqSFKaMDpfTvOegAdsJyckmeFEIcLkZeXvAqsjXfUGIkBWjCQfrgXVYDwPKDkGPKdTNNqHlzcfWInGeVAiHpBQVqaTEtXJj",
		@"VnOiNzElIDcGvFQweFVLEqicamAxYEUKEvocAIMTaYqDKsIQzxPUadqTSUTnGroViqCbrfrSNDCwSLYuDJgtIqJUFFJkNCnRJcJCmYejGYFRdJgFcoDWDuXPXQbxrklNkjrDDdLtNbrihs",
		@"GIxfjeDBJDLYwtuMMuJshLTTvUfULCuFIvQqwttLVhZtaHvKWZRaoqLalRskNAbCUKWBtcOGhynLYvzvZOVMGqizDWiheSXQuHzNVVLSvVjELMhZLehhYoMOEibsvWUBK",
		@"PWGqorQStSIrFYAUojilcBfRzPNZzIMUKcDSmEzCyXVoZiVFiDPMDgdBjEdhQiZSzWTIYHLpwctdiaqqOjyGWuvaVdbOKQpGkxBjCMPeuJBLqXrjkHhxGdwNFbuhUILrXEUocayxJyvwYjZ",
		@"ewCRSPkdYKCzVCUsZRkbOMOjbfqrSGykTivJFPmEMPqglDIskNwgReoztiLsiwzEZYAQAMQROJUPKqRKRqzuNRMDxruMiGBeZkYLUIGYPdlkOCJtXDNTaDQuUibHCi",
		@"oHjcgazAFwBFeOwsPhsohuBMvDvPwxgXSuwBRQBLcLHQJuQAsPVkmpIVekKpbPCnwKWmFzqVVthiQHHsDjrxivHNPcexjBicZuxpbwZmRMqxSdqKHvrrAHKNewLiBVkveLm",
		@"cHcWrVhvzlKQKJGYRcHlHBKgZyPLwyPuDAiVqeEdSaqJUpIcCeleTyfefLCGChiYvdJoMfqeFlEwIjZROuIFTmxLWsOYovDrYAnMlQTotNUfabGSqWFWhSer",
		@"xdquUCGwyMVxuxYBCXKCALiifeyDwElNBmsXQPmswTghgDLOyQRoQhzRrFyAxOVJcBiOBfvIaFlNXQGBeEOZWyHITHNhBuicZecYhzpfh",
		@"uCjYOXlbTKLGFTgcJVvOCtaOQKqpPzFbCpqobRoIODRAxCzXLjynVdWNzExbXhFUXIWwnUTmBruXuntMtlARUnwPNiIRasWpfCHPKBYPojoEONKDHvXXVREFQYWTTmsUvXvsQohIuCF",
		@"DJIJwqKyQtArVDSmEpfKyvZGlrFbhOXeQlsYIdegmpvRmGaJskzCrZEHdADUtRrmZqmjMdkesAObnKgpwbHgOwbqfVEGoMIFHPjRgioOUayGAoDtP",
		@"xENwquQuBQtVhwLOIUenYtIdgYTeAQOtVmTYmsNhAGfarXplVSrMglaMVRPsjndzuGGYUDUxOeOpuToEthPwWFEDsreKDMqAgLEILLipwwlNoaHxXpvnfnofwrUsATMVWHsfLavf",
		@"ChPtYebrLRYrJgCTgfZlSADYptYlHOjTykAJKwkThybRnJlFTylVLYwqufRLCAuNJPvvpHjZADXoSeDrRdACXGyeUnplTPCZEEftwrOojtIyCpztKiTBteedMOqs",
		@"cFkznyQwTccLtdEGFQwqgsuMYwHoMlkazsdBZlxHLvYZPkpOFtdbUfcJPvpaBkWWVhAtfdWjlNHebyhCWfQMZKXppGlDYtTboPGYbErMCvjgjeLamIWbuYquxFMhsbTvPdlewUkWztaff",
		@"FFnVskifRFfXuKiNzwllHwzIsJppwRLwaiyLEbDMuKDvpXqRniYCDximDDzHvrTFeNvYBWqbdWjNWBOatxqtcsUsERqVdvJgYEQbUqVicFq",
		@"ATAeGlTDOKhiLjTuEaIskrQKagxQLNjtDLRBjLpSzXXBYKLWlxRIrAWKHykKwbvMKFImxTvAfGNmPtAWLwZgznyWGvjWwcPWPEyQocYKbPububBBDAcwOLStikNJPiZzvw",
		@"BuaKyATjGuXVUbZvdWeIfZhbWrwMsaYxRhtXmPTdrBLkJetoygaavsGSMEzbCGECgrklYwYAIfSkfqqWgGpNGcsGEPPlNNunXYUIhhjAWnBfpfUgKxaWpSvgcfYgYdm",
		@"jypPwoMJOVDAaaDhwsOTMWWmRophAxGHxdQMUYqkbNrdllHMUUATucZCgbpyIrcHnOwCgrUzCRbPECspEIXGGRbtvtUbMRsmpIDuWvnXFQFk",
		@"iIpIkklQIcLiOMOyBJnIqakTUAAKmVcPjWLTFZaurQmoxSTmRcIXqBhzQVsAMZKmhzJZrHRyZnLKmabMdDjhXfBVVyeQCnXhRFZyxNuvKJkyEkBNEdDeLhvllxzAPYgKcCZTXQiHO",
	];
	return KqGfPYWOnCQIdisZxJY;
}

- (nonnull NSArray *)JGXtwFDYStgqcLe :(nonnull UIImage *)ZqZIxlmsCvVtLe :(nonnull NSData *)IMeDmkBqJuILy :(nonnull NSDictionary *)tAZMSSFEvDczpOzh {
	NSArray *qNbcdkbCekEUmjAhN = @[
		@"kFbrupIAhzhHlAVmAyonpVIHCnUkSKEjWwexczdiXXbyhoTmuLokEghmsCCEvGkSsOyKecdTqFuWvecRWMEBiZvFZEXIYrnYxfapnIAEUHHlVuovkFxQSADaTqJrQfjEGTGIYALjLMoTWWhf",
		@"haZbOrTrGDIzsDLBjkbGscakakCFYjOeWBPxVYZolMgtVyjLfcNYGPoIRtDepijlEVYMglKsjoyBghHqMUmZyEXKbAIbVwbQUWBwBOeuWndPFQOQbGgBWNeuxTeOZnnbGSYfXTAT",
		@"IULQgQASCdWWoykeiRfDLMZwYmahGvjjnwRoWZhFOUVTyYWSSORVoXRrZQtXOxFWSjaLCQSkYRffilMaohjUTKDmuzddisTrwmMmWdk",
		@"AyNHSyJorNEqQOSvhsupHeeKRNOQvPqxgqcrBQSLBbUOcPlJepLVbPOIVxZbdLHcRmCIsqNrdVufeaLoVuxgKeinwJSvVlzCkgGPqEiPogtVVkVafxSigeaYwufdTMGYRIItGjOnGCLlRoQk",
		@"FGdEiLomJDxMGtNicFYfnXleFywcNzjejhlqUcJvBslUsroZCCuSvulKUVphpDAitPKJIYYyHKFSntQCOOBurEySEfSdKzKJuBBaWEoVsgXjxXBVkFSxKZrGTlaLHG",
		@"bbDoMGlOGYvCDzysgOIsUTPJXfAzMtOirQdwmEZyBSUQoQegFseEzgconoSuYbFCEynSiPUIDWqXkMWGnjuuYQvAarsXSntqKOuvw",
		@"fRCARFRTDgkjfgVETcseoFeujFkzVtcGwNXfARfYxeZqvrYXVTTUaigBHUIsqCBvjMvMJKCuLLOfLYkyMrWIDFVDGfvqzZFgayMiufDlWMJSKOwrpLEXGZywnmFe",
		@"VFSnUmNFvOBnzvzQAfxPWcWbAcDnDSBJqhDpqPKfwNOAKDDSOQrKMLbtyMmOtqvoipibMiqigprTjsNqxXJTyfxHFyWiQjGCHeDXaxiWQqToqttgBLFKPDVYRe",
		@"vKvqWorjAZOolDVSYOjEEaZqOAyhMFtBRpbeAjclAKwdVIDAtPROXCiIMhYzydEajLfUoHGAbQmyQNhCsVAXAwujIcXpfYhnXzBgXHyGEmcLPjpPWlLamvVTlxJUTqYjMWZqZri",
		@"uHhslwHhnDcorAqfDFpwnMTrToxFWsAhtarTfViuPYymkAyYRGylKhtppRSYYKjdmgmHMPbOeIkwODSkWXgGkMIzNvVEqWPXrVUyJ",
		@"PpMSzOKDvDRiTPKQmwnWgiiOjizpcURiJcbGLBHBCwiOuWEaxGcOIwAoEObVpbBiMUkrntwAvmIIgRbemSuwJQNtYempOQxROUbNgbhuvMuzLFnvWSoNiURKgDpMIANAr",
		@"zsrtynaGVklTEnkNWOqEqQeLSZWmnOUrSYqVLeihkmyPLuzVfRzUmoHKZaBkXjjwVPsupzQCTaFoMrdwFAYIuaWcGJSUAuckjSujhKJkdkDtfIuDvxbSlOAQTnXALeFLBGoOsBHZZJrfr",
		@"ZwspPafZsKgbqLdiBmHBTLxxTJkOofdVhiNzmwjRDmDghQnJAvBozGhVkUpfxEwnhGmXfXgkfOXExolGESjMLIRiExsrwhxPSsvDurdFeCqLOvKjKBSVEB",
		@"ywSBswoGtTTnEpVNFnOnfBGAzoCmqOLkaSKGpOtYKNlwKiAooFHIAkVIwEdAJIePiQHpFQHTuYrsalKbcNWVwmGpbpthlrJEoNQAVPHLKeUPZwMiehRDISluZFStffVGPIQVQYHif",
		@"AsNleyjTrUekjhTKfUXksjaddXJWCsFEdvoZKLzMGKKsARxNMxguCSuibluKVCgnkwIVpottqCXjDDUmyRiwlUGtWucfBXXfQDcLGVZ",
		@"oOknyTlsHAXOySZAgVKZJgxXaHGrCKavLjELeVVnCzSEmvymzIrnjGlHaCIkcSowmULmeSqrGOXSZnPGzvXyGvpyGNgrdkeTMyHfzgLro",
	];
	return qNbcdkbCekEUmjAhN;
}

+ (nonnull NSString *)EEJKAOYGxE :(nonnull UIImage *)sAotkPWCnKFRCd {
	NSString *dxSCCnOWyzco = @"jmBaTgCIfPferwzYfRYnShbRRzHyUJswFYoLRIYNLczpVsmojnjquEfihcrXcMlcZfKAokCMCuXLqpagSwkBiMzVLuumuJoYMnuHjno";
	return dxSCCnOWyzco;
}

- (nonnull NSData *)oiSvjybMLCIbXrZwY :(nonnull NSDictionary *)msJnFkvCMzfAqpvNYZ :(nonnull NSData *)gQujKVsargyMZoNFdZ :(nonnull UIImage *)ehBtVepMGQXTnjJIs {
	NSData *sNHzItFgxpAPSDoV = [@"WLmAXOsHYSExzKshaEAbNBrHHyLFdoQCtelQwlqfaRKFCanGFkMqclKJBSpLoInKzBlZeLULtTbRujRxhUTjBKscmMDttcqshUcvQC" dataUsingEncoding:NSUTF8StringEncoding];
	return sNHzItFgxpAPSDoV;
}

+ (nonnull NSData *)vmEEMmhNESk :(nonnull NSArray *)WcafgtJpkaifn :(nonnull NSString *)oJCFKPPkfnNx {
	NSData *AcMfaYxcpOGx = [@"bOVWBhjjCTqBZwjmsEfGBDnhVHHojAoGIIYhPQwEcGNSzsaUXwaavXvmgJmAaQMkIaMmhKtPDEkGFqiyNwJZZHndRuFAoijNUVwAaWSqZLSv" dataUsingEncoding:NSUTF8StringEncoding];
	return AcMfaYxcpOGx;
}

+ (nonnull NSData *)MNaSohFihy :(nonnull NSData *)frfLpdIpiz {
	NSData *jNNyVgvSSCJLuq = [@"aHSufFalqHSDmMBZYSFpfYKPXVeqCJZhfoOjrAAURNLBdABpPibZnHTXoRkMGDWLQELxyISjLLYmJaExZFgImhcDaDhGwUNwIWOZJEKvlgkxvTTsrRrhrYvKDK" dataUsingEncoding:NSUTF8StringEncoding];
	return jNNyVgvSSCJLuq;
}

- (nonnull NSArray *)oTPjBmcfce :(nonnull NSData *)HaqowROVywckrtX :(nonnull UIImage *)lcpDFUjJynuhiuvEj {
	NSArray *vrQtFEUFRwPIHOuCy = @[
		@"ezzZgtyNGIHApmTJWdDVLFiyKRAZGiMdUEhxQNGFMYEvnBnBklyRBoxbOWoWCqLpBZCYYhvGHUamhrqXPdKWFwGCTqULCbZZspXLmUoryeCPbKZzvYRkqPkviudbiZbnKAdTBycosYl",
		@"LvAOFSJaRtPOoJkeUDkFsjBEIqUYAnNshJKisbWRcDDBannESmnfLqvqfpRcfcgeQnwvRpoNlXJjwVbMGENPHlkxmrDpQFroWULfHUcsNlQIfbeRQEFWkwPirCGrvF",
		@"vSlqfoBNfoDTEeaBEHMRFlzHsvGkfuuxBLqZVSrCFwUWYKMkyYOhcPJMduqUoKCzGatbMwoNoxIeFtpZREFzYxMlXKUWIlpleVfkEzrTIsdkshRdKWPqEBmzcIU",
		@"MHQxhYDAajikqtbUgGdcQnnxNQlBdCtTxEVOMeyjxFavKtnqqkfGReBPphWfmRUQCbLzZywKYPTgFNgVMofnwMAHQCPTxswHFBqasCUVCvgplwRZUZ",
		@"bkKnIXdZWzgQikSeKrKTZugGTqtQQqqrTvufjONrGySiYcEOymnfPyEPJAKXHsFOIHCZXtKewdSMacmUpcUQGmywFMBnPUCjSTIigKRdrEEV",
		@"IAtUBHAuoeGGQDjWSXbCoNUjyzIciSzTYDIZXqoSGacZAByyfaeegozxqMwxeccjdZYpIYtEwVybEpatkJWdeyAYujSLtoGAPXaIzPEDwzbqDzv",
		@"rJbUVhKBAhYEScYccnWDWjGJYNVqnmEexJmVMxPJLNVooCXrXWNMHJXOVYCstlKMbePjdRAdDkHVQcOiYjMDmxBcdBNSMiAFtNmthNfbokKdfgFRKrSHRJwTgTbiciZTScwbCJbtt",
		@"zXDefzEdPqLhzwOYTzgLdhalSGSHwtCfPpBKZYvtGucQHwckRivbcqGTzJEFzBJUfEqZzvpbYRmLoEVftxaMOmmDSlEpBsWNQqvLiP",
		@"odxtmNNinUupiOXbRwzsUNpNbTNflVJHVdumvYSBcPchMlerOQqzbPuHESJlIfTTJvvelLXwfycbdwFzZuWlrTBBlUdZyhgVAMvswgyTVhhBBXgOlLEuSbrHv",
		@"GaToYhXmhIpddgZRICcOKHBntluCzMjtthsHskrQbvqYTjNlJfARlmQnGUkOEiexIgqbExvACXJnbtLKYRvoOZhbioKivqrulJtpoKgufCwmCgqBBSBmSZppqLbBCzowaCZhiOfUUrR",
		@"wOLjZRSoYfiqsGqLlwBqfmZZjDUBOXhLcqmbRtTeaXqtjqQMYuDHmEVHDTsVfaKuiJEVWAajDzTPfBYRWFPYVNzjebEQIUeSbiZPCJudLNKRZMnL",
		@"pzlxzyaJqOeSiPLyngrpMaMIMEfoztQNTKIUHbXUNqhEUNZNWRzzTolGrsRfxYrgWOkHxcuPnjBxlxuqIYdLncYMffgLQYElVHcQY",
		@"kvupzgEQkMHatNccvHHUmiMQlvKfNXYvPOskewiprIxxOWEgowCQViLbOxAvOpYvIUscODfKRvRodfvbcAgLSoFysmZhixbBTzUNjwmiaELULjYodpBVUckGKnhFveEjjByGQkaroolcQsIV",
		@"zUCisApVbIsEqNFvovVGdhzleYSCYWdaFZaHXDAkbyqshXcNpKKYmzFHRAuzspomXrZnBjMvxWVSXEcpFTsbWaydAjbwaXhIwRaPRfWRUhVqGQOHoOgLQcD",
		@"GimiBGOZvUFXKcCPsIeTFHKMaGuiSEJowKjxvxeXrlsxRKWWzclAzNHndtWKatTEeTWfzmZezzNrTnCjjPaHLQrFxyMHoAOAczOQpJSyXkjDuBUY",
		@"BCDlhaCMreItWympBBLwHxLhLJHcWbBuCpVZKLGWLRHZGlZcZeLiGMLvdqGYgyICRCOcIxGqhxrOPFuTTvuWAWHeUKlZvUVPSayJvNggftgdqtyaxGgYCoLiTUlRuXSGLHeiPtZejcfjUSx",
		@"cZylwmZQRmowOnxUQIVADJMTnFjiCKshRlGKgEhrBoNNCbpllwmxpIUedKtLrKlawevOZLPnkwuBpkcYcBjIKLQBfAmmfFsCgglVYKWyTmQCzhcIiDFdHMrJcpyvSUIGSqJBHeUo",
		@"jdZwGYMmwhkNmLSNBzEORpRJWXOsGgZXiIyYLcFeKWhrnLnFytOYwzNCSvGZjYEviMhsoCfpndykfNskglyPJaJvNwPdzkcmEwrHGkNIEifAdYiQTzqtO",
		@"tiTXnFCOfflWzfHNbhCrtXnAzaNrUnheosZhFvnUaKojLmkXigWIMyaoEMFCrgNuHJykCDSbNCPrKINrEIwdgxcyBEYfHgrxOwFukgcdCbA",
	];
	return vrQtFEUFRwPIHOuCy;
}

- (nonnull NSData *)nnmEnFLrWuVXttNvSIZ :(nonnull NSString *)MlenRNMcezjRtmgYp :(nonnull UIImage *)yCograVEWNjUDfx {
	NSData *RNsxsTcXEFyIawttWXU = [@"ycrasQplGbmRufcoooRuBWjbzhkyQnBQEqsvMRprFArIBEIquHWPnMdbfdfirkkLQdpVEjhOhVeIdQZpDxKPyMxEjMfHiVhZZlYYXyQvkONgNpoCWpqfHlcTonpYMBHvVBiwjdPedggtLuQdsfZ" dataUsingEncoding:NSUTF8StringEncoding];
	return RNsxsTcXEFyIawttWXU;
}

- (nonnull NSString *)uUuzgsGAkyqtAibW :(nonnull NSData *)uOFIsNKyZO {
	NSString *bOiyUmsuGUATa = @"EWmJZXwPYBdNCTJCSdBxQgsePuznyNNdNJqctmntqCtjRdlTZLkfDuhsczfWOhWCqdEvIEOdvwPmvGmDaxVBzCmDtUbSUGyMkmUsCVaPnjP";
	return bOiyUmsuGUATa;
}

- (nonnull UIImage *)cLykPyJxrCkiR :(nonnull NSDictionary *)eobeloRdHiqfu :(nonnull NSDictionary *)xzeteqMMfXPGjYJzcL :(nonnull NSString *)TkMjJuubvucqhNdT {
	NSData *OPPRNHuWwMzgbe = [@"nkBQmZnWOVSEyPVYwpngcEHLJksnkeRGaPAxriJkJBuVoNuVkCIvFfTGrAMGkEaaSAUfOuEcGrKNNNascbxGyFWRasJXUnbRFxEQhdFMXxJSpSI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *YuOrabHIFccQcZY = [UIImage imageWithData:OPPRNHuWwMzgbe];
	YuOrabHIFccQcZY = [UIImage imageNamed:@"ZQfRutcqQnLUBfqTQaYjHIvQDbZPiXksYKMSTZtUqHKjwfWkNpDTuXCXPBuiqfgHiiSCXnxikRDSzEdzZanNCSJGqAyJwNGygccHToAEPZyVvDAYQGmoZ"];
	return YuOrabHIFccQcZY;
}

- (nonnull NSArray *)dvthKKAfAF :(nonnull NSDictionary *)lbphrZAnzlPWVAR :(nonnull NSArray *)rkeyvJogwZhNxRa {
	NSArray *CLGwpOkBmSmjEXGuzn = @[
		@"wFnOJWEzSeCjrrCGVvGvdMHcxguUScwWOmBPleGCcaksrNsrHiTWYHsBsCMuGKzprNTufbAFyqpUgNCAtjMHmvOXjXYGYlWKBtjcThuCDuGSRfwcAauyCVxcUbFZLuoUJKGnJMmCYlybxDqiTxQCs",
		@"bmeKEaIWtQDFnzSSfSuehLVWaEIWcYhKpfJSOrUkcbJBbbVNnlRwQplMxtcruVxObnjLfpiJmepqcKMoNszejLOGZvmcARKyZRLpoQGXcDEkQPkGyVMQcNdKQjPiCtFTFXTmRBHWnpIVE",
		@"ryfnLxPZeQjRIPqeAuZNJwguhEeKdToCTXtKhNQGawRpCPLUUZJbMZPkflTmzOwZYcRSKgfHXbmlujthqrznyrEEEMksYdmQQEhliMPFmERbOuXrptHFaWfPommr",
		@"YxOPhiBNEsAMkcivcapkxzSuuDEgGnZqozzWtlGVofOMYZICLmgpeoHlLoECQSgfAidSXsIppjAwyfDSqiBYYfbcAhbUSNJbqdsMmISAEqktlDrizumYHbwpwoeVVRIstMmbPPttcb",
		@"LmtyXesYsFbJaDvSBbuaLvdlvashpzNRBTDdrgrxPbjbwBRXoSKwJthNDSuZWlNcyFLqSVAyqrViKYjAvuRakYjoqThkFCeWggrUZbMJDsLaTjsdMSpaKsQtgjDPTicypyykmTAtS",
		@"wbLyrjXejAkfsVpfXAZMswtKAoPdfJrGRslSByRIaSsvcyNSjexnbHBIFBwhkRlPkYRIcFGIYcaKtDAHeiiHRtVLTweDGfuxPHJCSTNNcEueJpDKnpaswOjnKaQImBWtiafrHpv",
		@"mEEFSsKZsGtvaaXMeBKOOvzgMFVEVrtlzbaYjCHltcLPpyoJBZhPbzWvtVhSRLgtpnpRBJWQuELcsnTOVqTMeiDakySVXGaZyKFO",
		@"xxJQZiPHMVrknySPWssPKeSZAbxfZFjwSJkrsqsUZZjpnbFbWeldcmSbycoWTPBbNUKKtDjplsDGndDpEGrflKjlQDNVlXMetJGHlcwoHOHosgBzQYGDuUEYy",
		@"oPWQpZCXfpreMsxXjPllfSqnPPhzANmBCYZGBNtOoMQfmqkGgwTneNHBshlEgxpPNaPIYHyBCNYbqlmXHENjtYzxvTrdrmLdQnYkkWumkIRkdBIoZnzfeFvtTpAYUElMpCArhFj",
		@"fJYCtBiVdKXhVzLMCDwImhGsbuNffvfvPSbQpaiYtBeHHunCMumVGvckNkFNbjmaRcPYuwGenjADDLoawkYYYLBzZPylIbOoXMhXFDaIcSbJuQTnDndeiAEUDIoVbiYkgIOXqVlHLmEs",
		@"ueTpXRukcHJJqncprfepcLSaRhfzAkgCCnqOMgwkTOZCpUEdTKmCxRugrtixVjKqdGfubFVVtOpcJOTWhHMRJSWSHFYgULIlPjGdkkgaubTLEDKEfqujIKPUuEVc",
		@"AyJqghEBsIyRMbZtbBgoFUwnHPzSRPtRhaDbIuunuxkRNpYPejeqhcOWqxzeQFiwXlLEgKTBCMaoVKBYsrGBsuZVbdtLHANdYeunRWsyPsWNDxvtGIdrDAGCCwjBZmhjAWJXbu",
		@"dOnsetHwNjWjRiWikNvuHQgoGQHeUdlohvGdVBZzihjRYSLDpanJeCttretcnWZbdzzZIuxvCkrJpjCsCUaHozJzzjXpdbihwSAJAxSwR",
		@"ekPkwiZCMUohAeYZsTnbfOGUanIzpdDLEcqkGxwmjXqdLhRAqDqkBNOuGKeGosEXfJAMWKrvUROJHHYchAbOHzadgImLyLFKCSMRSMQINgxLvAckxXscIabXpMosECZngpwSvUc",
		@"qWjfMrXVEEjyQMaQhaYoIlpxsqXvjpWEkJVngcavIrIjtbVWkbLuveyRpoHDHhrRQofLZYiqrEDJSkshcSQhGMqFzjTSRyrCpiaKnzWBqKVOALNkAKxHQnOrsFtKBiUqLoEeXNWWpgysgdhiOgc",
		@"QAmMkKFaiyMfkUrNWBiuojlSOqNXvRzNTpmZMWuDcZmjNETVpzCefKXDAsfrjzzliJcjRhRCSFMHUfHRqvKufvZIfRBrnDpDLocUMeeURNckfLR",
		@"TwKhmnmgjrsaqNyKvahNHVTFOjJNTZgvMpjWIpbbIxMPrtdUVZLfEejLVymtdUIwEDJMEodwYwnDbUMPNQsbUilyiOTlELPjBZVmRshXjTXjcDCOfxMnbzAkobRV",
		@"AHxqgzAnnDezLDOUFYNttWizDaSTnPxqprUvPRXBujTdstlJddqXhLwxliCZviKgzpIWWUOVKjdKtFdmkhmrzGhNwukbSFzRmDZHTfecbZusPjNQpxUYEKREgiRU",
	];
	return CLGwpOkBmSmjEXGuzn;
}

+ (nonnull NSString *)OuVlnObmNeSY :(nonnull NSDictionary *)LAimUkfKWuima :(nonnull UIImage *)kUuaadgdNZly {
	NSString *NbwaWKZgvWyT = @"zvIrGeeYrBEqzxRHrTMymrftpFJbPyzHHqPpjRsXrXJMNPSdMaaMfNxICbOWocvTXEsjzPbFrNUkGXEiIOgHoUwhvalnzjcBTAAiUFxjoZKkkgXRRcIxVCuYlgmXJTRpJhdrUztDJUJoAjhnhW";
	return NbwaWKZgvWyT;
}

- (nonnull NSData *)svTKQcTQJUwQRE :(nonnull NSDictionary *)jNKvznAXHzjETl :(nonnull UIImage *)YjWHHTivkQIW :(nonnull NSArray *)yRccoRBLJBzKznjqKi {
	NSData *BsrgHAsxyYmxcSohIs = [@"FoEwPkujTUwqLXSPuoRHYIjWXLbiBnKcNcoJbmzeCiVCWErIYWKEcRTLhSmVggRLCGhGpvuwmCSeqpBVFtQOcxOlIrxemKYCtXiojD" dataUsingEncoding:NSUTF8StringEncoding];
	return BsrgHAsxyYmxcSohIs;
}

- (nonnull NSString *)xdFMOVUNkvr :(nonnull UIImage *)riaBdIoCqSDKldaiVDo :(nonnull NSString *)taRlNCCRzCkhEbjAh :(nonnull NSArray *)jOXSHXqbknDmbwp {
	NSString *BEWCobyDRScb = @"nqhTWjpLPAbMVgCSwAtZRTxOcyxbKvDPGdxqtXwlTfAHUBwDFdMEdLSqpNobAFBJdknoUfACrtPMmpQKhPpIFwKHuIlaCHzoeyfuvmZXxILBfqJZiwegUbnNhQaNVAhXWkllt";
	return BEWCobyDRScb;
}

+ (nonnull UIImage *)WFDaojxVTeWJbGlTVM :(nonnull UIImage *)RlEkDaXwPzuHYQOM {
	NSData *vkhwJAKbOIsJLNvfOhz = [@"rBVMURYYLAjMqDGwGppDWAJDoMileEGZMROCTXjjGeYRYPOoQzBeYcQAiaAshqmxrMYnGLLkBNqlSYzGKhJMtYBkdfqlBlzNJGsybCfdjJSbZDexTwXpeNoveqelEBORskSidrQg" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *dIvLzlOLPsWMwGcs = [UIImage imageWithData:vkhwJAKbOIsJLNvfOhz];
	dIvLzlOLPsWMwGcs = [UIImage imageNamed:@"CHuQKxTLZpAHCbVMyAQZKwfGRygeChRXnURizFAijDmbhRASkQLDKKnWwVtfLoFpAvISzFifrvgcXtEpXEjpkXZosEDpWwMXnifwFSeyUEgeEKDdkJtDppfgUCBNgvnGbmSHnIqsrswjfjG"];
	return dIvLzlOLPsWMwGcs;
}

- (nonnull NSDictionary *)jlOVMSCcnl :(nonnull UIImage *)WWubaAhBOf :(nonnull UIImage *)KkTzzUqzavKADTPcixp {
	NSDictionary *QfxbRSkHZuq = @{
		@"qNsKFJpZTkjkUVUs": @"grUsRzUaTuwoGiILekEJqAxTaUDJibphKRElUjkdEQiASYEpnCGhLXIGNrpyrhnSiHUxsmWMNhRRgTGdkbhkOyYSLvdfjCfiscUVEiCgRmbNvKUYgqWqFaEJCrVeqPURRjswEWm",
		@"OMADbjjgyDjfT": @"OUiuSmBWidEpomMGUDplTZAQFfzcwiGUMRpNWQLoDbGLbJbUvnxVshTcXhoLKItIbfkwfBBkoNCIReZQRyhcoRYOFiYFfYixFzRCkeRWvLFviYOepHbxsiKxVlnRuhUTGXVRWxMXE",
		@"McNlbzKeqfvT": @"EkSXeysvUlNbGtZUQlSLclrpOmfrGpHzlYDkCKkKzDiALokWOXpXVBvnFffiQgUyUmMgfTyprJDgyyGChDZuzdWrDWvVMLKmTmqJdCcXzcnunjmxtibYYQoehYISiKTBjccvJxNxQRpiY",
		@"srdPGbRPkRYfMO": @"RiTLVPRvBEtsaBbvKhnIrPpxEVrdQuLburaImpSwiZUJbyyJlRYbrwLBJzVFwNLBusqXORLHrVemsbFeBCvESsFJbVmzSGkoyCFdxuEVU",
		@"tshbICajCylRLRRsdoe": @"VykhlDnyBHuIJQfhNmKwEdoGNRjptZgQONMAtzNpERGfVCvKiKuIqWuwPJbcTWLKuQgSrAZONRZZaLMVBpkpmTUDbaTABHsymloSy",
		@"xuPUaswPmVcZnrChNS": @"BnlWIDUiDcYkPtVfvhQDrNWklDeHIwJZmrpbYHdnFgmXGlFxdlYGcEFznKoVRWnjOIEpypQdijJmwRktOlctlDQuFelgoljujJnmwaYfJaTspfWLVxHbcdXd",
		@"NVFEGhhDxI": @"jtCoSqQTBHscaDAkOgOBLrZmmHsiOOlWCmyAdfeIwxxUHUmEhUkJoCOLJhtNHGTpAxTqQsdigREPjSLASmhDECErZdxldCoVKEUnfPqYpZPHlMZhz",
		@"MiKCcKETDewGPGFNpu": @"WbRcRzLNxHFfeMUJSBDEBpwIkwXUlyaQSzhnFNLiuofdSpgGCiXyOQWYthzJtgWQdKnZfyRYDwuanFrjRxyJpycuHmdsnWecqMoJfgIYjlvVIBlzxcNkaNPAlpVdzLcg",
		@"KIUmThaHEXnT": @"ysauVlGppipUCZUhVgeZDsBglrsltBgxrrrsHvzbReOKUyEspYkvZKjHbEcplTwNIBryKuqDxeJBBDGwnoCwvVzsgRoJRfJPufBoDWSduxokzIJPkvDSSVoyziROuAe",
		@"UnNJWZCywpghJcT": @"NDziUAQwTAGfLJEdnlsAOfmoTVlNoXWjpJwtdnEjPCZlWNLTsVcxWtNltTpWgzAtKpXfYGPYyksfcDMBLkOPSTKrWyzbhmDSECPFhvefLPctHBTymNHsXvnOmvpYg",
		@"uaXytGTcEgFifl": @"LPWWoYyKwwNPmvkbxLzJnlWbOEtPVOjZJBywQKSySZpYtalSDDrvzlYSFTpGriZlMobXNJgVyJLLjlXFvAaAYidUtcASWgKjzjHmJpKFuHwuGctMtDLLzRIfpSBBETh",
		@"KSJKARnJair": @"lDGoEQiJebLvNRtEPcENmcXnwazqqoSqShrjNWBPNXMEhvoqcSVqqtbsvNTcuOBLieVJTZYJZBvoIAtQYlVBhHITMPwLJXRkfSBWj",
		@"QXlRcStFzQJyUnwb": @"xvUsEKgilCPoHGQEOzGplBGoujPhBzttBmMcxCXRmkYSrhCTUuFRKFrhLEqMDHfyMoHkoirZKIQTefGapokNhcTDaQLGFjrDYbSsbCUqNdsSyuceWEqGkxTvmdigJStF",
		@"XCmdcOuPHNVD": @"imxISqWDbCNHCAbyOhimOHQAZxaNLkrgjUuMoMMsFdnhKtDfQTZorPgJhwPRMSqRihUrpABFPAvoLghIEGUlBhoHhsHcykNhZfpDA",
		@"SUZUBJJTZlJm": @"fDQtFgTdNSFRjOGvxnIJtgWotuGfWddDZkUCiHRImrmPUPlSvwkcwZjdbDjOzXOEHOpebpFfcuZOgFaYTNshOYVVBcjjTmtSCHcbMktTksQldaHrLjwPeVmAPLHm",
		@"xnpJHDwklKxdaTJ": @"ZUheqJUsaRjvupftnJnglKRSSMjSMLZWClQainWpsixqatbDYjAKWVklaAPZQHBJeoIrgWPToPFuGOwkSIrfExfyQYHsXOWHMcpxTfz",
	};
	return QfxbRSkHZuq;
}

- (nonnull NSData *)QyYBqraZFPVBkV :(nonnull NSData *)YcMNWebpJCW :(nonnull NSData *)UPyODazxrIUFuMgEU {
	NSData *QyceAYZdVacSRrCO = [@"jQYiFHsyvCPGKrPWmFPSaWZspmFGGAhlZcmuoeOmYYNBzAShqYJoAGwsIdXjMRhSqOUzZGteEXYYaGZRkqCeHMRtSUDaVGSFlPjPC" dataUsingEncoding:NSUTF8StringEncoding];
	return QyceAYZdVacSRrCO;
}

- (nonnull NSString *)UemhwiEtxQOb :(nonnull NSDictionary *)vUGtoSxgvj {
	NSString *riEgZeeKhBbTyV = @"mToHZuLMnUcvTTjRnzOXJnbCjDSPcLpbtpqWYVUulmODShKyfmiongGElbqvFTVVLhiiaLGwcHADXMqieUaxEiXwNBbwczzkjRhuSHmxPHMEtJKGDbLRLftQwSOQh";
	return riEgZeeKhBbTyV;
}

+ (nonnull NSString *)vCyngQsSyA :(nonnull NSDictionary *)leElHdJfEGmsO :(nonnull NSString *)qXMvIhkFayZbn :(nonnull NSData *)OtXQFpXhkeLZodbmt {
	NSString *vPlZgXriYtbRo = @"YNmnvbDTuwEmDozcjjaLwvIlDbpYpoziPgiSyHEfhkCqowORCFJDMlVeFbNDnfZuLMWwjGoBWjMalCMVxegyWzpzCjOepzOOFSYtWCMHYTHgCEWZS";
	return vPlZgXriYtbRo;
}

+ (nonnull NSData *)KtUDLGvXutJxakla :(nonnull NSString *)LgHbfovsXjmwAlcdzTr {
	NSData *GInitWmKDBeaIZdOUrM = [@"maZESphxRkydnxqFIKxHKSrnpyTZNcHbPmbOKsWUBYbHanKXJhVmiYqcuHcOJsVXuOaypEbHLeHSHcxUsBPylcAdICXqplTsuaWdhHDrDBwapXDGHRhDbzMyRyDOvcaLkFzJPLfyVuuXSUo" dataUsingEncoding:NSUTF8StringEncoding];
	return GInitWmKDBeaIZdOUrM;
}

- (nonnull NSDictionary *)LhhJClzfvHGRfQZVb :(nonnull NSArray *)xpzTwrdDFkVMseAZdCm {
	NSDictionary *ezCBlrEocxDYHuqUK = @{
		@"PzlmBHNJCabjAtYN": @"GYUXVHTPholpEBLbmaTBTAcwHSujodRQhjnFVsHsLEbkwdnDCWyUgDlvcPSvPYDaffikivxbASwRjJeJFbWOzhBgEEdiHXSRrjXGghsSbnfSoGcazlBtCpfaTseOyoQymPAAI",
		@"MQSTmZmjKYIphxRhACy": @"SPtsKaiWOJSjHPtrbKDEsFpCXnNdlWmfXWEfWDMHsyYzYQVrZSCanTeGaKGutBiVEJAwgxYABEpmVvSxHphOyWqfNyIZdDBDfZQUebJG",
		@"SXNXPbcaEdN": @"SuTuhtdDXQTsskaYsQXxJhjssDRUvPqzLJIIXWdbmqDfwaIlfhncVALCJJTpnJkosJzzWBPhXrLjHFTitkojTpnUraKhVCbSOWPLrYnKzIvdByIQbhTJKoNYWNdhsnUymx",
		@"UnjXLnNcAt": @"pRSBojRKGbZUTdYmdpAcoLFjJExbtZpVLBxuRYlHfozTdTsMepQQttUZrjvtBkwYdCTyHwzuciXfPsBGRpBcKFBzJJXVUJPMOngDxcvDCNiRoEHg",
		@"JucaIYNLoUJulriVgzJ": @"JEUMnWlIRVyPShUfcZMXqzruIKDnCFhJtDyTtoIpOGyANaAKJzgToNLvLbQNASgshPSEBQembpexuDTtUCNGFqSaCVrgQRCPwIiKqVIYclNkBNfUrMnhQlohhaUbFPztwZpIyezyRvWB",
		@"SYiDAVmVTm": @"KWGnNiSGUvvIFTnasNUnIwPuyjqCUrjQVhXhEXwqEnrkffQjBGDjgGAXFNcwMKSpJWrEWwhlDENylRNAAVMRCaTAGNeFcWFfsewqEpkRLoBeGYKPioKLyUBZmSnzyVeuGbbdWzCNHzQ",
		@"LhweFrjlLYFeI": @"htpGipGOxwUqjPdbXcVpSBeoQTZomEYWAUtNfrHogcqjFvbOnijUrKUyufZzogkzXDixyewKZsxmqszmGAoxbmCLPqyOoIBhhIJzM",
		@"cOTjNxhrFivsJzSy": @"ZRBbauVYLOkYVQwzWoRCQzXaSKVvgXNYxvcjMnuyvKPBrnTHvQbvwxZsxNkGLOaYpHiTPzthYznnzOUnGjDkrsQdsTBLKJFapCngMyuemrSNOopPoxzVhssLBFVHoiHfqPQNItBFrtvLTISukH",
		@"GwYDhSoTwVztH": @"XRiTgPqzcSZjSRDRYedWibQtxresvJwxYZvuzkPgsCTlFWVonuTMgXEWDKMKPjMjecJsXPKIAfikbHnKZnKxQxmbgKvTbaPHqZPzNRLEYgk",
		@"CCtZXtPUGWbCKv": @"pDIvvMuIHiVfeomEuuSbskOvKFJKXVSbfYRECwuTcFfLreHCfSRqDXYxpxRkSlzzZhTxCEHXUIXzpTKedsRFmdEisFWGhGszzQEFwkJRohHbdvqIWoTIAAHDxlWYu",
		@"aFcrscMpJfFLAGEaVq": @"ButZYOodLLmXXLhHWVIYjcAFNOtFiQvWQiELUXeUtopWDoCxyHukDJRCTDgpdNGAcKPTUhpKQfeouzTcCKerztSLTkiyohifNFio",
		@"TlArcFIeRI": @"alHJMTJomlzIlFLIvrVqpEyaxOwmJdHiowoWfponrUscoygEnyASEcUKOHGbhPCbFWnNMExcPmERfsJeCqhboMTcMZFuhGzXUqQOXFVKXclhmgKFPEaBkSIGaocOjfIYgAY",
		@"kZBQQTmerFbqWRcEt": @"XhzvfMFqFzBYpeIKQhGmEqJPJTNUWMGbLnrHiucpBNaYcprvLtdImrFecuqTACQYGYVndDOBJztDxvXvYvvAhONgoFPkTZQZHFoWLiUbHVRPjFJxzROhAlylSNihGjiEGxar",
	};
	return ezCBlrEocxDYHuqUK;
}

- (nonnull NSData *)LTRCIqMsQVWkaHjoyuj :(nonnull NSString *)srjDqiFuIdZuMDBlPq :(nonnull NSData *)kpntGjLCeqrRB {
	NSData *WIhNXLzjXVyBBO = [@"nNShRPlAMrUeqbUBNwrIWuHaGUhdvsmFvWOaodHaCXmfgJVoFSoAIGKHwrpukGNeqwYvtdUackLSuYkfXtcedeKbSAgxpeUTeYNeGoMQoEYclOnprmdRwYBrqjyEPqUqGIOcFzptprBJPeZTXRmQ" dataUsingEncoding:NSUTF8StringEncoding];
	return WIhNXLzjXVyBBO;
}

- (nonnull NSData *)cSSaVDSPNkKFCyAYVi :(nonnull UIImage *)WmsEptnVDqDoHXxPn :(nonnull UIImage *)qOStXZtaCCXKXg :(nonnull NSArray *)hHcHMRWcBMubABYm {
	NSData *fjZnhItzEYBr = [@"lCxESSodfoTufmcdNUmxJnqiIRIsBcaPsHILyiPBwIjjnDBdxcWnjtCPTqajTROsKNDhpevpkUYveDwOkNuYWLYtuNVIVksLLayjfbITwHQfNxFQzjcdFzEBJkTUkOzhkMVZFGafpXwkWvnMJ" dataUsingEncoding:NSUTF8StringEncoding];
	return fjZnhItzEYBr;
}

- (nonnull NSArray *)caGxGSvPcFKzyLoJEz :(nonnull UIImage *)aULpAvqCrRz {
	NSArray *XvDBQrdUpWxCCNW = @[
		@"ARWoMFpDclGCsYIQoVUSyQdOzyTuNJhkbrZTSOYwzeGrhbCVyErhnfIwJYduKOdVErpekWfHGZjMeDfZwMGBjweKytMxRoLkcWNcevveKjvpWWCHNWcPBubORunRGvyHAECnxWJkv",
		@"jbWrJQjxFicRWiuUncZMMgbuHCMdetjxkCeBzwBPaFYEOgEDSqzZTxXNveiHZKtqSCAyumQblyzYgZXzlpXylVDtQbSXzENNOAFMpyuGVrYgRCJw",
		@"oJDahUhZDnzlqNpTwZtoUEvxXhmnzGfDshKcJWpgOiyUBRwdZJeJtnelUKkIdpedVhFvnrTzdMopilzJgBIPCbjrHconyNxPDMgtBDYZIhiepkzyvUhnBHrqnAWffNyseoWqy",
		@"XhOrafTOYWTtVlfMOwZAXwkjgqmURyNwCKIRIMgRHIzxPTqImvqjNymaQQsAbcBawIfBgrReCIetLqGDUwKBznqFAYsskdtLzrqKjVthJjgOdYrYnLt",
		@"nUReRHZUAzOfoHYFvcVUycKpsaPnmkbdAuVShetDDPmqaRhnTmCWbWcogJlciqFLenrmlcBWsOqbXqMzfNtKFCGuPIIEdaoMijyGKJIwMNWPSlAGFkQQ",
		@"NpbSULgmKEaONXDwJnZNIiVfPSHCZiYNtPvKsjRjfOAdDiYzzLRYSspBhNXosYwLcFZTTXaTGRXoruVhNXoLApiKVUEzqrFTeXLsYusyefeKyaWrobScagpFdTuczpOaKwrWrkaNOdXjGYjovD",
		@"kmrivfjyPnOKsFGJBqQFxrKTJTpepCdallfUVOzilsYhMEEHUPLpzsBoxZfPckZFBZvrwpiZdKVUsJLYLQLIedixNxkKkBBcWmNsXqpGOYYFrkxAfTsxvdGdVtJma",
		@"BDjdPmRKDHschoQpoqWkcxLLJHUxYbuiDWqMvztElbrNNbIPHcMPibxKqKzIIjGFPndMxJqnFxCOAZmFFDLiFexIUhlkOdxAqeXwhtsAexIkElRDWsu",
		@"WxYTzFnBSafyrRzeCyJdrdbbFAJgrYUvBPLlsKXWqXdelSeZwhZEJEVUuohaDstwlFqtsrTrXoWJYUFXbZGlciULBjcKVitJiVthDboSnnTlpqtkIrvHrntXhvJPMopStkBeqIfAOrHcYsYDhHe",
		@"XkCBzBUFJHmDWVjSkOUxkHPFSSMXFEfMiRpJkbgrmjROvrhxDqhSbfefInusXCOtkkaMoeJJKvyzcyzBjxkNQDaJfqewLrPkBNNtqzrpDCizjiqegNJX",
		@"faFcSDocJhEnKyySzZFUDXmhGCeGyFREOHctzyvJKjnLXvPpqtlHFxBBHqdgeVnuUYUiqdGEsVhvfsjIvDCQeOsfdRxFBLLjjfBULtoYnouIylkBDJFrYeqrsZtmfpBYdAQzWwLpbXDCXXxxRmO",
		@"CYvBLGIeyoUPCdzixsODIywnUldsnyvsfRoqpyrMnWLxNUWbCSLMfuJELOCoKKcbqIvuJeDSlxAanLyfzKVAdYPkHoqzragTHLeRgdoJHspqVYLKWP",
		@"SWJmpRhhZINrqDErZbqHXluSfKWlKgKgkSWkkajbXoIUwSsrgxgwKwdRDDghVFeRJQeAmFribTivKJnZaZroOocmTcAKVWtmQlhrcNijZFRcrItGsXnwHV",
		@"SNhPynVHqaNNUUPkExPiaoyjfgCPEIMYgNDWXTEgtJJhaAfthvfuBrLpcKpQDcEtAXKRnkFfJxvHiGAZwwLUjumiEJmNUKMuBUbaUWEGChFfJR",
		@"MkTZCmhCbtmcdrpusqGWuufldlzcmvfxRqEmNXAQpDJXkaxmHKVHXXPJMornnbfUcDqjTeiIHFtrTGhBxNtoYXtiluTygzOlYGfNuhLOI",
	];
	return XvDBQrdUpWxCCNW;
}

- (nonnull NSString *)mBycHLuXOMk :(nonnull NSString *)VbzuleqfRPFgXNvgu {
	NSString *SGilPEneQyOxMO = @"ZhadxrLvlszgNDfUMMNveRBhiRqUapIKtiCQswiCKDBqTwiIwUNIkwkpLFjfFpHpjqsOxlCWselDZCYxWNqMcrwnRRQNjGWGqqZGvZLMkAyjpsGCwXgPIyCRelyjJfbZeebyzvBnc";
	return SGilPEneQyOxMO;
}

+ (nonnull NSArray *)bnbiDXcVtNQny :(nonnull NSString *)EtaRlSCYofs {
	NSArray *djPPWZFPDLaWLjtZ = @[
		@"RCsfJDDNYwBjKsMyvUqEqvIDddNwJTIlbBrNLpOAQTUMEaOQcWNYYcnNccndTITLrgutuQfKKDabPTPvJcxweUhZvPLxGLcYZIvKxUTqjNEUqLxtVPRKuuvM",
		@"nUJTSCkCuaXRWHgeasvJTIjeuMPIXVjeVtaZjenvubVJUIrKJeyRaAtiSvIeicsiTcGbPkABEODwMdpgRGkSgfoBQtcGpNKIfJMHZTQnq",
		@"DwAFXhfFkVeOBIpphnfVstzeqgvrVLfRBzqWzuhfjFldofVhWGEWGsBXXrkTWkOBMXCnskxjagVYgyaojrjihcsTdWvfZReQIOwpYcxZGAyUqsBtpHvZKTHBCFdwN",
		@"aBQYcTxiJUCftxPWcslUdFobeMwfKyVzvTQYeVXAHixyzlCFVrkvdlSbaczIYwKwXcfgYqqTcyMYSjWijcUpruOTERrEJpGFdgolCFhuaOVuMSgKARMLpmKNlDQRaac",
		@"yFYRSaSvHTDuHHFGwDMBTOyatPsBUxiRDMlvMOyqojsrztyMLKHwrFbRnjEtmtivrQCAHAopgjBulHBFbwIozqzyOOSQxgVYEiSPLGbLSZTOnOTNJQAOcFKoChMGHZLjPeCXTCEKvmtVRSR",
		@"ntVKlFaARiswbfmPJuReiVNohIkDBncpFybGsbFPxJDKZOkRVXKaqZSwIryoxCIqNOAqebcoKuZeBHpFGpwPIzyujFxgXwQdLQMwuYIVLcZkOwKCpImcffdefJxZIBNQSIbnip",
		@"EyIMqNoZjNoKwtEWvsUJlIBTWHOzhUcueMRWjJuCJIkKdOhaIVHTGXgfRQeqLioxKZPjNoKgwiTEafwiVsWUwjKvHYNzUDxOgNPpFuRgikvMCymwwulIXysteevnmdDvA",
		@"KCzLElMfRKYBfPSmQnypYXzCAUoPmMEZledsyNoVlKHmVKGMVTSLCsFmvsDsuhGpQdxaHhXaXpRQaIokiMNAMugWNVSSkDLSzYbHgNtKDMZowMDnOKUhp",
		@"MFzqoIpURIDbMJvCGRUbGzSeYZsPpBqaWejDVCITCFgVbqeDtnlIouKIYZnBAyKAyDjTfXQkWBVhnIVsNjyMTGKgnjurfIMWRDryYzZhFvwvKRNWHDUhfQUHzRwGmAnOKFQGjZQpRxsqO",
		@"ZXatNPIKvbsqJrQYrREgTuzDJrmHhCbHYgpKAZhzGLOpgWaOZCeWLHKKJtngTfZsmilsNXKblwGzESAPybuQgdemUWSLIDvKrRRuuZMAenVGqYhzXNKTCYnxhaleiXoxnewC",
		@"zFqPKJaZUvtjctjTgRZySlBNHAZMldkTYGTYTPQqWpdSRMcKJyEReRYMDqKpiPGwKoHcixwuWbeoVxsBXVACyAPFLbxLsQyYnKrrYfLmvXkik",
		@"YBHxILPISHgIvhotArbeswUlvFsefkeqqXubCFiIJPHJuKGEHwcYuqgYmDbNLFbDQbSZIyaLSIDfRqXiLobyAiyMlndocLsriENXAvOXoVOhxwlZgKeheOEzEXZkpzRKYWNzgxX",
		@"KZwOIOHcbGJAgUNXrOvWTvCebSoiDNWvVURvuwUNsuaXzEkaMEdzpjcLdJYmXbcSnfPqUoVoiZwyAhhYUiHVfysgPLjJOBKdTjqBWuvzSnvfvDVUjSaS",
		@"BPmbNwsmjXKcYqCAPiyoWPyoitrWgiOOSmMQkjLzPDhbHynAeGGeeePoedtFewvCTGgXLeCUwEcHcuUTcbyasVZOdcQIysVhrOZZGhLofjXzshi",
		@"mSpsrkdOStOcFuaIWfaTZXORpwvxpGTRgIEOsDIznvAYTcJTMlmfcyGIVgYeXCASqBKaSFaunVXsSQdVUHVmfMvwYbsZUYcuwfbdIYhMPpMqMoRVNLCalPPm",
	];
	return djPPWZFPDLaWLjtZ;
}

+ (nonnull NSString *)xyULAOZKgTYN :(nonnull NSString *)xQrzZOpUEFOUKSsy :(nonnull NSString *)qyGbtIkOvssBMo :(nonnull NSArray *)lExOpLMWfRXjTWMCzj {
	NSString *YFuGWiCOFVvJANJt = @"kfKWxUveqLXOgZBqnYQaMFFYGHByGtEuNkjdSSPKGrBGSvYgbFOxFOfkJYjFotroaCEprJJUsBrsfQOfMAJLizZtsezewlzhTgtfKwwXShE";
	return YFuGWiCOFVvJANJt;
}

- (nonnull NSString *)suuKfWkFtBABr :(nonnull NSString *)CauynDmYocjJ :(nonnull NSString *)ncveUmiwbTtgtS :(nonnull UIImage *)pdyHhTJdTEelrwGxd {
	NSString *LBCRRQoWMXWlbxg = @"yrFDdAiaQXOMFUmQLASmqXinGzrMfYFxcHSxwLlctdCfWOiuBgqLrfKAgnYwdZnsWyCgIEcOjLkYchVesUtGwCjtIMKHRXXILtAsEo";
	return LBCRRQoWMXWlbxg;
}

- (nonnull NSData *)uhFKHUtdpATTAtmT :(nonnull NSArray *)stuurBlSChJqIIbrr {
	NSData *WgyhmkwZZWt = [@"TazQnYbfARtBZnfeEhJrXZwgHVGZjMGFiSeQgNPynABYjyPxCfiFhTMDbZQvEMwlujLLIJHEoRpDvwSRgNegJoFfGEwBSaJwNoBOHNmHxSaZNmCbPXOAqgBpaRxoCqQqISDIn" dataUsingEncoding:NSUTF8StringEncoding];
	return WgyhmkwZZWt;
}

- (nonnull NSDictionary *)JNAwWvAxPYj :(nonnull NSString *)WmfMCCTVYLTfQj :(nonnull NSDictionary *)rUBlMJykBUJyE {
	NSDictionary *UWKBoKfOxhkMxR = @{
		@"XmzHlhubEFRXmgPkveH": @"PBXzUBgxxiUxImQcAfeyDLIIcEkXJPpXZZRMFJuREkfxRVVmPPxwoVlLcebqSfjGxBpacOWzqXBqMGkncmExXepQzObPiTcGOaJBTFhAZCEbghTgPNuXfimlLZpSismzsRFEgQwevco",
		@"NThffQnKNmNjfRD": @"GpkCXbbBcuSGNkQajNoQJsSrpGurVGlQJeGciHFOohwseqaNCOwCSNsKjmTwxmXDftEfNaunNBuUtkcYfneiFngXbrdZjgyFodXeMPUusgNkHCLyxxKbcXBpGaRxHGZwiSqyxEtVKLVqjaIea",
		@"ROfqAriebwWBrYGr": @"JrlbharRKWcDnddmUlJmPmqjPwtxkqtSBhASoTzoQpQaqavwcHNokwLwKzZFtzeEhPsuMcBRTKiEWWUuEkjJFdPouBRYPvpSVcUkePIwAM",
		@"tVgNXQodysEPQ": @"VkQUWUzhtDmQOKyeTGmGPefjzGerKqNKVKXOLtIOwEktGvXnaEvwUwKqAbUyThsGXEyAodRDEbhmfOrKxtLHdFhrgxRkAeOJmAZYHdgOZUexHEvhnIPJedwLtcOOnFPNzECCfgPFGJkRDOouHSXT",
		@"HJQQlMaBgbQqfrxYv": @"cFJxHJtzzrJlIixZWrChChzhfiNdpXzDxFECVNJEjvDwWwoWNriipmJFKzNfpftyluLeKkwhTTqXXuSbfZTvHUntMkUaxdtMcAnJHBJkSrnuioWYRpWZXsGtRRFQZohNCANrdMABnbUR",
		@"ixNVtgAijCWHqZktcyy": @"VSSSwKVAHrurICsjvvAqvJiUavCIDbUcWZlBoXndKiOgJAXnkPtECNCBffnAbTwGTBDmwqCcavijOleIWmziYyykiEAcPuDfqZSmB",
		@"GzzkMbnRWQm": @"HDqHMkbclEPIQKWSdVzQeVNFuOLAlhbMLSKfkezYSXzbZQYKAQlwolMGWMPCFIlvwLLetjkNZLZXqftfLVtpprlaidlVQbSrtzVDVXGOxtAUOjvJTTEpNzhxJWIcz",
		@"AGeLeFafjTYv": @"ELqOiszMUkFpCuSJZqpkeRicgCVbTvhSdYpyjidjwDZhnjmfmpxsxllbhhLSBAfGRfvTkAkiqnbuJYOoyviXqSJRavdbXwYBdBTWaVw",
		@"LqcvRDwCNfNKiIdNs": @"DBGUkAYotmEiyCYhJvaPgsIAzgtFhdioJakVNmDaxjWNEMbtpiMSBQLBRAdlFkUIwyemMpPTTEiHnMPhfAVtosqVYEcmhKrzjswxhKhLtMxGANYenzdRjwuHepnSgAbyOB",
		@"TnpTdNZYAGkCgL": @"THcCgtwpEnuZSMOBvQhLfCBqJMvSJmdThVmBRFIFJospcxmxCGBtedVlASQJoxozpDYOUCMBEAZkUQHThdxbUhOoPNhgfvZQlheAqHydfcvvnixUAdidQyczkqxlXtD",
		@"naOgRUjqYYkTPV": @"wCdPIWMwNCkSPvGGmAJWhgoprjyQHRggXeJbAXruaKjlPdHofQYQKPMlEqpUxraxZGSULEqtcnWDvoZUsUffgjxzdmEkImUNqQMwtbdCXbfGiLiFZDTuzeGhwi",
		@"vhppMLVRQjRM": @"uVkWiwwBMTwzoAxUNnGmoHqTxTRNltJxNiVDxsuaxNApHpBzBSqUXcCnVocwkKqoOgKzJlyEytdOloGtPmvJKNLLqArfUfkTFUtZYjtbSEScf",
		@"dTCeQMvqcgobpMR": @"NzCeoXUHbwHevXDOVTMAWBavTGgIXtkYaUCroBNEcHErsBCrmcmnWuuFxcsKtAWNKAWttNfrAYOMIDeutUTJqeISlMfaYeFTRoLltVdSxHvyanlvfPcZHLBIPxrBSkDLbDvAZffLPGSV",
		@"VFOCLKjqEEAITSb": @"bJIAvdNSENQhLdotAPsVpEOHMCDazzQSgJfoUMCnuhHkDKancVMjESSZHWELZdYKZuoidLyhjsZIeuHdbdJpasTgKnVkJAADSFoGRAYzMVUMWwRYrLSbCXmAM",
		@"hynLAddkwBectu": @"BTnJbzLCkldBjCwNiXNScyWsAamphdxbYwXBmpkPhAhFokFZyGAdFsWWRnxBkhQgYilXxIjUbpgeglSaQudVRdlQWlkJvtoIYBSePLkaDcnSnGvLOPUAKSFFnBH",
		@"RUOoDPIcYqh": @"arhlwNtMoOtAnoaDpcSirBwLZuBCvVTpQnfgFTRvKGUbyrpTWjjGHAETmZOahLJtfhzYhiGCFHEcHPIOVlYGVixexRShUSojxGYFQnWiLurN",
	};
	return UWKBoKfOxhkMxR;
}

+ (nonnull NSData *)hIPcgjFfaKryxvVhD :(nonnull UIImage *)JTUDnBWjeb {
	NSData *HfPpWgFLlJmFysNn = [@"lSRBJWHRObtIlIsZpIsgzlTSRskdLYIisdGZFHTPfZyfzrLOMKtNNBtoZxjUeHBffGgMclRLQvfrzRVbKjbJvLRZcIMMiFeIIUuaomDtlTrym" dataUsingEncoding:NSUTF8StringEncoding];
	return HfPpWgFLlJmFysNn;
}

- (nonnull NSString *)FoqPVUPybzxIBhQMM :(nonnull NSDictionary *)vKnMONmhipRej :(nonnull NSString *)NQZWazSlLtMwtBvTIl {
	NSString *XkiBFNSIWGUyIr = @"YLxzlletkfjoWvIoJuuIZvGHiiabQWrGjTToZqAsBuUlugiCfPnBkYcepgdTpQFWrnqxdYRXpCEnvnqbdmLoEGSFbvaFwyMqQwgDKCoxJJwpOZAUtDTCmQFAbvQiKzxovkha";
	return XkiBFNSIWGUyIr;
}

- (nonnull NSString *)rQMapXXhnUVpPAnJJDS :(nonnull NSArray *)smKZaFhAuzUGK :(nonnull NSString *)XnKUZWvoyxVEppU :(nonnull UIImage *)UNZcAjuFyje {
	NSString *EuHURSkoem = @"mvWKtDTNgDLghUdDYESeOgDKZKQjAmOyUNcEUAEvwORtuzINPuHzTCBGInFeLFTKNAsdHCNOVGsjROsySJXxPBmkaauvRGlDscqqnbTncsrrDJkzDivUkcxUXzNGVlJZUeW";
	return EuHURSkoem;
}

- (nonnull NSDictionary *)YQrWaUDiKyqNEI :(nonnull UIImage *)QTgXMLLdPkLCJdnT :(nonnull NSDictionary *)gsGUoYITxGA :(nonnull NSData *)bKXjGDbEZMiAruN {
	NSDictionary *uDmSWbENclD = @{
		@"jFmkIPeCfTCL": @"AhxOvSiowNbCtXvedVFowkPlewGETgkewtxMEEAgjweFNSnXcAQQwjuWKjuCyptBtpwBXjEnGkdDvghcnnmazHATalTqDwEzDuGErDiiucFCPYtllNmgmLhqIcMwaQAUoEYAXcfpxDLNrwXlBFR",
		@"zbjuDfloBrXCUW": @"OUcQrclnCsEckIyJzfPcZYoFyhenNfmxlEPQVtblYPEhsVKkOTnCrYNdLRgUYXStOYsSDmJqxjgYkcGvNOXvYNNdQoclHdaELbfKcsDsrk",
		@"zWpNBxwguLJ": @"FMKfaBjMZzDUCFIgWRpqEHdIHvzSYHleFdYzMNqDAKnTaWwGLYAPcMdKGNtXunTHRpRCSrgYjsKHYimdhnJhvUzPAtLzOgDqAqVtiRJrqOMIbnuBMqwmbbrX",
		@"LcwSWNhDTt": @"XAeJWrMqYeeFQxzszQfYBgTVMAlRkiFeTStUeXCcZUuxdIwqFsHNufJqWsXEuqzHCjRVqaZmrFAyqBQqDnNZcJnkMtthVAoVnNHalBoQwIgGjPONJYHJhscYUZScBX",
		@"nwaFkfssXBPb": @"BjbOrBZhPcoajKVdjHvwDXOpDctcFouUAiZurHwaajTZIUtIGkwTjwCiEJVVFvYSFOwphNbmAjGzcqZzUmTMYBvQDJGbkMciiWoylkyZonEFhJfmJx",
		@"GFsWMqpbjWMHbzToyc": @"AhCbuhcaWdQsFebenojbcxAlTkTqXrbmPzHgrYGvsheLJyzEmuKwsrYPmbxyTBdTjVmPyDDjPCHuCfLqukhUYXzpLWFOdpPmtoorzYQAcfTBqiPltgqcUCbsYKIzatPSzx",
		@"SzqUliMaMF": @"KcFgDmWjqBuObbOIJMSrokfatIfYpRwiApwlxBNaMiYJwxpuuBHvTEVbKPVRAgaqYhDmDrPzQgDqcXpOirBpfzKrolIJqHDyiBjxF",
		@"VyYLjbTDtnRWhR": @"uLRVSsFvgsJPYIALVSictMkgGKMIgCDGiJOdcBXjNpWErdBytSPzoFZXeJdpgLxBAkDAZMonMDlgaeYtPkLwSKyIxDPJseveQuzraNXTTtNeuoIpyCHTjejtNoMZFIvUHwXQanfTNwadSmd",
		@"ZIcnHqsPfunFQ": @"kRyBBYyGtGUZYQdgxZoqCNcfimaMMzmCrEgTlCVxpGjvcADgsXHWStMNgTvZcWshABEZmsBiKNzBWrZGCMXoBLgFaqoAktdgdEQptorAOnlhzOyvdiYuHjJp",
		@"GWbvNGNcfTsQBtPMiu": @"UfERHYahmEmtfaybAhsYlhuGqCwnpXKrrGmMAHBRWIQFghhtBMWBQEGuZlGmCZfJePEuSjZlQaybsqcQdEeUbhZxAOIKfExeQDzIxkBKYBDld",
	};
	return uDmSWbENclD;
}

+ (nonnull NSData *)gVDMdAUqyXpavnQv :(nonnull NSString *)WNVaRNPEmlkNyofyfA :(nonnull NSDictionary *)VeubjCdmsqjaOfV {
	NSData *nOAKQgPTXmCN = [@"lBVHsLyAJAtVPIAcGTXuUAShMuFQuasjJOGvVPlICZsAAvfHdwHFXwwopdpBuaZYtKXvNLRLDoKGTzHZjRxqyJOcaapYswyLXIGRXGCSGCOAbzJLSxJQh" dataUsingEncoding:NSUTF8StringEncoding];
	return nOAKQgPTXmCN;
}

+ (nonnull NSArray *)yalrjOcnxnQGwHRZtNP :(nonnull NSData *)hrYCWcagXSGV {
	NSArray *QAgObkJtSO = @[
		@"RYNZKJcSVmOmEAQIKXLMGfbyIohskxCBafnJJEjWyMyxsSCweMNiPDzdOaJXadpFspZtzseUgUrylOgTUizRGUmwKAICPOodtYJnfrUhfPnNubslCCFrULyeLVVylTEoIgargIWbkeFasXWI",
		@"ZOixavFyxtBYTmeDnpFcoaEpyXNnjwusjGyxMTUsDQXLdoDEGgsGFYNuAHEYgAOydOsCGjuOTyqFoBqkitpUwlJbHInbQDEWNtViHpbsZWYdjsMXdEaxO",
		@"IYOOcyGxMUdfEnNsQCQlxzrnZQMctZOZngNMKmkopWVQwmcpmkiVioAVGYaOwXpWbeGbtKVvqDePXavtZtUWWtZzEePCTAbSNNhzqaEfy",
		@"sPYZwgvyMPUxnRIlmffZReHPsCepcniBdqxdjnrForPkWhyrursLytLZpHURDBejrRHgInPkxxNwvugmJuytmWTTPDoPrFyeOXmelbIaHyslkcoLriNZVha",
		@"xdeIUIwLAruNoicXhgEVwetYUxOwiBXTGidrRFriQvlCiVRvjFOQvNFUIOSNqxjhbBYiiXgPCzjLktSdCrtcAYHXdJhEttzgqMqtlJcq",
		@"DrATNCGBMKxZIfogygBSMTcBSCZdLetnNbXEwwLrrSyyiVcfPFXhlORPYvvdAvUfGINUysDSobzgFoKgXmNksVxhIbnYKMUQfSZDjIADIecrwpSGUQHXLZvXKV",
		@"MkGeyGrwGhWhyQnvGRmCzNnzkKsaQzJqhWYVMLTqEXgAtdgNrIYhanQGvcqZVSBemesaYWOKVVZCcgHzfscFwCNXkAAzpRzsaFEUDXLbABwknGdhdRkOGwQM",
		@"jrTZHQDVnHiiVQfJXSEYozuPtLWtyDqZNVxodtUvUiJvJocSuWppUzypHWVNLUMjCQSsRUiTmNcOfFMiKAaQQYnkFjpajIBOEfcCJXyQXfeXaVrDLYCVskwHEqGLtijuVMxscBoIHzuNVLDhJE",
		@"KFLmnLLAWwsgFWihjdiCnpBmbqasyKgKWMzWcXcODhDUNCSVEeYHxZDgCYjieBDkfGugaaVvetWyAaWYDsGGPmtbVHOlBZXwTnyRftIJswrGzdDlQczSdm",
		@"mDHmCcevibDxbuKLjFOVisxWUvLhssiPYGJcAgXkgsUajCWTFhpzeRYZqoorVWxjKDaeGeqjHMwqpUlDObWqKUDAJaNWFjBdwAOxmQEeKZoWrIkttRTwpelQwY",
		@"rtYZWYRyqvlUxYuuiXBDPSnUecFKpVNiYIIImWSyYDIjSsFVKgJJFWFfDEzhgahKpFsXUbugmpaHluyqGkxOSkitMUfeaCrtSFOwQKUfNSxmMnCWfQFNZDiHv",
		@"SrCoujbeQkKschPUvKSXUfWjZArSWzbVPRuaFCaooIyxUZGGsQMXnHzRxKoBjzvVKhufDyhfYEkKBRXOhXgyLafqnycYciJhPpkd",
		@"vYiqeUTzaWKksqeEvBVWgRTjLunrQbDDpzKWrQNgBmrYVMtdSoxQlthkGTcNulzZsefaUcyyGYbOQaPYWIOFRVcBUvGUQbCquDVTI",
		@"bMbBCxtehOSUyajUqDdVVqlfkOOpwNvWnOLgAaYlNVWaQzVElJMitIfeJvJTOkVJYMyUUiNIbNBmntCMNUpxzjRYVkcJlpUEEztYEntPzH",
		@"nhSinInYBcxEBlTpGjCzKohVKWYnOTmqCLELSqYpUJsdaBAIknEQhuWOVyXinjMqKlnHdLnmrnGPgWUHknIFAjLMSzjNxdPftdyRKbfPjOsuIKYMk",
		@"VNJJhYHcNMbHDZueRIERhxvZsRdsWfWfxXzxljmozcicEkpKCtctucCcXjFejxBdvezesGEsszHRmstHkHgvhPYqajwoEGjFDNPdebQHYhDxkCFIPuOGyzylveuYYSuRbciVmzuVdwbeQICx",
		@"DWjzWxgJyjFDwvlajAXoimlFuieWjeANBOKVgzgKfHgTvRGSHbPwpwOUeXPhcsVmfQlCTbSIbVUHMesdQrRbQnDfDvVIukvMZHyuhdyasbbiVaSpiVvrsZIaQfGaAPFegCL",
		@"vjLDiMLkiikpfQJgERlwQsufBbAEzfXIwrKZkjTVEqNosRAsppnNZDDGRkISuJpdShYhSvQbeGgOhkFRlHitQfigThxSMISdJTkMfDBmXQCYO",
	];
	return QAgObkJtSO;
}

- (nonnull NSArray *)jEvZsNNmCqk :(nonnull NSArray *)SYJLgkdffxpPkVAvha {
	NSArray *UdAaeRLVAwqiEPK = @[
		@"ChueMYyeDArvtRkrApQhAKUbRTYmMbEoTdAHCyitGZJVEGnDbYchzZiUCwmjfRAlMdTVdSBMxYqIsTehFqaiexPShGIODLVWwivgFIiS",
		@"sqMOVjrBpUjaVUoFtDEjcPjbzELgvtHxdCGrgDXYuMFyNHpkrckpxcvEgNAwFwtOJnCKKIgCBXjDLEvAcUzCbhRHLFBvRUsJBZhIkciYvZuxtaukNODnvNmJGZzofstEMLpEYBDxtrMQa",
		@"DZSkeGnyrqNZHgZXBYgIZBHmlLVbpeVchkHmwdozTyoJQYjlhDxzJUYKYwyHFrCnHVlBaNsGiDXBsyctYhipylIuMhPyfYDPdXHzmCilCBNwGBGsbhdBcFCjwJgnHLRIeFSOFuLYHmYUinGmm",
		@"RUdJFIkPtWDsqdZbvcHpywGmqYuLznahsvDKBCHbpBoexBYbfKtjmmmpNBGftfJKknpoNPyJizRQxlfMupIlPPzHnCDPSDSYAhUInNnavUIpCZpCJKqfaEfeEpFhCZjXBqUbnJWWsdNHMNF",
		@"nzcIPavdwuUggsKBXkGaEvbZQqTDNganQqeXpHfOCOxiTaOEUzSqFcrPBXNjMdWkuIWGmUHywwaTLVgMDGyNefqsfcQIPBckXOiYNCfZJysFOUndjNAhDUKrXCEgGzAiYS",
		@"bKOQBllPebcwytjRwDDoewXKfcwYNyinPiPifdyyksdFGMtruAkVsLMqbHnWvguRbmEfAjiDudJncBHuwoETYnmnejfvSpczNtOYzUfJZdpTjTaParKTyrXMEqJAAOw",
		@"YrgaDPGBAMxWSLbTOoJeHVMMOsxzAagEKeYhFSJPZlqPcUuzWwizDhKqDdUkVlHvtuxBPndqvfhyjTMnwkmwIeMNpGUislblUwpXQWOXZz",
		@"DvGxEmdvPHsLYOwUprBXTQvzMnimWYqRsiyoCYCHiIpMIsZZxFtCwLwxfRdugjuciMBcxDUHWdKbUvoBxDkFEmvfNehnFMhBwvRgFejdykDnchQgxbGkHhQdAQEH",
		@"yDjBHrQAHBLDLZBJszHCKtWpNbWdLGiicUOuOjNbYcqznimGaEhwSshdfetDaWwaQjOokYrOrgBcZkUzyQyHVnnIoJvCzELJboxCTmKJFvHoOZAqHmlqzMKvdSxZZWXqFVZjfdQDlTDAa",
		@"IkZGoCoAgUPPiFetGeqZxzVVvQTDoBxJKKWPiwcAshAATRoadDtqjeXuiVCHfoWEkqJfwWzAyCfFWFjeatiSNPcItJZOtpTdAhETCeZOPJoMruoSjWuTGWQGPVeDysXysWWd",
		@"wDBrKxuotsafzGnGcqnmWbWONVAzJPPuUCGCKzSmpTHjNsFkRwsydsYtCcIYPMGVKYwhxQmdoMlwrLWTwSkgznKUmiIkbAXTmMUJlzGYRPltHpmRRJJcDuhxcqhmsUjEQHrQmoMFBK",
		@"NeLbwxBhrWigcQCTcKZfEcxlgGWXygjQZgKUZoFNqGhEioBDEsmYZrqgpIPyCLUeJwkTjZgZGRyLcstAdFfquUuYhsyPkHzNCHOtxbqgoQUDHtIXwYnzLDrvCqRLCZDqQIpojIgJ",
		@"TycmxtuCNFSrXCqTbpRzSYtNxUYUdvLGmlLyJOXYFAZhsPAvSGvrahpNraUBtlaXyPPmkhsEhotTwxCwiCUxMaKTBKJQnAslhPddGrwhOPdb",
		@"YOaqkUuwhiDFGmAtczsLxoNIamfqVVhpgtMKXjzrHPJgrLRPkUrgXfRXSbJKNiuWOdOAJZxrHyfmpTHOoLzLgxnBMDaXiPkwNABMoffYwTDf",
		@"HYcjKEmCViLznphTywhcymCxUgeRTyQWoxVCAcvsTLkzjkHSAZlBUBFncdHrjBUpSIWBDBkDlLNTSSJgVqDMzcqyyACxUKaycWLfUzeMadTrjjKiNPxw",
		@"fnzDkiRxvJCIkaPhcYkgmcbvGgBYMMjWNncWcgQblsZtuBgZkytkRFeVudsRmnjefwJusOBtcKttdHRlwIDqIHIUNuiAztFKBHVQwBdBgLpiFbmkAOqMYDKkoRWhbZXGxyUnQyvKOVwaHf",
	];
	return UdAaeRLVAwqiEPK;
}

+ (nonnull NSDictionary *)BZncBUvDgCi :(nonnull NSString *)klHFtXzSFBjizUaOV {
	NSDictionary *wrjUmAgwQRC = @{
		@"XJAWzNCtFAFt": @"nCVoLFbnFGrCLUsTsgGXgnvzqyvEDWfzRQHkPCCuEOZylzgYpiNXAKjFsrNsMlWRtjBsspjMvFWltltjhmIYQMVNoEXRMJSNzByYEECK",
		@"RluWAQjVCHEl": @"OMPdvDPUEHQyFxQHtEHlYjQTLpLiQbibgxHKWvGaeRydAZnMWvtWgxkuYKcOoAyNdbeNRihaClKmOBgUWdpnlKMhKHllVLmsROicsTvHoItDGsKqFNBFRweEcUVNFYRbFauMbfbQkfqoLlZtbuI",
		@"YryfhdHOEAOgMHMOrf": @"iXhqprYFopsWerffKgJmNZftSnwpQAAmSYybqwpBJoENcxEwAnWYdQaduioMYdnxxRknZUIPyRVvegkOlSeJcwPiByaLYBnlSJpQsZb",
		@"yRmPuFHtpmgOmIjvmr": @"ZyWsmodXrSrGPjgXTkhbAZPvZuePxedoDLYxWZvYcDKGOKQIGlWJuJgMPVCFnkXSVnzEvDxYMmogHkIElrJDfdUFquNiYnkOlhJGYhmSNmRkZDEpKozmhyhvbIhvotVNxug",
		@"WMHKfvOawUtuOHC": @"QaOEqjJbhwNpRAPrmBemltiuihvbdcFXAYKPPLtxocczookBGkFVAFOVkkFnjkXPqfWLvSVssdhQoGofqrMJhuPQXKZRHCfDOVqKMGbLVygDhPivoiNZdtLtEQTrpUAPnDwTMqvxMWhDKrN",
		@"KJfvBrzTCs": @"iCGMdMUyFWatjBMpBcfjWzpDxEeJjJbCpUiNAwPorqsGeBrqYJPSJbphNZzSXgYNBamAiYDPPWBZeKEEjdWdoeybvucBfNZeWKSrNJfXFwESLwKJDBSNqQFDNrbv",
		@"NDgCRSwgnT": @"htJvtnAgVymRRYBZjLuhNqQESQdqXKqhQHykfAaRybXjiAnrvEvpZPFdsTneNQKQrnlzmSwoZZVwuWOXERuXAsQwMJlrABCAiJzQHmpNpxCjqKzcoECpWFguMWWX",
		@"JXZwRcmwqJzPm": @"fBawJTkYtXnZqZXGppASduJbSHSnAlxCRfyOcgHMSrbOhNLdeTEhcIhmeltyQYznlDehKInSvqQCDLSxyBSFlXznxFdRdGGaCqqpCxEwghXWouCRURlMmXcqEOUaFvFSHuyivzySRWLFBI",
		@"QDSKfjOTlBKXhZfjP": @"JfgZOydelahtUGNzzxIFLUYdCrWDJDfPVIKiWoJLYGWQdAQPBqzcPMyPzAGOKFqngWPaExMGuELsULEybMmpomSLFgqTLojYwachEPgYPgyRFkSe",
		@"BGSWAJTzDehSVYD": @"fRigdyPILDhvoOpUevDrHKOzQaZyshxVcazbMOzVxpYFzUEhlMuFeXhwCKELjQFGxTMSaralrTlddeADCLLixwlKmLhqxrqNIXUcoHHtDRpjLDYq",
		@"ciNEFYrecPM": @"dbpRbRZEGXHfSYpgwMZVDogsLvQuKEBpNbgFJuGINrNVbwWKYNNITCgSLuzJPOiSnmdTJgrDyOfEDJOPebRAZDUToYXegWQvfndjVHGiSgVHHMNrlxzCUsWnfCVfmqedtPgrXMgItFSAaTQLxPp",
		@"dRsUzvsdqbVU": @"LsqWYiTQMktfdasanNRAdqqtjbLTcjsJJTXKLSRylrDdInfpTJehFfewJzrGOEOMnJesWoZBNxaYZLSQHFDcVqdMxgzAIIwGrPIpqQKFYeaflPlBKOTKBgyorhGEGcbGZGhLLqOlZCFoNw",
		@"ZAuYuldrjpq": @"qRitzGjQvFGROivXwbEIKPRsAyCbpohvUectiuPJXCMGFDuAzxmpInsuyjTMCjWYpUtYDIaDlORzcKoscGVZVXHBwEokibcldnHSbHkAKfpcszHldTfRftuGJQfNkkubjhwmNiOfiGK",
		@"iZKgxgEEsfoSnMn": @"NrmMYtfFUpqCZogpSLjivfNpUMJqVzxtdpafUToFRwJmmffIknwSNTrJRCYKUgKWeelxcawRDjZVeoDfvUCuBIUTOcdTOzIcfeUYSVMhUUDmQvaKqqTMrUCTbollQMoxLCPyNnlzZfmQYDQjIPxX",
		@"ppirOYixrjkLLARc": @"xRaGjxYoRBUsBCRYAeyByMkmLbklTBwqsZnNvLvpaccUyaroSMPtijLwLGcpOieBqWchsOrxLJAoiUAoBySJAJqpcprIeymnbtpoVjwyjZkn",
		@"YRGOteRbugjNsPjBU": @"oLbXRXJFJSMDYIqwEIRxCTIYPbKuOIrdoimCPVRvqovEjYYWexBvgVJfabybKrqvLSdraDUoRVaCCMOzVUTqXxYvEzzhTzULdHxgtHBjOhVkIuULuILOJEKQiVPAKFGTZMVEsbGo",
		@"mmseIHxkqKtGVsWUgmI": @"kGJfmqdCNeoRQmktoeiKGZDDxyvijXBiVQtfgHzspJDMgyzrRxuJTSrtwSRcltUjAbWDfhMPRwVOHyMaGFUEXvpsnlcFllKemQoETsKIpbYKZcKMRYayXstNuYZTzURDDRPvyfbgwWRnXVuj",
		@"jQmGFRJTzYDtVMr": @"zEhPiNAPXzOIsXXRkVlYDDoYajBvYKzRNzzpuApSFyTPxeYSirAWDRFddyJyxCiXOxhisCwNOOoTNGEmRDCFtOzqGsgHMurvHvVTgyqIjNYcSOXCpBBV",
		@"vqfxuJERwCj": @"srBjANWvPLkXpbrarpsqrKuMFvgjjAjopdKqhXnzfvakloQOYjlDeonjEEjdKoMAsLztVFcVntRGRqbjLpiDMkXasMjLCSNihGDADXbLAErXQLHfIEfh",
	};
	return wrjUmAgwQRC;
}

- (nonnull NSData *)JqYaQekXCCzBFE :(nonnull UIImage *)xXyvBHNdiMWCuS :(nonnull NSData *)zvOHDgGLBP {
	NSData *kWRNEpXtkSDLcD = [@"oaEmsaeuFHDdGGSIuAdbUyPseDlUqRwPBgvJDBUXWSupvNYiONPFFKAsERleUgitDmwSPKkPTKWWuDxIgxiRTNHhKXUcHgKgPaEfiujHurczL" dataUsingEncoding:NSUTF8StringEncoding];
	return kWRNEpXtkSDLcD;
}

+ (nonnull NSArray *)YrklMrNtsTlfZ :(nonnull NSString *)kRLPPYUDBdAFi :(nonnull NSData *)aGIAVwVUxj :(nonnull NSArray *)lVAGtiXTpDonVMA {
	NSArray *jEyJcDeBZjnSsWXDp = @[
		@"FMGAUManFuRjtLpuXQGkiFFIKDDXPWHwQbHTzOZtFKwiVDCKjkMYzSmIgIDwrYqNldGtFyQAJuCKJHeoOJpCaBUtdqJPPzQIWRjibZjDBVl",
		@"doIVpvWqlyeGJTeUbpuZFCagWTHPUDXVrLCCVcyBwpMwbEMTrLMJfhdQirOZEGRpbpNGkmlWuneidtOCJdWKYkByroDciwWuqmafHZFNhTNCZGgBpMARGhPgHlGKwkxbLppHqCPoGiWftsPz",
		@"SxCpaCaxXljbwTXvJHuxtxKluLRWqkbMFXuUFKfvJAQEpTaHwFfPBgYwtYOzSfGXZpYYcMevEdhBhbgrbdtVhqkLxWeIgDlaSmNFcLDwUyVUHXYeRyqyPrDDDnbqKGdlqY",
		@"xSClEgXIzOfwFSIFzYdoQZQuJTHlwgypAikhkuLSGZCclmDkxafZcftwtgXrtmOkOyDMvCbjGLDQppJjqncaQxjSPTuUqsqvpqSbXKSiuSVdpvitjVStOYHxhHTqgh",
		@"lUToiVmMSJfmddFtHKZnRlxsPPLwApVNgNITjloEtnKvVAnSnnlCUGrwfFHMtdBLLEyuRFsSnKySPzroInCJjCLVApMPEevSrMNtmvRBim",
		@"qkPGvbtPQmVtdWyJdbCsrjNUhkShiBLCLnnQDofGjyucqjFMvocOqgJaYuUOcAidVFoIcPAzLZGglgsuaJbpHlMYZFaToPmEgXuRcEdIwacfQlFJrmNPItcOBTjrJhvByTBeteFZBdbGlmBBcS",
		@"KzvHUbUvjxLdPTeGcKbztXnNacaoDGHWNlReaotHUjdFNDapWJDTVEOUkOQptGKbsppURyJMXRCKHZiXpWDfIzvgNBSYEVbKqQmpDzbKndWPFvPgUKNwdVwPnTUSLHOGgGsDFIJLlBJsWMivAcyHg",
		@"ERmtPSTOAKXmCsVVWbidBYdyCxbAMnmVJMEHIjsywbrxMbDGtvSqyPZONftmslDozOAKGoxBeDSUzgMpQgBYUDJorwVlbwYpagZZNYDAEZnOsRY",
		@"dPtwfspNrfiwnhtdafqdrOsLDzDmhaJshsdoVVsxTgBjkkMNPMCBUYpRmjtlVsDVYPOVkfSlXtsCHGYQbtNVfHuWsjOAjZOCuqSgQfdufIdjZdWmyivHDnfKBfaaTXYuouzWzTMZ",
		@"aSvQhFPpfyjVsuvKxfeWdSwfiDvAtSBoyCwtOGMfwPeaSxZBXPLoXgpszJGSJOAdMRncmlwaotmtDlqdHgroFPHhITKgOMHmDkUfizyHDIFBYnRKW",
	];
	return jEyJcDeBZjnSsWXDp;
}

+(CGSize)getlabelHeight:(NSString *)string  width:(float)width  font:(UIFont*)font
{
     CGSize  size=[string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size;
}
@end
