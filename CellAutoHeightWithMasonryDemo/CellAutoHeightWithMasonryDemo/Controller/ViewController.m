//
//  ViewController.m
//  CellAutoHeightWithMasonryDemo
//
//  Created by 阳光 on 17/1/12.
//  Copyright © 2017年 阳光. All rights reserved.
//

#import "ViewController.h"
#import "PaperModel.h"
#import "TableViewCell.h"

static NSString *TableViewCellIdentifier=@"TableViewCellIdentifier";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title=@"CellAutoHeightWithMasonryDemo";
    
    [self initTableView];

}

-(NSMutableArray *)dataArr
{
    if (_dataArr==nil) {
        _dataArr=[NSMutableArray array];

        int titleLength=(int)[[self titleStr] length];
        int descLength=(int)[[self desStr] length];
        for (NSUInteger i=0;i<kmargin;i++)
        {
            int titleLen=rand()%titleLength+kmargin;
            if (titleLen>titleLength-1)
            {
                titleLen=titleLength;
            }
            PaperModel *model=[PaperModel new];
            model.title=[[self titleStr] substringToIndex:titleLen];
            model.uid=(int)i+1;
            model.isExpand=NO;

            int descLen=rand()%descLength+kmargin;
            if (descLen>=descLength)
            {
                descLen=descLength;
            }
            model.desTitle=[[self desStr] substringToIndex:descLen];
            [_dataArr addObject:model];
        }
    }

    return _dataArr;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{

    TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    PaperModel *model=nil;
    if (indexPath.row<self.dataArr.count)
    {
        model=self.dataArr[indexPath.row];
    }
    [cell configCellWithModel:model];

    cell.isExpandBlock=^(BOOL isExpand)
    {
        model.isExpand=isExpand;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    return cell;
}

-(CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    PaperModel *model=nil;
    if (indexPath.row<self.dataArr.count)
    {
        model=self.dataArr[indexPath.row];
    }

    NSString *stateKey=nil;
    if (model.isExpand)
    {
        stateKey=@"expand";
    }
    else
    {
        stateKey=@"unexpand";
    }

    return [TableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        TableViewCell *cell=(TableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    } cache:^NSDictionary *{
        return @{ kHYBCacheUniqueKey:[NSString stringWithFormat:@"%d", model.uid],
                 kHYBCacheStateKey :stateKey,
                 // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                 // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                  // 标识不用重新更新
                 kHYBRecalculateForStateKey:@(NO)
                 };
    }];
}


-(void)initTableView
{
    self.tableView=[UITableView new];
    [self.view addSubview:self.tableView];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableFooterView=[UIView new];
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:TableViewCellIdentifier];
}

-(NSString *)titleStr
{
    return @"唐嫣，1983年12月6日出生于上海市，毕业于中央戏剧学院表演系本科班，中国影视女演员。2001年参加第三届舒蕾世纪星比赛获全国总冠军";
}

-(NSString *)desStr
{
    return @"2004年被张艺谋钦定为奥运宝贝,参与中国8分钟的闭幕式表演。因主演电视剧《仙剑奇侠传三》和《夏家三千金》受到关注.2012年成立唐嫣工作室,担任其主演微电影《逐爱之旅》的制作人.2014年凭借《金玉良缘》获得第五届中国大学生电视节最受欢迎女演员。2015年主演都市爱情剧《何以笙箫默》热播,并担任第六届中国大学生电视节推广大使。";
}

@end
