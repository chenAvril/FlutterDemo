import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';

class JsonUtil {
  //带有首行缩进的Json格式
  static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

  /// 单纯的Json格式输出打印
  static printJson(Object object) {
    String encoderString = '';
    try {
      encoderString = _encoder.convert(object);
      debugPrint(encoderString);
    } catch (e) {
      print('printJson catch : $e');
    }

    return encoderString;
  }

  /// 接收Dio请求库返回的Response对象
  static void printRespond(Response response) {
    Future((){
      Map httpLogMap = {};
      httpLogMap.putIfAbsent("requestUrl", () => '${response.requestOptions.baseUrl}${response.requestOptions.path}');
      httpLogMap.putIfAbsent("requestHeaders", () => response.headers.map);
      httpLogMap.putIfAbsent("requestQueryParameters", () => response.requestOptions.queryParameters);
      httpLogMap.putIfAbsent("requestData", () => response.requestOptions.data);
      httpLogMap.putIfAbsent("requestExtra", () => response.extra);
      httpLogMap.putIfAbsent("respondCode", () => response.statusCode);
      httpLogMap.putIfAbsent("respondMessage", () => response.statusMessage);
      httpLogMap.putIfAbsent("respondData", () => response.data);

      printJson(httpLogMap);
    });
  }
}