

/// 请求成功回调
typedef RequestCallback<T> = void Function(dynamic result);

class HDHttp {

  /// get请求
  static get(String path, RequestCallback onSuccess,
      {RequestCallback? onError,
        queryParameters,
        options,
        cancelToken,
        onReceiveProgress}) async {
    // ResponseData response = await DioClient().doGet(path,
    //     queryParameters: queryParameters,
    //     options: options,
    //     cancelToken: cancelToken,
    //     onReceiveProgress: onReceiveProgress);
    // if (response.isok) {
    //   onSuccess(response.data);
    // } else {
    //   if(onError != null){
    //     onError(response.msg ?? "");
    //   }
    // }
  }

  /// post请求
  static post(String path, RequestCallback onSuccess,
      {RequestCallback? onError,
      queryParameters,
      data,
      options,
      cancelToken,
      onSendProgress,
      onReceiveProgress}) async {
    // ResponseData response = await DioClient().doPost(path,
    //     queryParameters: queryParameters,
    //     options: options,
    //     data: data ?? {},
    //     cancelToken: cancelToken,
    //     onSendProgress: onSendProgress,
    //     onReceiveProgress: onReceiveProgress);
    // if (response.isok) {
    //   onSuccess(response.data);
    // } else {
    //   if(onError != null){
    //     onError(response.msg ?? "");
    //   }
    // }
  }
}
