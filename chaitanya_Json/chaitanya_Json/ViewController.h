//
//  ViewController.h
//  chaitanya_Json
//
//  Created by student on 4/14/17.
//  Copyright © 2017 student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *titleSC;
@property (weak, nonatomic) IBOutlet UISegmentedControl *numberSC;
@property (weak, nonatomic) IBOutlet UISegmentedControl *countrySC;
- (IBAction)submitBtn:(UIButton *)sender;

@property NSURLSession * urlSession;
@property NSURLSessionDataTask * dataTask;
@property NSMutableURLRequest * urlRequest;
@property NSMutableDictionary * serverResDict;

@property NSMutableArray * appTitle;
@property NSMutableArray * numbers;
@property NSMutableArray * country;

@end

