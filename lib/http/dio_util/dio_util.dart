import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_demo/utils/LoadingUtils.dart';
import 'package:system_proxy/system_proxy.dart';

import 'dio_cache_interceptors.dart';
import 'dio_interceptors.dart';
import 'dio_transformer.dart';

/// 请求回调
typedef RequestCallback = void Function(dynamic result);

class DioUtil {
  /// 连接超时时间
  static const int CONNECT_TIMEOUT = 6 * 1000;

  /// 响应超时时间
  static const int RECEIVE_TIMEOUT = 6 * 1000;

  /// 发送超时时间
  static const int SEND_TIMEOUT = 6 * 1000;

  /// 请求的URL前缀
  static String BASE_URL = "https://api.seniverse.com/v3/";

  /// 是否开启网络缓存,默认false
  static bool CACHE_ENABLE = false;

  /// 最大缓存时间(按秒), 默认缓存七天,可自行调节
  static int MAX_CACHE_AGE = 7 * 24 * 60 * 60;

  /// 最大缓存条数(默认一百条)
  static int MAX_CACHE_COUNT = 100;

  static DioUtil? _instance;
  static Dio _dio = Dio();

  Dio get dio => _dio;

  DioUtil._internal() {
    _instance = this;
    _instance!._init();
  }

  factory DioUtil() => _instance ?? DioUtil._internal();

  static DioUtil? getInstance() {
    _instance ?? DioUtil._internal();
    return _instance;
  }

  ///请求的Content-Type，默认值是"application/json; charset=utf-8".
  /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
  // options.contentType=Headers.formUrlEncodedContentType;
  _init() {
    /// 初始化基本选项
    BaseOptions options = BaseOptions(
        baseUrl: BASE_URL,
        contentType: "application/json; charset=utf-8",
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
        sendTimeout: SEND_TIMEOUT);

    /// 初始化dio
    _dio = Dio(options);

    /// 添加拦截器
    _dio.interceptors.add(DioInterceptors());

    /// 添加转换器
    _dio.transformer = DioTransformer();

    /// 添加cookie管理器
    CookieJar cookieJar = CookieJar();
    _dio.interceptors.add(CookieManager(cookieJar));

    /// 添加缓存拦截器
    _dio.interceptors.add(DioCacheInterceptors());
  }

  ///代理抓包测试用
  void proxy() async {
    Map<String, String>? systemProxy = await SystemProxy.getProxySettings();
    if (systemProxy != null) {
      String? host = systemProxy["host"];
      String? port = systemProxy["port"];

      if (host?.isNotEmpty == true && port?.isNotEmpty == true) {
        (_dio.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = (client) {
          client.findProxy = (Uri uri) {
            return 'PROXY $host:$port';
          };
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) {
            return true;
          };
          return null;
        };
      } else {
        (_dio.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = (client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) {
            return true;
          };
        };
      }
    } else {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return true;
        };
      };
    }
  }

  /// 开启日志打印
  void openLog() {
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  /// get请求
  get(String path, RequestCallback onSuccess,
      {RequestCallback? onFail,
      queryParameters,
      options,
      onReceiveProgress}) async {
    try {
      CancelToken cancelToken = CancelToken();
      LoadingUtils.loading(onDismiss: () {
        print('get status : 1111111');
        cancelToken.cancel('请求已取消');
      });

      var response = await _dio.get(path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);

      LoadingUtils.dismiss();
      print('get cancelToken.isCancelled : ${cancelToken.isCancelled}');

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        if (onFail != null) {
          onFail(response.data ?? "");
        }
      }
    } on Exception catch (e){
      print('-----------------------------------------------------------------------------------------------------');
      print('get Exception : $e');
      print('-----------------------------------------------------------------------------------------------------');
      if(onFail != null){
        onFail(e);
      }
      // catch (e)
      // throw e;
    }
  }

  /// post请求
  post(String path, RequestCallback onSuccess,
      {RequestCallback? onFail,
      queryParameters,
      data,
      options,
      cancelToken,
      onSendProgress,
      onReceiveProgress}) async {
    var response = await _dio.post(path,
        data: data ?? {},
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
    if (response.statusCode == 200) {
      onSuccess(response.data);
    } else {
      if (onFail != null) {
        onFail(response.data ?? "");
      }
    }
  }

  /// 下载
  download(String urlPath, savePath, RequestCallback onSuccess,
      {RequestCallback? onFail,
      ProgressCallback? onReceiveProgress,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      bool deleteOnError = true,
      String lengthHeader = Headers.contentLengthHeader,
      data,
      Options? options}) async {
    var response = await _dio.download(urlPath, savePath,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        data: data,
        options: options);

    if (response.statusCode == 200) {
      onSuccess(response.data);
    } else {
      if (onFail != null) {
        onFail(response.data ?? "");
      }
    }
  }

  /// 上传
  put(String path, RequestCallback onSuccess,
      {RequestCallback? onFail,
      data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    var response = await _dio.put(path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);

    if (response.statusCode == 200) {
      onSuccess(response.data);
    } else {
      if (onFail != null) {
        onFail(response.data ?? "");
      }
    }
  }

  /// 取消请求token
  final CancelToken _cancelToken = CancelToken();
  /// 取消网络请求
  void cancelRequests({CancelToken? token}) {
    token ?? _cancelToken.cancel("cancelled");
  }
}
