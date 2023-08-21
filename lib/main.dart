import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'RouteConfig.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String firstPage = RouteConfig.main;
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;

    return GetMaterialApp(
        title: 'Flutter Demo',
        initialRoute: firstPage,
        //初始路由，当⽤户进⼊程序时，⾃动打开对应的路由，低于home级别
        getPages: RouteConfig.getPages,
        theme: buildThemeData(),
        //自定义主题信息
        debugShowCheckedModeBanner: false,
        //去除调试时右上角Debug标签 EasyLoading.init() ,
        builder: (context, child) {
          child = EasyLoading.init().call(context, child);
          child = initFocusScope(context, child);
          return child;
        },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          //一定要配置,否则iphone手机长按编辑框有白屏卡着的bug出现
        ],
        supportedLocales: const [
          Locale('zh', 'CN'), //设置语言为中文
        ]);
  }

  Widget initFocusScope(context, child) => Scaffold(
    body: GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    ),
  );

  ThemeData buildThemeData() {
    return ThemeData(
      colorScheme: const ColorScheme.light()
          .copyWith(primary: Colors.blue, secondary: Colors.blue),
      primaryColor: Colors.blue,
      appBarTheme: const AppBarTheme(
          color: Colors.blue,
          // foregroundColor: Colors.black87,
          elevation: 1,
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500)),
      buttonTheme: ButtonThemeData(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
      // dividerColor: HDColors.divider,
      // cursorColor: HDColors.accent,
    );
  }
}
