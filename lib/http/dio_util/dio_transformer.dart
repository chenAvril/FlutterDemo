import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// 必须是顶层函数
_parseAndDecode(String response) {
  // print("_parseAndDecode");
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

class DioTransformer extends DefaultTransformer {

  ///表示请求时做一些转化或校验之类的
  @override
  Future<String> transformRequest(RequestOptions options) async {
    // 如果请求的数据接口是List<String>那我们直接抛出异常
    // if (options.data is List<String>) {
    //   throw DioError(
    //     error: "你不能直接发送List数据到服务器",
    //     requestOptions: options,
    //   );
    // } else {
    // }
    // print("transformRequest");
    return super.transformRequest(options);
  }

  ///表示拿到数据返回到拦截器前 统一做一次转化 添加
  @override
  Future transformResponse(RequestOptions options, ResponseBody response) async {
    // 例如我们响应选项里面没有自定义某些头部数据,那我们就可以自行添加
    // options.extra['myHeader'] = 'abc';
    // print("transformResponse");
    return super.transformResponse(options, response);
  }

  ///统一把 json格式串字符串转换成MAP
  @override
  // TODO: implement jsonDecodeCallback
  JsonDecodeCallback? get jsonDecodeCallback =>parseJson;// super.jsonDecodeCallback;
}