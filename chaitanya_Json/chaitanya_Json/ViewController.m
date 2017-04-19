//
//  ViewController.m
//  chaitanya_Json
//
//  Created by student on 4/14/17.
//  Copyright © 2017 student. All rights reserved.
//

#import "ViewController.h"
#import "FirstTableViewController.h"
@interface ViewController ()
@property NSMutableArray * array;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appTitle =[[NSMutableArray alloc]initWithObjects:@"topfreeapplications",@"toppaidapplications",@"topgrossingapplications", nil];
    
    self.numbers =[[NSMutableArray alloc]initWithObjects:@"10",@"25",@"100", nil];
    
    self.country =[[NSMutableArray alloc]initWithObjects:@"in",@"gb",@"us", nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)submitBtn:(UIButton *)sender
{
    FirstTableViewController * apps = [self.storyboard instantiateViewControllerWithIdentifier:@"first"];
    
    
    
    for (int i=0; i<[self.appTitle count]; i++)
    {
        if (self.titleSC.selectedSegmentIndex==i)
        {
            for (int j=0; j<[self.numbers count]; j++)
            {
                if (self.numberSC.selectedSegmentIndex==j)
                {
                    for (int k=0; k<[self.country count]; k++)
                    {
                        if (self.countrySC.selectedSegmentIndex==k)
                        {
                            self.urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
                            
                            NSString * string = [NSString stringWithFormat:@"https://itunes.apple.com/%@/rss/%@/limit=%i/json",[self.country objectAtIndex:k],[self.appTitle objectAtIndex:i],[[self.numbers objectAtIndex:j] intValue]];
                            
                            self.urlRequest = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:string]];
                            
                            self.dataTask = [self.urlSession dataTaskWithRequest:self.urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                             {
                                                 self.serverResDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                 
                                                 for (unsigned short int i=0; i<[[self.numbers objectAtIndex:j]intValue]; i++)
                                                 {
                                                     NSLog(@"  %@ ", [[[[[self.serverResDict objectForKey:@"feed"] objectForKey:@"entry"]objectAtIndex:i] objectForKey:@"im:name"] objectForKey:@"label"] );
                                                     
                                                     
                                                     
                                                     [apps.labelArray addObject:[[[[[self.serverResDict objectForKey:@"feed"] objectForKey:@"entry"]objectAtIndex:i] objectForKey:@"im:name"] objectForKey:@"label"]];
                                                     
                                                     
                                                     [apps.imageArray addObject:[[[[[[self.serverResDict objectForKey:@"feed"] objectForKey:@"entry"]objectAtIndex:i] objectForKey:@"im:image"]objectAtIndex:0] objectForKey:@"label"]];
                                                     
                                                     
                                                     [apps.textArray addObject:[[[[[[self.serverResDict objectForKey:@"feed"] objectForKey:@"entry"]objectAtIndex:i] objectForKey:@"im:releaseDate"] objectForKey:@"attributes"]objectForKey:@"label"]];
                                                     
                                                     //  [apps.summaryArray addObject:[[[[[[self.serverResDict objectForKey:@"feed"] objectForKey:@"entry"]objectAtIndex:i] objectForKey:@"im:releaseDate"] objectForKey:@"attributes"]objectForKey:@"label"];
                                                     
                                                     
                                                     
                                                     
                                                     NSLog(@"image %@ ",apps.imageArray);
                                                     
                                                     NSLog(@"date %@ ",apps.textArray);
                                                     
                                                 }
                                                 
                                                 
                                             }];
                        }
                    }
                }
            }
        }
    }
    
    
    [self.navigationController pushViewController:apps animated:YES];
    
    [self.dataTask resume];
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
