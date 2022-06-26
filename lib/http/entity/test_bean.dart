import 'dart:convert';
/// results : [{"location":{"id":"C23NB62W20TF","name":"西雅图","country":"US","path":"西雅图,华盛顿州,美国","timezone":"America/Los_Angeles","timezone_offset":"-07:00"},"now":{"text":"多云","code":"4","temperature":"14","feels_like":"14","pressure":"1018","humidity":"76","visibility":"16.09","wind_direction":"西北","wind_direction_degree":"340","wind_speed":"8.05","wind_scale":"2","clouds":"90","dew_point":"-12"},"last_update":"2015-09-25T22:45:00-07:00"}]

TestBean testBeanFromJson(String str) => TestBean.fromJson(json.decode(str));
String testBeanToJson(TestBean data) => json.encode(data.toJson());
class TestBean {
  TestBean({
      List<Results>? results,}){
    _results = results;
}

  TestBean.fromJson(dynamic json) {
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Results.fromJson(v));
      });
    }
  }
  List<Results>? _results;
TestBean copyWith({  List<Results>? results,
}) => TestBean(  results: results ?? _results,
);
  List<Results>? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// location : {"id":"C23NB62W20TF","name":"西雅图","country":"US","path":"西雅图,华盛顿州,美国","timezone":"America/Los_Angeles","timezone_offset":"-07:00"}
/// now : {"text":"多云","code":"4","temperature":"14","feels_like":"14","pressure":"1018","humidity":"76","visibility":"16.09","wind_direction":"西北","wind_direction_degree":"340","wind_speed":"8.05","wind_scale":"2","clouds":"90","dew_point":"-12"}
/// last_update : "2015-09-25T22:45:00-07:00"

Results resultsFromJson(String str) => Results.fromJson(json.decode(str));
String resultsToJson(Results data) => json.encode(data.toJson());
class Results {
  Results({
      Location? location, 
      Now? now, 
      String? lastUpdate,}){
    _location = location;
    _now = now;
    _lastUpdate = lastUpdate;
}

  Results.fromJson(dynamic json) {
    _location = json['location'] != null ? Location.fromJson(json['location']) : null;
    _now = json['now'] != null ? Now.fromJson(json['now']) : null;
    _lastUpdate = json['last_update'];
  }
  Location? _location;
  Now? _now;
  String? _lastUpdate;
Results copyWith({  Location? location,
  Now? now,
  String? lastUpdate,
}) => Results(  location: location ?? _location,
  now: now ?? _now,
  lastUpdate: lastUpdate ?? _lastUpdate,
);
  Location? get location => _location;
  Now? get now => _now;
  String? get lastUpdate => _lastUpdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    if (_now != null) {
      map['now'] = _now?.toJson();
    }
    map['last_update'] = _lastUpdate;
    return map;
  }

}

/// text : "多云"
/// code : "4"
/// temperature : "14"
/// feels_like : "14"
/// pressure : "1018"
/// humidity : "76"
/// visibility : "16.09"
/// wind_direction : "西北"
/// wind_direction_degree : "340"
/// wind_speed : "8.05"
/// wind_scale : "2"
/// clouds : "90"
/// dew_point : "-12"

Now nowFromJson(String str) => Now.fromJson(json.decode(str));
String nowToJson(Now data) => json.encode(data.toJson());
class Now {
  Now({
      String? text, 
      String? code, 
      String? temperature, 
      String? feelsLike, 
      String? pressure, 
      String? humidity, 
      String? visibility, 
      String? windDirection, 
      String? windDirectionDegree, 
      String? windSpeed, 
      String? windScale, 
      String? clouds, 
      String? dewPoint,}){
    _text = text;
    _code = code;
    _temperature = temperature;
    _feelsLike = feelsLike;
    _pressure = pressure;
    _humidity = humidity;
    _visibility = visibility;
    _windDirection = windDirection;
    _windDirectionDegree = windDirectionDegree;
    _windSpeed = windSpeed;
    _windScale = windScale;
    _clouds = clouds;
    _dewPoint = dewPoint;
}

  Now.fromJson(dynamic json) {
    _text = json['text'];
    _code = json['code'];
    _temperature = json['temperature'];
    _feelsLike = json['feels_like'];
    _pressure = json['pressure'];
    _humidity = json['humidity'];
    _visibility = json['visibility'];
    _windDirection = json['wind_direction'];
    _windDirectionDegree = json['wind_direction_degree'];
    _windSpeed = json['wind_speed'];
    _windScale = json['wind_scale'];
    _clouds = json['clouds'];
    _dewPoint = json['dew_point'];
  }
  String? _text;
  String? _code;
  String? _temperature;
  String? _feelsLike;
  String? _pressure;
  String? _humidity;
  String? _visibility;
  String? _windDirection;
  String? _windDirectionDegree;
  String? _windSpeed;
  String? _windScale;
  String? _clouds;
  String? _dewPoint;
Now copyWith({  String? text,
  String? code,
  String? temperature,
  String? feelsLike,
  String? pressure,
  String? humidity,
  String? visibility,
  String? windDirection,
  String? windDirectionDegree,
  String? windSpeed,
  String? windScale,
  String? clouds,
  String? dewPoint,
}) => Now(  text: text ?? _text,
  code: code ?? _code,
  temperature: temperature ?? _temperature,
  feelsLike: feelsLike ?? _feelsLike,
  pressure: pressure ?? _pressure,
  humidity: humidity ?? _humidity,
  visibility: visibility ?? _visibility,
  windDirection: windDirection ?? _windDirection,
  windDirectionDegree: windDirectionDegree ?? _windDirectionDegree,
  windSpeed: windSpeed ?? _windSpeed,
  windScale: windScale ?? _windScale,
  clouds: clouds ?? _clouds,
  dewPoint: dewPoint ?? _dewPoint,
);
  String? get text => _text;
  String? get code => _code;
  String? get temperature => _temperature;
  String? get feelsLike => _feelsLike;
  String? get pressure => _pressure;
  String? get humidity => _humidity;
  String? get visibility => _visibility;
  String? get windDirection => _windDirection;
  String? get windDirectionDegree => _windDirectionDegree;
  String? get windSpeed => _windSpeed;
  String? get windScale => _windScale;
  String? get clouds => _clouds;
  String? get dewPoint => _dewPoint;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    map['code'] = _code;
    map['temperature'] = _temperature;
    map['feels_like'] = _feelsLike;
    map['pressure'] = _pressure;
    map['humidity'] = _humidity;
    map['visibility'] = _visibility;
    map['wind_direction'] = _windDirection;
    map['wind_direction_degree'] = _windDirectionDegree;
    map['wind_speed'] = _windSpeed;
    map['wind_scale'] = _windScale;
    map['clouds'] = _clouds;
    map['dew_point'] = _dewPoint;
    return map;
  }

}

/// id : "C23NB62W20TF"
/// name : "西雅图"
/// country : "US"
/// path : "西雅图,华盛顿州,美国"
/// timezone : "America/Los_Angeles"
/// timezone_offset : "-07:00"

Location locationFromJson(String str) => Location.fromJson(json.decode(str));
String locationToJson(Location data) => json.encode(data.toJson());
class Location {
  Location({
      String? id, 
      String? name, 
      String? country, 
      String? path, 
      String? timezone, 
      String? timezoneOffset,}){
    _id = id;
    _name = name;
    _country = country;
    _path = path;
    _timezone = timezone;
    _timezoneOffset = timezoneOffset;
}

  Location.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _country = json['country'];
    _path = json['path'];
    _timezone = json['timezone'];
    _timezoneOffset = json['timezone_offset'];
  }
  String? _id;
  String? _name;
  String? _country;
  String? _path;
  String? _timezone;
  String? _timezoneOffset;
Location copyWith({  String? id,
  String? name,
  String? country,
  String? path,
  String? timezone,
  String? timezoneOffset,
}) => Location(  id: id ?? _id,
  name: name ?? _name,
  country: country ?? _country,
  path: path ?? _path,
  timezone: timezone ?? _timezone,
  timezoneOffset: timezoneOffset ?? _timezoneOffset,
);
  String? get id => _id;
  String? get name => _name;
  String? get country => _country;
  String? get path => _path;
  String? get timezone => _timezone;
  String? get timezoneOffset => _timezoneOffset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['country'] = _country;
    map['path'] = _path;
    map['timezone'] = _timezone;
    map['timezone_offset'] = _timezoneOffset;
    return map;
  }

}