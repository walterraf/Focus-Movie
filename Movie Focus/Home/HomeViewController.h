//
//  HomeViewController.h
//  Movie Focus
//
//  Created by Waltar Rafael on 29/10/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>{
    
    NSDictionary *jsonFavoritos;
    NSMutableArray *favoritosArray ;
    UIActivityIndicatorView *cargando;
}
@property(nonatomic,retain) IBOutlet UITableView *tableview;
@property(nonatomic,retain) NSDictionary *favoritosDictionary;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;



@end

NS_ASSUME_NONNULL_END
