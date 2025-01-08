import 'package:hive/hive.dart';

part 'weather_model.g.dart';

@HiveType(typeId: 0)
class WeatherModel extends HiveObject {
  @HiveField(0)
  final String cod;
  @HiveField(1)
  final int message;
  @HiveField(2)
  final int cnt;
  @HiveField(3)
  final List<Forecast> list;
  @HiveField(4)
  final int id;
  @HiveField(5)
  final String name;
  @HiveField(6)
  final Coord coord;
  @HiveField(7)
  final String country;
  @HiveField(8)
  final int population;
  @HiveField(9)
  final int timezone;
  @HiveField(10)
  final int sunrise;
  @HiveField(11)
  final int sunset;
  @HiveField(12)
  final DateTime updatedAt;

  WeatherModel({
    required this.cod,
    required this.message,
    required this.cnt,
    this.list = const [],
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
    required this.updatedAt,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cod: json['cod'],
      message: json['message'],
      cnt: json['cnt'],
      list: List<Forecast>.from(json['list'].map((x) => Forecast.fromJson(x))),
      id: json['city']['id'],
      name: json['city']['name'],
      coord: Coord.fromJson(json['city']['coord']),
      country: json['city']['country'],
      population: json['city']['population'],
      timezone: json['city']['timezone'],
      sunrise: json['city']['sunrise'],
      sunset: json['city']['sunset'],
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cod'] = cod;
    data['message'] = message;
    data['cnt'] = cnt;
    data['list'] = list.map((x) => x.toJson()).toList();
    data['city'] = {
      'id': id,
      'name': name,
      'coord': coord.toJson(),
      'country': country,
      'population': population,
      'timezone': timezone,
      'sunrise': sunrise,
      'sunset': sunset,
    };
    data['updatedAt'] = updatedAt.toIso8601String();
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherModel && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
  Forecast get currentWeather {
    final now = DateTime.now();
    final current = list.firstWhere(
      (element) {
        final dt = DateTime.fromMillisecondsSinceEpoch(element.dt * 1000);
        return dt.isAfter(now) || dt.isAtSameMomentAs(now);
      },
      orElse: () {
        return list.reduce((a, b) {
          final dtA = DateTime.fromMillisecondsSinceEpoch(a.dt * 1000);
          final dtB = DateTime.fromMillisecondsSinceEpoch(b.dt * 1000);
          return dtA.isAfter(dtB) ? a : b;
        });
      },
    );
    return current;
  }
}

@HiveType(typeId: 1)
class Forecast extends HiveObject {
  @HiveField(0)
  final int dt;
  @HiveField(1)
  final Main main;
  @HiveField(2)
  final List<Weather> weather;
  @HiveField(3)
  final int clouds;
  @HiveField(4)
  final Wind wind;
  @HiveField(5)
  final int visibility;
  @HiveField(6)
  final String dtTxt;

  Forecast({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.dtTxt,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      dt: json['dt'],
      main: Main.fromJson(json['main']),
      weather:
          List<Weather>.from(json['weather'].map((x) => Weather.fromJson(x))),
      clouds: json['clouds']['all'],
      wind: Wind.fromJson(json['wind']),
      visibility: json['visibility'],
      dtTxt: json['dt_txt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    data['main'] = main.toJson();
    data['weather'] = weather.map((x) => x.toJson()).toList();
    data["clouds"] = {"all": clouds};
    data['wind'] = wind.toJson();
    data['visibility'] = visibility;
    data['dt_txt'] = dtTxt;
    return data;
  }
}

@HiveType(typeId: 2)
class Main extends HiveObject {
  @HiveField(0)
  final num temp;
  @HiveField(1)
  final num feelsLike;
  @HiveField(2)
  final num tempMin;
  @HiveField(3)
  final num tempMax;
  @HiveField(4)
  final int pressure;
  @HiveField(5)
  final int seaLevel;
  @HiveField(6)
  final int grndLevel;
  @HiveField(7)
  final num humidity;
  @HiveField(8)
  final num tempKf;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'],
      feelsLike: json['feels_like'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
      pressure: json['pressure'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
      humidity: json['humidity'],
      tempKf: json['temp_kf'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['sea_level'] = seaLevel;
    data['grnd_level'] = grndLevel;
    data['humidity'] = humidity;
    data['temp_kf'] = tempKf;
    return data;
  }
}

@HiveType(typeId: 3)
class Weather extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String main;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}

@HiveType(typeId: 4)
class Wind extends HiveObject {
  @HiveField(0)
  final num speed;
  @HiveField(1)
  final int deg;
  @HiveField(2)
  final num gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'],
      deg: json['deg'],
      gust: json['gust'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    data['gust'] = gust;
    return data;
  }
}

@HiveType(typeId: 5)
class Coord extends HiveObject {
  @HiveField(0)
  final double lat;
  @HiveField(1)
  final double lon;

  Coord({
    required this.lat,
    required this.lon,
  });

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: json['lat'],
      lon: json['lon'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    return data;
  }
}
