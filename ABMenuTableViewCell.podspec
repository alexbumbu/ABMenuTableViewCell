Pod::Spec.new do |s|
  s.name         = "ABMenuTableViewCell"
  s.version      = "1.0.1"
  s.summary      = "Highly customizable, yet simple to use, solution for UITableViewCell right menu, shown by 'swipe to delete' gesture."
  s.homepage     = "https://github.com/alexbumbu/ABMenuTableViewCell"
  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = {"Alex Bumbu" => "https://github.com/alexbumbu"}
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/alexbumbu/ABMenuTableViewCell.git", :tag => "1.0.1" }
  s.source_files  = "ABMenuTableViewCell"
  s.requires_arc = true
end
