//
//  HomeViewController.m
//  Movie Focus
//
//  Created by Waltar Rafael on 29/10/21.
//

#import "HomeViewController.h"
#import "CustomCell.h"
#import "DetalleViewController.h"
#import "DescargaClass.h"


@interface HomeViewController ()


@end


@implementation HomeViewController {
    UITableView *tableView;
}

@synthesize favoritosDictionary;
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (@available(iOS 13.0, *)) {
            self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
    // must set delegate & dataSource, otherwise the the table will be empty and not responsive
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.searchBar.delegate = self;
    
    [self descargaFavoritas];
}




-(void)descargaFavoritas{
    DescargaClass *class = [[DescargaClass alloc] init];
    NSString *json;
    json = [class descargarpaginas:2 id:@"b68961af4d3d28cedac86118400870be" sms:@"1" ];
    if (json.length > 0) {
        [cargando setHidden:YES];

        NSError *e = nil;
        NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
        favoritosDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
        if(favoritosDictionary.count > 0){
            favoritosArray = [favoritosDictionary objectForKey:@"results"];
        }else{
            
        }

        [  self.tableview reloadData];
        
     

    }else{
        UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                   message: @"something went wrong"
                                                                  preferredStyle:UIAlertControllerStyleAlert                   ];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [myAlertController dismissViewControllerAnimated:YES completion:nil];

                             }];
        [myAlertController addAction: ok];
        [self presentViewController:myAlertController animated:YES completion:nil];
        [cargando setHidden:YES];
    }
}


#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return favoritosArray.count;
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    CustomCell *cell = (CustomCell *)[theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    NSString *posterString = [[favoritosArray objectAtIndex:[indexPath row]]valueForKey:@"poster_path"];
    NSString *urlImagenString =[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w500/%@",posterString];

    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:urlImagenString]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            cell.poster.image = [UIImage imageWithData: data];
        });
    });
    
    float roundedValue = round(2.0f * [[[favoritosArray objectAtIndex:[indexPath row]]valueForKey:@"vote_average"] floatValue]) / 2.0f;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    [formatter setRoundingMode: NSNumberFormatterRoundDown];

    NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:roundedValue]];
    
    
    cell.titulo.text = [[favoritosArray objectAtIndex:[indexPath row]]valueForKey:@"title"];
    cell.fecha.text = [[[favoritosArray objectAtIndex:[indexPath row]]valueForKey:@"release_date"] stringByAppendingString: [NSString stringWithFormat:@"   Ranking: %@",numberString]];
    cell.descrip.text = [[favoritosArray objectAtIndex:[indexPath row]]valueForKey:@"overview"];

    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)getLabelHeight:(UILabel*)label
{
    CGSize constraint = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
    CGSize size;

    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:label.font}
                                                  context:context].size;

    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));

    return size.height;
}

#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"selected %d row", indexPath.row);
   
}
- (IBAction)buscar:(id)sender {
    
    if ([self.searchBar.text isEqualToString:@""]){
        UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                  message: @"insert a word to search"                                                                  preferredStyle:UIAlertControllerStyleAlert                   ];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here, eg dismiss the alertwindow
                                 [myAlertController dismissViewControllerAnimated:YES completion:nil];

                             }];
        [myAlertController addAction: ok];
        [self presentViewController:myAlertController animated:YES completion:nil];
        return;
    }
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SbDetalle" bundle:nil];
    DetalleViewController *vc2 = [sb instantiateViewControllerWithIdentifier:@"detalle"];
    vc2.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [vc2 setTituloBusqueda:self.searchBar.text];
    [self presentViewController:vc2 animated:YES completion:NULL];
    NSLog(@"click");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
  // return the height of the particular row in the table view
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    searchBar.enablesReturnKeyAutomatically = NO;

    return YES;
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    [self.searchBar setShowsCancelButton:YES animated:NO];
    for (UIView *subView in self.searchBar.subviews){
        if([subView isKindOfClass:[UIButton class]]){
            [(UIButton*)subView setTitle:@"Done" forState:UIControlStateNormal];
        }
    }
}


@end
