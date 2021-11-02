//
//  DetalleViewController.h
//  Movie Focus
//
//  Created by Waltar Rafael on 29/10/21.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetalleViewController :  UIViewController<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>{
    
    NSDictionary *jsonFavoritos;
    NSMutableArray *favoritosArray ;
    UIActivityIndicatorView *cargando;
}
@property(strong)NSString *tituloBusqueda;
@property(nonatomic,retain) IBOutlet UITableView *tableview;
@property(nonatomic,retain) NSDictionary *favoritosDictionary;
@property (nonatomic, strong) IBOutlet UILabel *palabraBusqueda;



@end

NS_ASSUME_NONNULL_END
