Pod::Spec.new do |s|
  s.name = 'EasyTimer'
  s.version = '1.0.1'
  s.license = { :type => 'UA', :file => 'LICENSE' }
  s.summary = 'Easy way to use NSTimer in Swift for delaying code or repeating code'
  s.homepage = 'https://github.com/highbay/EasyTimer'
  s.authors = { 'Niklas Fahl' => 'niklas.fahl@ua.edu' }
  s.source = { git: 'https://github.com/highbay/EasyTimer.git', tag: s.version }
  s.requires_arc = true
  s.ios.deployment_target = '8.0'
  s.source_files = 'Sources/*.swift'
end
