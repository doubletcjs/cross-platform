import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = self.window.rootViewController
    let channel = FlutterMethodChannel(name: "samples.flutter.dev/generate_userSig", binaryMessenger: controller as! FlutterBinaryMessenger)
    channel.setMethodCallHandler { (call, result) in
        /*
          通道名称： samples.flutter.dev/generate_userSig
          方法名： getUserSig
          参数名：
                  userId 腾讯im，用户id
                  appId 腾讯im，sdk appId
                  secretKey 腾讯im，密钥

         iOS Runner/GenerateUserSig 文件夹
        */
        if (call.method == "getUserSig") {
            let dict: Dictionary<String,Any> = call.arguments as! Dictionary<String, Any>
            let userSig = GenerateUserSig.genUserSig(dict["userId"] as! String, withSdkAppID: dict["appId"] as! String, withSecretkey: dict["secretKey"] as! String)
            result("\(userSig)")
        }
    }
    
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
