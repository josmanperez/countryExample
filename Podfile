# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
def shared_pods
  use_frameworks!
  pod 'Alamofire', '~> 4.8.2'
  pod 'Kingfisher', '~> 5.0'
  pod 'ReachabilitySwift'
end

target 'CountryExample' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CountryExample
  shared_pods

  target 'CountryExampleTests' do
    inherit! :search_paths
    # Pods for testing
    shared_pods
  end

end
