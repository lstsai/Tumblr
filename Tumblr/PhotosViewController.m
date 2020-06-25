//
//  PhotosViewController.m
//  Tumblr
//
//  Created by laurentsai on 6/25/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import "PhotosViewController.h"
#import "UIImageView+AFNetworking.h"
#import "PhotoCell.h"


@interface PhotosViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *posts;
@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    NSURL *url = [NSURL URLWithString:@"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            }
            else {
                NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

                // TODO: Get the posts and store in posts property
                // Get the dictionary from the response key
                NSDictionary *responseDictionary = dataDictionary[@"response"];
                // Store the returned array of dictionaries in our posts property
                self.posts = responseDictionary[@"posts"];
               // NSLog(@"%@", self.posts);
                
                //**or you could do it in one line  self.posts= dataDictionary[@"response"][@"posts"];

                // TODO: Reload the table view
                [self.tableView reloadData];
                
            }
        }];
    self.tableView.rowHeight = 240;
    [task resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCell" forIndexPath:indexPath];

    
    NSDictionary *post= self.posts[indexPath.row];//pull out the specific post
    NSArray *photos=post[@"photos"];//try to pull out the photos for the post
    if(photos)//if there are photos
    {
        NSDictionary *thePhoto= photos[0];
        NSDictionary *originalSize= thePhoto[@"original_size"];
        NSString *urlString = originalSize[@"url"];//get url from the orig size dictionary
        NSURL *url = [NSURL URLWithString:urlString];//create that url
      
        [cell.postView setImageWithURL:url];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}


@end
