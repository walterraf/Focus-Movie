//
//  DescargaClass.h
//  Movie Focus
//
//  Created by Waltar Rafael on 30/10/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DescargaClass :  NSObject{
    int tipoServicio;
    NSString *varReplace,*urlGeneral,*urlNotificatios;
    NSString *OS;
}

- (NSString *) descargarpaginas:(NSInteger)pagina id:(NSString*)idContenido sms:(NSString*)mensaje;
- (void) postmethodurl;
- (void) descargarimagenes:(NSString *)imagen name:(NSString*)nombreimagen;
-(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;
-(NSString *)limpiando:(NSString *)cadena;


@end

NS_ASSUME_NONNULL_END

