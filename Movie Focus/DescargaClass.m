//
//  DescargaClass.m
//  Movie Focus
//
//  Created by Waltar Rafael on 30/10/21.
//

#import "DescargaClass.h"

@implementation DescargaClass

- (NSString *) descargarpaginas:(NSInteger)pagina id:(NSString*)idContenido sms:(NSString*)mensaje{
    NSURL* aURL;
    NSMutableURLRequest *request  = [[NSMutableURLRequest alloc] init];
    NSData* requestData;
    NSString* requestDataLengthString;
    switch (pagina) {
        case 1://LOGIN
            requestData = [[NSData alloc] initWithData:[idContenido dataUsingEncoding:NSUTF8StringEncoding]];
            requestDataLengthString = [[NSString alloc] initWithFormat:@"%lu", (unsigned long)[requestData length]];
            aURL = [NSURL URLWithString:@"https://reqres.in/api/login"];
            [request setURL:aURL];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:requestDataLengthString forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody:requestData];
            break;
            
        case 2://favoritos
            aURL =[NSURL URLWithString: [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/popular?api_key=%@&language=en-US&page=%@",idContenido,mensaje]];
            [request setURL:aURL];
            break;
            
        case 3://busqueda
            aURL =[NSURL URLWithString: [NSString stringWithFormat:@"https://api.themoviedb.org/3/search/multi?api_key=%@&language=en-US&query=%@&page=1&include_adult=false",idContenido,mensaje]];
            [request setURL:aURL];
            [request setHTTPMethod:@"GET"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:requestDataLengthString forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody:requestData];
            break;
            //
       
    }
    
 
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([responseString length] > 0) {
        return responseString;
    }else{
        return @"";
    }
}



////////////////////////////////////////////////////////////////////////////
- (void)descargarimagenes:(NSString *)imagen name:(NSString*)nombreimagen
{
    @try {
        NSFileManager *fm = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@".samix/"];
        BOOL success;
        success = [fm fileExistsAtPath:writableDBPath isDirectory:&success];
        if (!success) {
            NSString *defaultDBPath = [documentsDirectory stringByAppendingPathComponent:@".samix/"];
            success = [fm createDirectoryAtPath:defaultDBPath withIntermediateDirectories:YES attributes:nil error:NULL];
            if (!success){
                NSLog(@"Error al crear Carpeta");
            }
        }
        UIImage *result;
        NSURL *temp = [[NSURL alloc] init];
        NSData *data;
        temp = [NSURL URLWithString:imagen];
        
        NSError *err = nil;
        BOOL excluded = [temp setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&err];
        if (!excluded) {
            NSLog(@"Failed to exclude from backup");
        } else {
            NSLog(@"Excluding from backup"); // this works...
        }
        data = [NSData dataWithContentsOfURL:temp];
        result = [UIImage imageWithData:data];
        [self saveImage:result withFileName:nombreimagen ofType:@"png" inDirectory:writableDBPath];
        
    }
    @catch (NSException *exception) {
        
    }
    
}////////////////////////////////////////////////////////////////////////////
-(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath
{
    
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:imageName] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imageName]] options:NSAtomicWrite error:nil];
    } else {
        NSLog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
    }
}

-(NSString *)limpiando:(NSString *)cadena{
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"a"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"a"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"a"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"e"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"e"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"e"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"i"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"i"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"i"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"o"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"o"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"o"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"u"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"u"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"u"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"A"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"A"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"A"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"E"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"E"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"E"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"I"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"I"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"I"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"O"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"O"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"O"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"U"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"U"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"U"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"#" withString:@""];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"&" withString:@""];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"??" withString:@"n"];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"/" withString:@""];
    cadena = [cadena stringByReplacingOccurrencesOfString:@"<" withString:@""];
    cadena = [cadena stringByReplacingOccurrencesOfString:@">" withString:@""];
    cadena = [cadena stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    return cadena;
}

@end
