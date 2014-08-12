Pod::Spec.new do |s|


  s.name         = "SALQuickTutorial"
  s.version      = "0.0.1"
  s.summary      = "One-time-quick-tutorials to be shown as the user discovers your app"

  s.description  = <<-DESC
                   Show only once quick tutorials while users play with your app. Teach as they use, and not before using.
                   DESC

  s.homepage     = "https://github.com/seekingalpha/SALQuickTutorial"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.author             = { "Seeking Alpha" => "" }
  s.social_media_url   = "http://twitter.com/SeekingAlpha"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/seekingalpha/SALQuickTutorial.git", :commit => "25d3f34698a2b0d6426612da6655fe92d12522be" }
  s.source_files  = "SALQuickTutorial", "SALQuickTutorialViewController.{h,m,xib}"
  s.requires_arc = true
  s.dependency "MZFormSheetController", "~> 2.3"

end
