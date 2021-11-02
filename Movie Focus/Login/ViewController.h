//
//  ViewController.h
//  Movie Focus
//
//  Created by Waltar Rafael on 29/10/21.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>{
    
    NSDictionary *jsonLogin ;
    UIActivityIndicatorView *cargando;
}

- (void) postmethodurl;


@end

