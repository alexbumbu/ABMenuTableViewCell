# ABMenuTableViewCell

**Fully compatible with iOS 9**

Highly customizable, yet simple to use, solution for UITableViewCell right menu, shown by 'swipe to delete' gesture.

**Mail App Styled Menu - show & hide example:**

Without any extra work needed, showing the right menu view works with default swipe-to-delete gesture. Also, hiding the menu is done using known gestures like tapping or swiping back. 

![Screenshot](https://github.com/alexbumbu/ABMenuTableViewCell/blob/master/sample_mail_hide.gif)

**Mail App Styled Menu - delete item example:**

Deleting rows is as simple as the default implementation. 

![Screenshot](https://github.com/alexbumbu/ABMenuTableViewCell/blob/master/sample_mail_delete.gif)

**Custom Styled Menu - show, hide & delete example**

The advantage of using custom menus is that you're not stuck with Apple style buttons and you can easily integrate your own design.

![Screenshot](https://github.com/alexbumbu/ABMenuTableViewCell/blob/master/sample_custom_delete.gif)

## Integration

* Install via cocoapods (just add ```pod 'ABMenuTableViewCell', '~> 2.0'``` to your Podfile), or clone this repository and drag the content of ABMenuTableViewCell folder to your project.  
* To use you just need to replace UITableViewCell with ABMenuTableViewCell and assign your custom menu view to rightMenuView property and you're ready to go! You can take a look at the following snippet for details.

```objective-c
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"ABMenuTableViewCell";
    ABMenuTableViewCell *cell = (ABMenuTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];

    if (!cell) {
        cell = [[ABMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    // use your own custom menu view
    UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(.0, .0, 160.0, 44.0)];
    menuView.backgroundColor = [UIColor redColor];

    cell.rightMenuView = menuView;
    cell.textLabel.text = @"Lorem ipsum dolor sit amet";

    return cell;
}
```

## Compatibility

* iOS 7.x or newer

## Credits

ABMenuTableViewCell was created by [Alex Bumbu](https://github.com/alexbumbu).

## License

ABMenuTableViewCell is available under the MIT license. See the LICENSE file for more info.
For usage without attribution contact [Alex Bumbu](mailto:alex.bumbu@gmail.com).
