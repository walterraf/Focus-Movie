//
//  CustomCell.h
//  Movie Focus
//
//  Created by Waltar Rafael on 29/10/21.
//


#import <UIKit/UIKit.h>

// extends UITableViewCell
@interface CustomCell : UITableViewCell

// now only showing one label, you can add more yourself
@property (nonatomic, strong) IBOutlet UILabel *titulo;
@property (nonatomic, strong) IBOutlet UILabel *descrip;
@property (nonatomic, strong) IBOutlet UIImageView *poster;
@property (nonatomic, strong) IBOutlet UILabel *fecha;
@property (nonatomic, strong) IBOutlet UILabel *type;
@property (nonatomic, strong) IBOutlet UILabel *voto;

@end
