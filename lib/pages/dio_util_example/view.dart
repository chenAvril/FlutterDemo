import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class DioUtilExamplePage extends StatelessWidget {
  DioUtilExamplePage({Key? key}) : super(key: key);

  final logic = Get.put(DioUtilExampleLogic());
  final state = Get.find<DioUtilExampleLogic>().state;

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
              onPressed: ()=>logic.handleLogin(),
              child: Text("发送请求"),
            ),
          ],
        ),
      ),
    );
  }
}
