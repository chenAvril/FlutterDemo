
// {"message":"请求成功啦","errorMsg":"0","data":"{results: [{location: {id: WTEMH46Z5N09, name: 合肥, country: CN, path: 合肥,合肥,安徽,中国, timezone: Asia/Shanghai, timezone_offset: +08:00}, now: {text: 阴, code: 9, temperature: 30}, last_update: 2022-06-26T22:42:34+08:00}]}"}

class ResponseData {

  /// 消息(例如成功消息文字/错误消息文字)
  String? message;
  /// 自定义code(可根据内部定义方式)
  int? code;
  /// 接口返回的数据
  dynamic data;
  /// 需要添加更多

  ResponseData.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? json['message'];
    code = json['code'];
    data = json['data'] ?? json["data"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = this.message;
    data['code'] = this.code;
    data['data'] = this.data;
    return data;
  }

  ResponseData({
    this.message,
    this.data,
    this.code,
  });

  @override
  String toString() {
    return """ResponseData :
    {
    message:$message ,
    code:$code ,
    data:$data 
    } """;
  }
}