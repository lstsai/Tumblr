//
//  PostViewController.m
//  Tumblr
//
//  Created by laurentsai on 6/25/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import "PostViewController.h"
#import "UIImageView+AFNetworking.h"


@interface PostViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *postPhotoView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;


@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *photos=self.post[@"photos"];//try to pull out the photos for the post
    if(photos)//if there are photos
    {
        NSDictionary *thePhoto= photos[0];
        NSDictionary *originalSize= thePhoto[@"original_size"];
        NSString *urlString = originalSize[@"url"];//get url from the orig size dictionary
        NSURL *url = [NSURL URLWithString:urlString];//create that url
        //NSString *caption= self.post[@"caption"];
        NSString *captionExtract= [self.post[@"caption"] substringFromIndex:3];
        self.captionLabel.text= captionExtract;
        [self.postPhotoView setImageWithURL:url];
        self.authorLabel.text=self.post[@"blog"][@"title"];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
