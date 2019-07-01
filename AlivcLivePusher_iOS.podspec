
Pod::Spec.new do |spec|

  spec.name         = "AlivcLivePusher_iOS"
  spec.summary      = "AlivcLivePusher_iOS"
  spec.homepage     = "https://help.aliyun.com/document_detail/61989.html"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       = { "aliyunvideo" => "videosdk@service.aliyun.com" }
  spec.version      = "3.4.0"
  spec.platform     = :ios
  spec.ios.deployment_target = "8.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  spec.source       = { :git => "https://github.com/wbcyclist/AlivcLivePusherSDK-iOS.git", :tag => "#{spec.version}" }
  spec.requires_arc = true
  spec.xcconfig = { "ENABLE_BITCODE" => "NO" }

  # spec.frameworks = "Accelerate", "AssetsLibrary", "AudioToolbox", "AVFoundation", "CoreMedia", "Foundation", "UIKit", "VideoToolbox"
  spec.vendored_frameworks = "AlivcLivePusher_iOS/AlivcLivePusher.framework",
                             "AlivcLivePusher_iOS/AlivcLibRtmp.framework",
                             "AlivcLivePusher_iOS/AlivcLibBeauty.framework",
                             "AlivcLivePusher_iOS/AlivcLibFace.framework"
  spec.resource = "AlivcLivePusher_iOS/AlivcLibFaceResource.bundle"

end