Pod::Spec.new do |s|
  s.name         = "MockingUserDefaults"
  s.version      = "1.0.0"
  s.summary      = "NSUserDefaults replacement for tests to be independent from system"
  s.homepage     = "https://github.com/Klenkee/MockingUserDefaults"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Eike Klenk" => "eikeklenk@gmail.com" }
  s.source       = { :git => "https://github.com/Klenkee/MockingUserDefaults.git", :tag => "1.0.0" }
  s.source_files = "Classes", "Classes/*.{h,m}"
  s.platform     = :ios, "7.0"
  s.framework    = "Foundation"
  s.requires_arc = true
end
