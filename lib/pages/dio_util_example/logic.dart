
import 'package:flutter_demo/utils/JsonUtil.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter_demo/http/entity/TestBean.dart';

import '../../http/dio_util/dio_util.dart';
import '../../http/entity/response_data.dart';
import 'state.dart';

class DioUtilExampleLogic extends GetxController {
  final DioUtilExampleState state = DioUtilExampleState();

  final String path = "weather/now.json";

  final CancelToken _cancelToken = CancelToken();

  void handleLogin() async {
    // 模拟用户退出页面
    // const _timeout = Duration(milliseconds: 2000);
    // Timer.periodic(_timeout, (timer) {
    //     DioUtil().cancelRequests(token: _cancelToken);
    // });

    // DioUtil().openLog();
    // DioUtil.getInstance()?.openLog();
    // DioUtil.CACHE_ENABLE = true;
    // DioUtil().setProxy(proxyAddress: "https://www.baidu.com", enable: true);


    var params = {
      "key": "cggcrov6aaevbrqm", //私钥
      // "key": "U671D5446C",//公钥
      "location": "hefei"
    };

    Options options = Options(extra: {'test':'1111'});

    DioUtil().get(path,queryParameters: params,options: options,(result){
      // print("result : \n ${result.data.toString()}");
      TestBean bean = TestBean.fromJson(result.data);
      state.text = JsonUtil.printJson(bean.toJson());
      // print("TestBean : \n ${bean.toJson()}");

      update();
    });

  }

}
