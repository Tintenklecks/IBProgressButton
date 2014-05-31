Pod::Spec.new do |s|
  s.name         = 'IBProgressButton'
  s.version      = '1.0'
  s.license          =  { :type => 'MIT', :file => 'LICENSE' }
  s.homepage     = 'https://github.com/Tintenklecks/IBProgressButton'
  s.authors      =  {'Ingo' => 'github@puco.de'}
  s.summary      = 'A combination of a circular progress view and a button'

# Source Info
  s.platform     =  :ios, '5.0'
  s.source       =  {:git => 'https://github.com/Tintenklecks/IBProgressButton.git', :tag => '1.0'}
  s.source_files = 'classes/*.{h,m}'

  s.requires_arc = true
  

end