//
//  CustomCell.m
//  Movie Focus
//
//  Created by Waltar Rafael on 29/10/21.
//



#import "CustomCell.h"

@implementation CustomCell

//@property (nonatomic, strong) UILabel *titulo;
//@property (nonatomic, strong) UIImage *poster;
//@property (nonatomic, strong) UILabel *fecha;
//@property (nonatomic, strong) UILabel *vision;
//@property (nonatomic, strong) UILabel *voto;

@synthesize titulo = _titulo;
@synthesize fecha = _fecha;
@synthesize descrip = _descrip;
@synthesize poster = _poster;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titulo.textColor = [UIColor blackColor];
        self.fecha.textColor = [UIColor blackColor];
        self.descrip.textColor = [UIColor blackColor];
        self.descrip.numberOfLines = 0;
//        [self.descrip sizeToFit];


 

        self.titulo.font = [UIFont fontWithName:@"Arial" size:self.frame.size.width/22];
        self.fecha.font = [UIFont fontWithName:@"Arial" size:self.frame.size.width/28];
        self.descrip.font = [UIFont fontWithName:@"Arial" size:self.frame.size.width/28];
        
        [self addSubview:self.titulo];
        [self addSubview:self.fecha];
        [self addSubview:self.poster];
        [self addSubview:self.descrip];
    }
    return self;
}

@end
