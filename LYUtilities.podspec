Pod::Spec.new do |s|
  s.name         = "LYUtilities"
  s.version      = "0.0.1"
  s.summary      = "Utilities"
  s.homepage     = "https://github.com/Hequnjie/LYUtilities"
  s.license      = 'MIT'
  s.author       = { "Hequnjie" => "360606411@qq.com" }
  s.platform     = :ios, "7.0"


  s.requires_arc = true

#s.source              = { :git => "https://github.com/Hequnjie/LYUtilities.git", :branch => "master" }
  s.source              = { :git => "https://github.com/Hequnjie/LYUtilities.git", :tag => "#{s.version}" }
  s.public_header_files = 'LYUtilities/LYUtilities/**/*.h'
  s.source_files        = "Classes", "LYUtilities/LYUtilities/**/*.{h,m}"
  s.exclude_files       = "LYUtilities/LYUtilities/**/*.plist"

end
