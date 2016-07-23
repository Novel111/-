//
//  HomeCell.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/23.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "HomeCell.h"
#import "Masonry.h"
@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubviews];
        [self makeConstraits];
    }
    return self;
}


#pragma mark - viewsetup
- (void)addSubviews
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.newsImage];
    [self.contentView addSubview:self.inifoLabel];
    [self.contentView addSubview:self.conmmentView];
    [self.contentView addSubview:self.commentLabel];
}

- (void)makeConstraits
{
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    [self.newsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.equalTo(self.contentView.mas_width).dividedBy(3.47);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(height /4.6);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.newsImage.mas_left).offset(-4);
    }];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLabel.mas_right);
        make.width.equalTo(self.contentView.mas_width).dividedBy(29);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
    }];
    [self.conmmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.lessThanOrEqualTo(self.commentLabel);
        make.right.equalTo(self.commentLabel.mas_left).offset(-5);
        make.width.equalTo(self.contentView.mas_width).dividedBy(17);
    }];
    [self.inifoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self.conmmentView.mas_left);
        make.baseline.equalTo(self.commentLabel.mas_bottom);
    }];
    
    
}

#pragma mark -getter
- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.alpha = 0.87;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = UITextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel*)inifoLabel
{
    if (!_inifoLabel) {
        _inifoLabel = [[UILabel alloc] init];
        _inifoLabel.font = [UIFont systemFontOfSize:15];
        [_inifoLabel setTextColor:[UIColor lightGrayColor]];
    }
    return _inifoLabel;
}

- (UILabel*)commentLabel
{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont systemFontOfSize:15];
        [_commentLabel setTextColor:[UIColor lightGrayColor]];
        
    }
    return _commentLabel;
}

- (UIImageView* )newsImage
{
    if (!_newsImage){
        _newsImage = [[UIImageView alloc] init];
    }
    return _newsImage;
}

- (UIImageView*)conmmentView
{
    if(!_conmmentView)
    {
        _conmmentView = [[UIImageView alloc] init];
        _conmmentView.image = [UIImage imageNamed:@"消息icon"];
    }
    return _conmmentView;
}
@end
