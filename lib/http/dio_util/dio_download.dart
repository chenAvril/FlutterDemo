import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import '../../utils/LoadingUtils.dart';

class Download {
  /// 下载
  ///
  /// [url] 下载地址
  /// [path] 存储位置
  /// [onProgress] 进度监听方法 参数为进度 0～1
  /// [cancelToken] 取消下载的token
  ///
  /// 返回值为是否成功
  ///
  Future<bool> down({
    required String url,
    required String path,
    required Function(double) onProgress,
    CancelToken? cancelToken,
  }) async {
    var dio = Dio();
    // 跳过https ssl证书校验
    // (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //   client.badCertificateCallback = (cert, host, port) {
    //     return true;
    //   };
    // };
    try {
      var responst = await dio.download(url, path, onReceiveProgress: (received, total) {
        if (total == -1) {
          onProgress(0.0);
        } else {
          onProgress(received / total);
        }
      }, cancelToken: cancelToken);
      if (kDebugMode) {
        print(responst);
      }

      if (responst.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception {
      return false;
    }
  }

  /// 下载图片
  downloadImage(String url) async {
    if (await Permission.storage.request().isGranted) {
      LoadingUtils.loading(status: '下载中');
      var response = await Dio()
          .get(url, options: Options(responseType: ResponseType.bytes));
      final result =
          await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
      LoadingUtils.dismiss();
      if (result["isSuccess"] ?? false) {
        LoadingUtils.showToast("下载成功");
      } else {
        LoadingUtils.showToast("下载失败");
      }
    } else {
      LoadingUtils.showToast("未获取存储权限");
    }
  }
}
