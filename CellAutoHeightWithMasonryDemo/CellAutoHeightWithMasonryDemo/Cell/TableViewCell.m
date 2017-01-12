//
//  TableViewCell.m
//  CellAutoHeightWithMasonryDemo
//
//  Created by 阳光 on 17/1/12.
//  Copyright © 2017年 阳光. All rights reserved.
//

#import "TableViewCell.h"


@interface TableViewCell ()

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *desLabel;

@property(nonatomic,strong)UIButton *lastBtn;

@property(nonatomic,assign)BOOL isExpanded;

@end

@implementation TableViewCell

-( instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.titleLabel=[self getLabelWithText:@"" font:Font_Number(16) textColor:[UIColor redColor] textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByTruncatingTail numberOfLines:0];
        self.titleLabel.userInteractionEnabled=NO;
        [self.contentView addSubview:self.titleLabel];

        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(kmargin);
            make.height.mas_lessThanOrEqualTo(80);
//            make.right.mas_offset(-kmargin);
        }];
        CGFloat w=[UIScreen mainScreen].bounds.size.width;
        self.titleLabel.preferredMaxLayoutWidth=w-kmargin*2;


         self.desLabel=[self getLabelWithText:@"" font:Font_Number(13) textColor:[UIColor greenColor] textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByTruncatingTail numberOfLines:0];
        [self.contentView addSubview:self.desLabel];
        self.desLabel.userInteractionEnabled=YES;
        [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(kmargin);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kmargin);
            make.right.mas_offset(-kmargin);
        }];
        self.desLabel.preferredMaxLayoutWidth=w-kmargin*2;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(isExpandEvent)];
        [self.desLabel addGestureRecognizer:tap];



        self.lastBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.lastBtn];
        ViewBorderRadius(self.lastBtn,kmargin,1,[UIColor clearColor]);
        [self.lastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kmargin);
            make.right.mas_equalTo(-kmargin);
            make.height.mas_equalTo(kmargin*4);
            make.top.mas_equalTo(self.desLabel.mas_bottom).offset(kmargin*2);
        }];
        self.lastBtn.backgroundColor=[UIColor lightGrayColor];
        [self.lastBtn setTitle:@"点击绿色文本实现折叠效果" forState:0];
        [self.lastBtn addTarget:self action:@selector(lastBtnEvent) forControlEvents:UIControlEventTouchUpInside];

        // 必须加上这句
        self.hyb_lastViewInCell = self.lastBtn;
        // self.hyb_lastViewsInCell = @[self.button];
        self.hyb_bottomOffsetToCell=kmargin*2;
        self.isExpanded=YES;
    }
    return self;
}

-(void)isExpandEvent
{
    if (self.isExpandBlock) {
        self.isExpandBlock(!self.isExpanded);
    }
}

-(void)lastBtnEvent
{
    NSString *tipStr;
    if (self.isExpanded)
    {
        tipStr=@"已折叠效果";
    }
    else
    {
        tipStr=@"未折叠效果";
    }
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:tipStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

-(void)configCellWithModel:(PaperModel *)paperModel
{
    self.titleLabel.text=paperModel.title;
    self.desLabel.text=paperModel.desTitle;

    if (paperModel.isExpand!=self.isExpanded)
    {
        self.isExpanded=paperModel.isExpand;
        if (self.isExpanded)
        {
            [self.desLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(kmargin);
                make.right.mas_equalTo(-kmargin);
                make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kmargin);
            }];
        }
        else
        {
            [self.desLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_lessThanOrEqualTo(50);
            }];
        }
    }
}

@end
