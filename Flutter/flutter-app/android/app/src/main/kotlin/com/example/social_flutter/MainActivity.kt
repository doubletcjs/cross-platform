package com.example.yue_mei

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    /*
       通道名称： samples.flutter.dev/generate_userSig
       方法名： getUserSig
       参数名：
               userId 腾讯im，用户id
               appId 腾讯im，sdk appId
               secretKey 腾讯im，密钥
        */
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "samples.flutter.dev/generate_userSig").setMethodCallHandler {
            call, result ->
            if (call.method == "getUserSig") {
                var appId = call.argument<String>("appId")
                var userId = call.argument<String>("userId")
                var secretKey = call.argument<String>("secretKey")
                var userSig = GenerateUserSig.genUserSig(userId, appId, secretKey)

                result.success(userSig)
            } else {
                result.notImplemented();
            }
        }
    }
}
