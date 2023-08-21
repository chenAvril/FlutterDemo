import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

///表示定义的导航页面
class HDNavigator {
  ///表示打开页面
  static Future<T?>? open<T>(
    dynamic page, {
    bool? opaque,
    Transition? transition,
    Curve? curve,
    Duration? duration,
    int? id,
    String? routeName,
    bool fullscreenDialog = false,
    dynamic arguments,
    Bindings? binding,
    bool preventDuplicates = true,
    bool? popGesture,
    double Function(BuildContext context)? gestureWidth,
  }) {
    return Get.to(page,
        opaque: opaque,
        transition: transition,
        curve: curve,
        duration: duration,
        id: id,
        routeName: routeName,
        fullscreenDialog: fullscreenDialog,
        arguments: arguments,
        binding: binding,
        preventDuplicates: preventDuplicates,
        popGesture: popGesture,
        gestureWidth: gestureWidth);
  }

  ///表示路由名字打开页面,用别名导航到新页面
  static Future<dynamic>? openToName(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    return Get.toNamed(
      page,
      arguments: arguments,
      id: id,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
    );
  }

  ///导航路由别名
  ///浏览并删除前一个页面。
  static void offName(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    Get.offNamed(
      page,
      arguments: arguments,
      id: id,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
    );
  }

  ///浏览并删除所有以前的页面。
  static void offAllNamed(String newRouteName, {dynamic arguments}) {
    Get.offAllNamed(newRouteName, arguments: arguments);
  }

  ///关闭  或页面 snackbars, dialogs, bottomsheets
  static void close<T>({
    T? result,
    bool closeOverlays = false,
    bool canPop = true,
    int? id,
  }) {
    Get.back(result: result, closeOverlays: closeOverlays, canPop: canPop, id: id);
  }

  ///进入下一个页面，但没有返回上一个页面的选项（用于闪屏页，登录页面等）
  static void off(dynamic page) {
    Get.off(page);
  }

  ///表示推出 重新登录
  static void logout() {
    // CacheUtil().setBool(GlobalConfig.LoginFlag, false);
    // CacheUtil().remove(GlobalConfig.LoginJson);
    // CacheUtil().remove("password");
    // 暂时先注释掉
    // CacheUtil().remove("mainUrl");

    // HDNavigator.offAllNamed(RouteConfig.login);
  }

}
