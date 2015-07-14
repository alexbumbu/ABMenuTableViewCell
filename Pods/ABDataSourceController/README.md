# ABDataSourceController

Simple to use approach to get rid of your UITableViewDataSource & UITableViewDelegate code from your UIViewController and share it between UIViewControllers.

## Integration

* Clone this repository and drag the content of ```ABDataSourceController``` folder to your project.  
* To use you just need to create your custom data source controller object that implements ```ABDataSourceController``` protocol:

```objective-c
#import "ABDataSourceController.h"

@interface CustomDataSourceController : NSObject <ABDataSourceController>

@property (nonatomic, assign) IBOutlet UITableView *tableView;
@property (nonatomic, assign) IBOutlet UIViewController *viewController;

@end

@implementation CustomDataSourceController {
    NSArray *_dataSource;
}

@synthesize tableView = _tableView;
@synthesize viewController = _viewController;

@end
```

* Now override ```refreshDataSourceWithCompletionHandler``` method to load data source:

```objective-c
- (void)refreshDataSourceWithCompletionHandler:(void (^)())completion {
    [self loadDataSource];

    if (completion)
        completion();
}
```

* and write all your ```UITableViewDataSource``` & ```UITableViewDelegate``` code:

```objective-c
#pragma mark UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"DefaultCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    cell.textLabel.text = [_dataSource objectAtIndex:indexPath.row];

    return cell;
}

```

* All that's left is to initialize the data source controller in your UIViewController and assign it to your UITableView ```dataSourceController``` property and you're ready to go!

```objective-c
#import "UITableView+DataSourceController.h"

@implementation MainViewController {
    IBOutlet UITableView *tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    // setup data source controller
    CustomDataSourceController *dataSourceCtrl = [[CustomDataSourceController alloc] init];
    dataSourceCtrl.tableView = tableView;
    dataSourceCtrl.viewController = self;
    tableView.dataSourceController = dataSourceCtrl;

    // load data source
    [tableView.dataSourceController refreshDataSourceWithCompletionHandler:nil];
}

@end
```

## Compatibility

* iOS 7 and iOS 8

## Credits

ABDataSourceController was created by [Alex Bumbu](https://github.com/alexbumbu).

## License

ABDataSourceController is available under the MIT license. See the LICENSE file for more info.
For usage without attribution contact [Alex Bumbu](mailto:alex.bumbu@gmail.com).