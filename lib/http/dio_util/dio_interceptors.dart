import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_demo/utils/JsonUtil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../entity/response_data.dart';

class DioInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 对非open的接口的请求参数全部增加userId
    // if (!options.path.contains("open")) {
    //   options.queryParameters["userId"] = "xxx";
    // }

    // 头部添加token
    // options.headers["token"] = "xxx";

    // 更多业务需求

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    JsonUtil.printRespond(response);

    response.extra = response.requestOptions.extra;

    // 请求成功是对数据做基本处理
    if (response.statusCode == 200) {
      response.data = ResponseData(code: 0, message: "请求成功啦", data: response.data);
    } else {
      response.data = ResponseData(code: 1, message: "请求失败啦", data: response.data);
    }

    // if (response.data != null && response.data is String && response.data != '') {
    //   response.data = jsonDecode(response.data);
    // }

    // 对某些单独的url返回数据做特殊处理
    if (response.requestOptions.baseUrl.contains("???????")) {
      //....
    }

    // 根据公司的业务需求进行定制化处理

    // 重点
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
      print('DioInterceptors onError : ${err.error}\t\t\t${err.message}');

      switch (err.type) {
        // 连接服务器超时
        case DioExceptionType.connectionTimeout:
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
          break;
        // 响应超时
        case DioExceptionType.receiveTimeout:
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
          break;
        // 发送超时
        case DioExceptionType.sendTimeout:
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
          break;
        // 请求取消
        case DioExceptionType.cancel:
          // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
          break;
        case DioExceptionType.badCertificate:
          break;
        case DioExceptionType.badResponse:
          break;
        case DioExceptionType.connectionError:
          break;
        case DioExceptionType.unknown:
          break;
      }
      //用 hander.resolve 返回处理异常之后的结果 err.response
      var data = ResponseData(code: 1, message: "请求失败啦", data: {});

      // 使用响应对象完成请求，将不会执行其他错误拦截器。这将被视为一个成功的请求！[响应]：要返回的响应对象
      handler.resolve(Response(data: data, requestOptions: err.requestOptions));
  }

}
