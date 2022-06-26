
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/http/entity/test_bean.dart';

import 'dio_util/dio_method.dart';
import 'entity/response_data.dart';
import 'dio_util/dio_util.dart';
class DioUtilExample extends StatefulWidget {
  const DioUtilExample({Key? key}) : super(key: key);

  @override
  _DioUtilExampleState createState() => _DioUtilExampleState();
}

class _DioUtilExampleState extends State<DioUtilExample> {

  final String path = "weather/now.json";

  final CancelToken _cancelToken = CancelToken();

  void _handleLogin() async {
    // 模拟用户退出页面
    // const _timeout = Duration(milliseconds: 2000);
    // Timer.periodic(_timeout, (timer) {
    //     DioUtil().cancelRequests(token: _cancelToken);
    // });

    // DioUtil().openLog();
    // DioUtil.getInstance()?.openLog();
    // DioUtil.CACHE_ENABLE = true;
    // DioUtil().setProxy(proxyAddress: "https://www.baidu.com", enable: true);


    ResponseData<TestBean> result = await DioUtil().request(path, method: DioMethod.post, params: {
      "key": "cggcrov6aaevbrqm",//私钥
      // "key": "U671D5446C",//公钥
      "location": "hefei"
    }, cancelToken: _cancelToken);

    print("result : \n ${result.data}");
    // TestBean bean = TestBean.fromJson(result.data);
    // print("TestBean : \n ${result}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DioUtilExample"),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: _handleLogin,
              child: Text("发送请求"),
            ),
          ],
        ),
      ),
    );
  }
}
