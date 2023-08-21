
import 'package:flutter_demo/pages/dio_util_example/view.dart';
import 'package:get/get.dart';

/// 路由配置
class RouteConfig {

  static const String main = "/DioUtilExample";

  static final List<GetPage> getPages = [
    GetPage(name: main, page: () => DioUtilExamplePage()),

  ];
}
