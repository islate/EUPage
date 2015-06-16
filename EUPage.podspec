Pod::Spec.new do |s|
  s.name             = "EUPage"
  s.version          = "0.1.0"
  s.summary          = "An easy way to show page."
  s.description      = <<-DESC
                       An easy way to show page. Support webpage,image,video pages. 
                       DESC
  s.homepage         = "https://github.com/mmslate/EUPage"
  s.license          = 'MIT'
  s.author           = { "andrew"=>"2005wangliqun@163.com" }
  s.source           = { :git => "https://github.com/mmslate/EUPage.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = '*.{h,m}'
  s.dependency 'SlateWebImageView', '~> 0.1.0'
end
