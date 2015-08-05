Pod::Spec.new do |s|
  s.name         = "MockingUserDefaults"
  s.version      = "0.0.1"
  s.summary      = "NSUserDefaults replacement for tests to be independent from system"
  s.homepage     = "https://github.com/Klenkee/MockingUserDefaults"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Eike Klenk" => "eikeklenk@gmail.com" }
  s.source       = { :git => "https://github.com/Klenkee/MockingUserDefaults.git", :tag => "0.0.1" }
  s.source_files  = "Classes", "Classes/*.{h,m}"
  s.framework  = "Foundation"
  s.requires_arc = true
end
