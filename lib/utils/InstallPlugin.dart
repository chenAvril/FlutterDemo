import 'dart:async';

import 'package:flutter/services.dart';

class InstallPlugin {
  static const MethodChannel _channel = MethodChannel('install_plugin');

  static Future<String?> installApk(String filePath, String appId) async {
    Map<String, String> params = {'filePath': filePath, 'appId': appId};
    return await _channel.invokeMethod('installApk', params);
  }

  ///   # 获取包信息
//   package_info: ^2.0.2
  ///  var packageInfo = await PackageInfo.fromPlatform();
//         InstallPlugin.installApk(apkPath, packageInfo.packageName);
}