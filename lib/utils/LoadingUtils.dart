import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

///加载框和弹出框
class LoadingUtils {
  ///表示普通的toast 不带图标
  static showToast(String msg) {
    EasyLoading.showToast(msg);
  }

  ///表示展示 展示警告 吐司
  static showInfo(String msg) {
    // if(ApiConfig.currentNetWork!="pro") {
    //   showNetWorkInfo(msg);
    // }else{
    //   AlertDialog(msg, title: "提示");
    // }
    AlertDialog(msg, title: "提示");
    //EasyLoading.showInfo(msg);
  }

  ///表示展示 展示警告 吐司
  static showNetWorkInfo(String msg) {
    AlertDialog(
        msg,
        title: "提示",
        controlNerError: true,
        onWillPop: () async {
          NetErrorDialogShow = false;
          return true;
        }
    );
  }

  ///表示展示 展示警告 吐司
  static warnInfo(String msg) {
    AlertDialog(msg, title: "提示");
    //EasyLoading.showInfo(msg);
  }

  ///loading 有模态加载框
  static loading({
    String? status = "查询中",
    Widget? indicator,
    EasyLoadingMaskType? maskType = EasyLoadingMaskType.black,
    bool? dismissOnTap,
  }) {
    EasyLoading.show(
        status: status,
        indicator: indicator,
        maskType: maskType,
        dismissOnTap: false);
  }

  ///表示展示成功的吐司
  static showSuccess(String msg) {
    EasyLoading.showSuccess(msg);
  }

  ///表示展示失败的吐司
  static showError(String msg) {
    EasyLoading.showError(msg);
  }

  ///表示展示进度  value 值范围 0-1
  static showProgress(double value) {
    EasyLoading.showProgress(value);
  }

  /// 关闭loading，，添加了dismissCallback后需要removeCallback
  static dismiss() {
    EasyLoading.dismiss();
  }

  static InputDialog(String msg,
      {String title = "提示:",
      String textConfirm = "确认",
      bool isMust = false,
      bool confirmBack = true,
      Function(dynamic arg)? onConfirm}) {
    TextEditingController _effectiveController =
        TextEditingController(text: msg);
    Widget widget = TextField(
      cursorColor: Colors.black,
      cursorWidth: 2.0,
      controller: _effectiveController,
      onChanged: (value) {
        msg = value;
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(300),
      ],
      decoration: InputDecoration(
        border: InputBorder.none,
        isDense: true,
      ),
      maxLines: 8,
      minLines: 3,
      autofocus: true,
    );
    AlertDialog("", title: title,confirmBack: confirmBack, onConfirm: () {
      if(isMust && _effectiveController.text.isEmpty){
        LoadingUtils.showToast('请输入');
        return;
      }

      if(!confirmBack){
        Get.back();
      }

      onConfirm?.call(msg);
    },
        content: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          constraints: BoxConstraints(maxHeight: 300),
          child: widget,
        ));
  }

  static bool NetErrorDialogShow = false;
  ///adaptive_dialog、giffy_dialog  # 弹框提示  去封装
  ///
  ///表示弹框---带扩展
  static AlertDialog(String msg,
      {
        String title = "提示",
        String textConfirm = "确认",
        String? textCancel,
        VoidCallback? onConfirm,
        VoidCallback? onCancel,
        Widget? content,
        bool barrierDismissible = true,
        bool confirmBack = true,
        WillPopCallback? onWillPop,
        bool controlNerError = false,
      }) {
    if(controlNerError){
      if(NetErrorDialogShow){
        return;
      }else{
        NetErrorDialogShow = true;
      }
    }

    if (textCancel != null) {
      Get.defaultDialog(
        title: title,
        radius: 8,
        barrierDismissible:barrierDismissible,
        onWillPop:onWillPop,
        titlePadding: const EdgeInsets.only(top: 20, bottom: 0),
        content: content ??
            Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Text(msg,
                    textAlign: TextAlign.center,
                    maxLines: 8,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black))),
        contentPadding: const EdgeInsets.all(0),
        actions: [
          SizedBox(
              width: 600,// 给double.infinity会报错，暂时先给死
              child: Column(children: [
                const Divider(height: 1, color: Colors.grey),
                IntrinsicHeight(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if(controlNerError){
                                NetErrorDialogShow = false;
                              }
                              Get.back();
                              onCancel?.call();
                            },
                            child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  textCancel,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue),
                                )),
                          )),
                      const VerticalDivider(width: 1, color: Colors.grey),
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if(controlNerError){
                                NetErrorDialogShow = false;
                              }
                              if(confirmBack){
                                Get.back();
                              }

                              onConfirm?.call();
                            },
                            child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  textConfirm,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue),
                                )),
                          ))
                    ]))
              ]))
        ],
      );
    } else {
      Get.defaultDialog(
          title: title,
          radius: 8,
          barrierDismissible:barrierDismissible,
          onWillPop:onWillPop,
          titlePadding: const EdgeInsets.only(top: 20, bottom: 0),
          confirm: Column(
            children: [
              const Divider(height: 1, color: Colors.grey),
              InkWell(
                onTap: () {
                  if(controlNerError){
                    NetErrorDialogShow = false;
                  }
                  if(confirmBack){
                    Get.back();
                  }

                  onConfirm?.call();
                },
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      textConfirm,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blue),
                    )),
              ),
            ],
          ),
          buttonColor: Colors.white,
          confirmTextColor: Colors.blue,
          content: content ??
              Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Text(msg,
                      maxLines: 8,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black))),
          contentPadding: const EdgeInsets.all(0)
          // onConfirm: () => {
          //   Get.back(),
          //   onConfirm?.call(),
          // },
          );
    }
  }
}
