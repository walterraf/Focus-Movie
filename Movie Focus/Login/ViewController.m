//
//  ViewController.m
//  Movie Focus
//
//  Created by Waltar Rafael on 29/10/21.
//
#import "ViewController.h"
#import "HomeViewController.h"
#import "DescargaClass.h"
#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]


@interface ViewController ()


@property(nonatomic) UIView  *loginView;
@property(nonatomic) UIView  *firstView;

- (void)createLoginView;
- (void)createfirstView;

@end

@implementation ViewController{
    UITextField *userNameField;
    UITextField *userPasswordField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (@available(iOS 13.0, *)) {
            self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
    [self createLoginView];
    cargando = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];

        [self.view addSubview:cargando];

}





- (void)createLoginView{
    
    double espacio = self.view.bounds.size.height/25;
    double pocicionInical = self.view.bounds.size.height/3;
    
    /*Login View*/
    //Size is the same size as the self.view
    self.loginView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x,self.view.bounds.origin.y, self.view.bounds.size.width,self.view.bounds.size.height)];
    //Change background color
    [self.loginView setBackgroundColor:Rgb2UIColor(13, 37, 63)];
    
    
    /*User Name text Field*/
    userNameField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/18, pocicionInical, self.view.bounds.size.width-(self.view.bounds.size.width/18 * 2), self.view.bounds.size.height/15)];
    userNameField.textColor =  Rgb2UIColor(0,0,0);
    userNameField.backgroundColor = [UIColor colorWithRed:96 green:96 blue:96 alpha:0.5];
    [userNameField setFont:[UIFont systemFontOfSize:16]];
    userNameField.placeholder=@"user name";
    userNameField.returnKeyType = UIReturnKeyNext;
    userNameField.keyboardType = UIKeyboardTypeDefault;
    
    //Padding
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    userNameField.leftView = paddingView;
    userNameField.leftViewMode = UITextFieldViewModeAlways;
    
    //Rounded corners
    userNameField.layer.cornerRadius = 20;
    
    //Annimation, Login appearence
    [UIView animateWithDuration:1.5 animations:^{
        self->userNameField.alpha = 0.0;
        self->userNameField.alpha = 1.0;
    }];
    
    
    /*User Password text Field*/
    userPasswordField = [[UITextField alloc]  initWithFrame:CGRectMake(self.view.bounds.size.width/18, pocicionInical + espacio + userNameField.frame.size.height, self.view.bounds.size.width-(self.view.bounds.size.width/18 * 2), self.view.bounds.size.height/15)];
    userPasswordField.textColor = Rgb2UIColor(0,0,0);
    userPasswordField.backgroundColor =[UIColor colorWithRed:96 green:96 blue:96 alpha:0.5];
    [userPasswordField setFont:[UIFont systemFontOfSize:16]];
    userPasswordField.placeholder=@"password";
    userPasswordField.returnKeyType = UIReturnKeyDone;
    userPasswordField.keyboardType = UIKeyboardTypeDefault;
    userPasswordField.secureTextEntry = YES;
    
    //Padding
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    userPasswordField.leftView = paddingView;
    userPasswordField.leftViewMode = UITextFieldViewModeAlways;
    
    //Rounded corners
    userPasswordField.layer.cornerRadius = 20;
    
    //Annimation, Login appearence
    
    [UIView animateWithDuration:2.5 animations:^{
        self->userPasswordField.alpha = 0.0;
        self->userPasswordField.alpha = 1.0;
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(login)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Login" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(self.view.bounds.size.width/10, userPasswordField.frame.origin.y  + espacio + userPasswordField.frame.size.height, self.view.bounds.size.width-(self.view.bounds.size.width/10 * 2), self.view.bounds.size.height/15);
    button.layer.cornerRadius = 20;
    
    
    [UIView animateWithDuration:3.5 animations:^{
        button.alpha = 0.0;
        button.alpha = 1.0;
    }];

    
   

    
    //add userNameField,userPasswordField loginView
    [self.loginView addSubview:userNameField];
    [self.loginView addSubview:userPasswordField];
    [self.view addSubview:self.loginView];
    [self.loginView addSubview:button];
    
    
    //Delegate
    userNameField.delegate=self;
    userPasswordField.delegate=self;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if(textField == userNameField) {
        userNameField.backgroundColor =[UIColor colorWithRed:96 green:96 blue:96 alpha:0.8];
        userPasswordField.backgroundColor =[UIColor colorWithRed:96 green:96 blue:96 alpha:0.5];
    }
    
    if(textField == userPasswordField) {
        userPasswordField.backgroundColor =[UIColor colorWithRed:96 green:96 blue:96 alpha:0.8];
        userNameField.backgroundColor =[UIColor colorWithRed:96 green:96 blue:96 alpha:0.5];
    }
    
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField == userNameField) {
        [userNameField resignFirstResponder];
        [userPasswordField becomeFirstResponder];
        userNameField.backgroundColor =[UIColor colorWithRed:96 green:96 blue:96 alpha:0.5];
    }
    
    if(textField == userPasswordField) {
        [userPasswordField resignFirstResponder];
        userPasswordField.backgroundColor =[UIColor colorWithRed:96 green:96 blue:96 alpha:0.5];
        
        //Remove the loginIn View
        [self.loginView removeFromSuperview];
        
    }
    
    
    return YES;
}

-(void)descargaStr{
    DescargaClass *class = [[DescargaClass alloc] init];
    NSString *json;
    json = [class descargarpaginas:1 id:[self structLogin] sms:@"" ];
    if (json.length > 0) {
        [cargando setHidden:YES];
        NSError *jsonError;
        NSData *objectData = [json dataUsingEncoding:NSUTF8StringEncoding];
        jsonLogin = [NSJSONSerialization JSONObjectWithData:objectData
                                                       options:NSJSONReadingMutableContainers
                                                         error:&jsonError];//error
        
        NSString *error = [jsonLogin objectForKey:@"error"];
        if([error isEqualToString:@"user not found"]){
               UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                         message: error
                                                                         preferredStyle:UIAlertControllerStyleAlert                   ];
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
        }else{
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
            HomeViewController *vc = [sb instantiateViewControllerWithIdentifier:@"home"];
            vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:vc animated:YES completion:NULL];
        }
        
     

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

-(NSString*)structLogin{
    NSDictionary *jsonBodyDict = @{@"email":userNameField.text.lowercaseString, @"password":userPasswordField.text};
    NSError * err;
    NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:jsonBodyDict options:0 error:&err];
    NSString * myString = [[NSString alloc] initWithData:jsonData   encoding:NSUTF8StringEncoding];
    NSLog(@"%@",myString);
    return myString;
}
// @{@"email":@"eve.holt@reqres.in", @"password":@"cityslicka"};

-(void)cargador{
    [cargando setHidden:NO];
    cargando.frame = CGRectMake(0,0, self.view.frame.size.width , self.view.frame.size.height);
    [cargando startAnimating];
}


- (void)login {
    
    
    if ([userNameField.text isEqualToString:@""] || [userPasswordField.text isEqualToString:@""]){
        UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                  message: @"username and password are required"                                                                  preferredStyle:UIAlertControllerStyleAlert                   ];
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
    [NSThread detachNewThreadSelector:@selector(cargador) toTarget:self withObject:nil];
    [self descargaStr];

}

@end
