Pod::Spec.new do |s|
  s.name         = "ABMenuTableViewCell"
  s.version      = "1.0.0"
  s.summary      = "Solution for using your own custom view as a menu in an UITableView’s “swipe to delete”-menu gesture."
  s.homepage     = "https://github.com/alexbumbu/ABMenuTableViewCell"
  s.screenshots  = "https://raw.githubusercontent.com/alexbumbu/ABMenuTableViewCell/master/sample_1.png", "https://raw.githubusercontent.com/alexbumbu/ABMenuTableViewCell/master/sample_2.png"
  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = {"Alex Bumbu" => "https://github.com/alexbumbu"}
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/alexbumbu/ABMenuTableViewCell.git", :tag => "1.0.0" }
  s.source_files  = "ABMenuTableViewCell"
  s.requires_arc = true
end
