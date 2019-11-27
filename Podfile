platform :ios, '10.0'
use_frameworks!

workspace 'SteamAnalytics.xcworkspace'

def corestore_pod
	pod 'CoreStore', '7.0.1'
end

def snapkit_pod
	pod 'SnapKit', '5.0.1'
end

def kingfisher_pod
	pod 'Kingfisher', '5.10.1'
end

def alamofire_pod
  pod 'Alamofire', '~> 5.0.0-rc.3'
end

target 'SteamAnalyticsApp' do
  project 'App/App.xcodeproj'

  snapkit_pod
  alamofire_pod
  corestore_pod
end

target 'Services' do
  project 'Services/Services.xcodeproj'

  corestore_pod
end

target 'UICommon' do
  project 'UICommon/UICommon.xcodeproj'

  snapkit_pod
end


target 'APIClient' do
  project 'APIClient/APIClient.xcodeproj'

  alamofire_pod
end

target 'Storages' do
  project 'Storages/Storages.xcodeproj'

  corestore_pod
end

target 'StoragesUnitTests' do
  project 'Storages/Storages.xcodeproj'

  corestore_pod
end
