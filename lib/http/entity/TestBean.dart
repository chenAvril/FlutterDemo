class TestBean {
  List<Results>? results;

  TestBean({this.results});

  TestBean.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  Location? location;
  Now? now;
  String? lastUpdate;

  Results({this.location, this.now, this.lastUpdate});

  Results.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    now = json['now'] != null ? new Now.fromJson(json['now']) : null;
    lastUpdate = json['last_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.now != null) {
      data['now'] = this.now!.toJson();
    }
    data['last_update'] = this.lastUpdate;
    return data;
  }
}

class Location {
  String? id;
  String? name;
  String? country;
  String? path;
  String? timezone;
  String? timezoneOffset;

  Location(
      {this.id,
        this.name,
        this.country,
        this.path,
        this.timezone,
        this.timezoneOffset});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    path = json['path'];
    timezone = json['timezone'];
    timezoneOffset = json['timezone_offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country'] = this.country;
    data['path'] = this.path;
    data['timezone'] = this.timezone;
    data['timezone_offset'] = this.timezoneOffset;
    return data;
  }
}

class Now {
  String? text;
  String? code;
  String? temperature;

  Now({this.text, this.code, this.temperature});

  Now.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    code = json['code'];
    temperature = json['temperature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['code'] = this.code;
    data['temperature'] = this.temperature;
    return data;
  }
}
