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
        body: GetBuilder<DioUtilExampleLogic>(builder: (logic) {
          return SizedBox(
              width: double.infinity,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => logic.handleLogin(),
                  child: Text("发送请求"),
                ),
                Expanded(child: Text(state.text))
              ]));
        }));
  }
}
