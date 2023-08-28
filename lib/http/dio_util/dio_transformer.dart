import 'dart:async';
import 'package:dio/dio.dart';

class DioTransformer extends BackgroundTransformer  {

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
    print("DioTransformer : transformRequest");
    return super.transformRequest(options);
  }

  ///表示拿到数据返回到拦截器前 统一做一次转化 添加
  @override
  Future transformResponse(RequestOptions options, ResponseBody response) async {
    // 例如我们响应选项里面没有自定义某些头部数据,那我们就可以自行添加
    // options.extra['myHeader'] = 'abc';
    print("DioTransformer : transformResponse");
    return super.transformResponse(options, response);
  }

}