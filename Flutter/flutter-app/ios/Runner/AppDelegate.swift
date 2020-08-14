import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, FlutterStreamHandler, JPUSHRegisterDelegate {
    //后台任务
    var backgroundTask: UIBackgroundTaskIdentifier! = nil
    var _eventSink: FlutterEventSink? = nil
    var _deviceToken: String = ""
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = self.window.rootViewController
    //消息发送器
    let eventChannel = FlutterEventChannel(name: "samples.flutter.dev/deviceToken", binaryMessenger: controller as! FlutterBinaryMessenger)
    eventChannel.setStreamHandler(self)
    
    //消息接收器
    let methodChannel = FlutterMethodChannel(name: "samples.flutter.dev/generate_userSig", binaryMessenger: controller as! FlutterBinaryMessenger)
    methodChannel.setMethodCallHandler { (call, result) in
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
    
    registerAppNotificationSettings(launchOptions: launchOptions as [NSObject:AnyObject]?)
    GeneratedPluginRegistrant.register(with: self)
    
    //极光
//    JPUSHService.setup(withOption: launchOptions, appKey: "51200258c600a8d9137e89c8", channel: "App Store", apsForProduction: true)
    //腾讯im
//    let config = TIMSdkConfig.init()
//    config.sdkAppId = 1400398568
//    TIMManager.sharedInstance()?.initSdk(config)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        _eventSink = events
        _eventSink!(_deviceToken)
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        _eventSink = nil
        return nil
    }
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
        //App 进入前台时上报切前台事件
        TIMManager.sharedInstance()?.doForeground({
            NSLog("doForegroud 成功");
        }, fail: { (code, msg) in
            NSLog("Fail: %\(code)-> \(String(describing: msg))")
        })
    }
    
    override func applicationDidEnterBackground(_ application: UIApplication) {
        //如果已存在后台任务，先将其设为完成
        if self.backgroundTask != nil {
            application.endBackgroundTask(self.backgroundTask)
            self.backgroundTask = UIBackgroundTaskIdentifier.invalid
        }
        
        //注册后台任务
        self.backgroundTask = application.beginBackgroundTask(expirationHandler: {
            () -> Void in
            //如果没有调用endBackgroundTask，时间耗尽时应用程序将被终止
            application.endBackgroundTask(self.backgroundTask)
            self.backgroundTask = UIBackgroundTaskIdentifier.invalid
        }) 
    }
    
    override func application(_ _application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0+String(format:"%02x",$1)})
        _deviceToken = deviceTokenString
        NSLog("deviceTokenString : %@", deviceTokenString);
        if _eventSink != nil {
            _eventSink!(_deviceToken)
        }
        
        //极光 注册 DeviceToken
        JPUSHService.registerVoipToken(deviceToken)
        //聊天 注册 DeviceToken Flutter 内实现 
    }
 
    override func application(_ _application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NSLog("deviceTokenString error %@", error.localizedDescription)
        _deviceToken = ""
    }

    private func registerAppNotificationSettings(launchOptions: [NSObject: AnyObject]?) {
        if #available(iOS 10.0, *) {
            let notifiCenter = UNUserNotificationCenter.current()
            notifiCenter.delegate = self
            let types = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
            notifiCenter.requestAuthorization(options: types) { (flag, error) in
                if flag {
                    NSLog("iOS request notification success")
                } else{
                    NSLog(" iOS 10 request notification fail")
                }
            }
        } else {
            //iOS8, iOS9注册通知
            let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories:nil)
            UIApplication.shared.registerUserNotificationSettings(setting)
        }

        UIApplication.shared.registerForRemoteNotifications()
    }
    //iOS10新增：处理前台收到通知的代理方法
    @available(iOS 10.0, *)
    func userNotificationCenter(center: UNUserNotificationCenter, willPresentNotification notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        NSLog("userInfo10:\(userInfo)")
        completionHandler([.sound, .alert])
    }

    //iOS10新增：处理后台点击通知的代理方法
    @available(iOS 10.0, *) 
    func userNotificationCenter(center: UNUserNotificationCenter, didReceiveNotificationResponse response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("userInfo10:\(userInfo)")
        UIApplication.shared.applicationIconBadgeNumber = 0
        completionHandler()
    }

    func application(application:UIApplication, didReceiveRemoteNotification userInfo: [NSObject:AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        NSLog("收到新消息Active\(userInfo)")
        if application.applicationState == UIApplication.State.active {
            // 代表从前台接受消息app
        } else {
            // 代表从后台接受消息后进入app
            UIApplication.shared.applicationIconBadgeNumber = 0
        }

        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(.newData)
    }
     
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        NSLog("收到新消息Active\(userInfo)")
        if application.applicationState == UIApplication.State.active {
            // 代表从前台接受消息app
        } else {
            // 代表从后台接受消息后进入app
            UIApplication.shared.applicationIconBadgeNumber = 0
        }

        JPUSHService.handleRemoteNotification(userInfo)
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo
        if notification.request.trigger!.isKind(of: UNPushNotificationTrigger.self) {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger!.isKind(of: UNPushNotificationTrigger.self) {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        
        completionHandler()
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification!) {
        
    }
    
    func jpushNotificationAuthorization(_ status: JPAuthorizationStatus, withInfo info: [AnyHashable : Any]!) {
        
    }
}
