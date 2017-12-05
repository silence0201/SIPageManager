Pod::Spec.new do |s|
  s.name         = "SIPageManager"
  s.version      = "0.1.0"
  s.summary      = "A Page Manager."
  s.description  = <<-DESC
                      A route page manager
                   DESC

  s.homepage     = "https://github.com/silence0201/SIPageManager"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Silence" => "374619540@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/silence0201/SIPageManager.git", :tag => "#{s.version}" }
  s.source_files  = "SIPageManager", "SIPageManager/**/*.{h,m}"
  s.exclude_files = "SIPageManager/Exclude"
  s.requires_arc = true
end
