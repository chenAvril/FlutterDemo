import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

import 'LoadingUtils.dart';


///用sharedPreferences 缓存数据
class CacheUtil {
  static CacheUtil? _instance;
  SharedPreferences? _preferences;

  factory CacheUtil() => _instance ??= CacheUtil._initial();

  CacheUtil._initial(){
    init();
  }

  CacheUtil._pre(SharedPreferences prefs) {
    _preferences = prefs;
  }

  static Future<CacheUtil> perInit() async {
    if (_instance == null) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      _instance = CacheUtil._pre(preferences);
    }
    return _instance!;
  }

  void init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  void setString(key, value) {
    _preferences?.setString(key, value);
  }

  void setStringList(key, value) {
    _preferences?.setStringList(key, value);
  }

  void setBool(key, value) {
    _preferences?.setBool(key, value);
  }

  void setDouble(key, value) {
    _preferences?.setDouble(key, value);
  }

  void setInt(key, value) {
    _preferences?.setInt(key, value);
  }

  void setJson(key, value) {
    if(!(value is String)){
      value = jsonEncode(value);//json.encode(value);// convert.jsonEncode(value);//
    }
    //init();
    _preferences?.setString(key, value);
  }

  Map<String, dynamic>? getJson<T>(key) {
    String? result = _preferences?.getString(key);
    if (result != null && result.isNotEmpty) {
      return jsonDecode(result);
    }
    return null;
  }

  T? get<T>(key) {
    var result = _preferences?.get(key);
    if (result != null) {
      return result as T;
    }
    return null;
  }

  void clean() {
    _preferences?.clear();
  }

  void remove(key) {
    _preferences?.remove(key);
  }

  /// 获取缓存路径大小
  static loadCache() async {
    try {
      final _tempDir = await getTemporaryDirectory();
      double value = await _getTotalSizeOfFilesInDir(_tempDir);
      var size = _renderSize(value);
      return size;
    } catch (err) {
      return '';
    }
  }

  ///格式化文件大小
  static _renderSize(double value) {
    List<String> unitArr = ['B','KB','MB','GB'];
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  ///递归方式删除目录
  static Future<Null> _delDir(FileSystemEntity file) async {
    try {
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        for (final FileSystemEntity child in children) {
          await _delDir(child);
        }
      }
      await file.delete();
    } catch (e) {
      print(e);
    }
  }

  static Future<double> _getTotalSizeOfFilesInDir(
      final FileSystemEntity file) async {
    try {
      if (file is File) {
        int length = await file.length();
        return double.parse(length.toString());
      }
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        double total = 0;
        if (children != null)
          for (final FileSystemEntity child in children)
            total += await _getTotalSizeOfFilesInDir(child);
        return total;
      }
      return 0;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  /// 清楚缓存
  static clearCache() async {
    String size = '0.00B';
    try {
      final _tempDir = await getTemporaryDirectory();
      double value = await _getTotalSizeOfFilesInDir(_tempDir);
      if (value.toInt() <= 0) {
        LoadingUtils.showToast('暂无缓存');
      } else if (value > 0) {
        LoadingUtils.loading(status: '清理中···');
        await Future.delayed(Duration(seconds: 2), () async {
          //删除缓存目录
          await _delDir(_tempDir);
          return await loadCache();
        }).then((value){
          size = value;
          LoadingUtils.dismiss();
        });
      }
    } catch (e) {
      LoadingUtils.dismiss();
    } finally {
      return size;
    }
  }
}
