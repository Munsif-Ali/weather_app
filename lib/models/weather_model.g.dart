// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherModelAdapter extends TypeAdapter<WeatherModel> {
  @override
  final int typeId = 0;

  @override
  WeatherModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherModel(
      cod: fields[0] as String,
      message: fields[1] as int,
      cnt: fields[2] as int,
      list: (fields[3] as List).cast<Forecast>(),
      id: fields[4] as int,
      name: fields[5] as String,
      coord: fields[6] as Coord,
      country: fields[7] as String,
      population: fields[8] as int,
      timezone: fields[9] as int,
      sunrise: fields[10] as int,
      sunset: fields[11] as int,
      updatedAt: fields[12] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.cod)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.cnt)
      ..writeByte(3)
      ..write(obj.list)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.coord)
      ..writeByte(7)
      ..write(obj.country)
      ..writeByte(8)
      ..write(obj.population)
      ..writeByte(9)
      ..write(obj.timezone)
      ..writeByte(10)
      ..write(obj.sunrise)
      ..writeByte(11)
      ..write(obj.sunset)
      ..writeByte(12)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ForecastAdapter extends TypeAdapter<Forecast> {
  @override
  final int typeId = 1;

  @override
  Forecast read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Forecast(
      dt: fields[0] as int,
      main: fields[1] as Main,
      weather: (fields[2] as List).cast<Weather>(),
      clouds: fields[3] as int,
      wind: fields[4] as Wind,
      visibility: fields[5] as int,
      dtTxt: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Forecast obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.dt)
      ..writeByte(1)
      ..write(obj.main)
      ..writeByte(2)
      ..write(obj.weather)
      ..writeByte(3)
      ..write(obj.clouds)
      ..writeByte(4)
      ..write(obj.wind)
      ..writeByte(5)
      ..write(obj.visibility)
      ..writeByte(6)
      ..write(obj.dtTxt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForecastAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MainAdapter extends TypeAdapter<Main> {
  @override
  final int typeId = 2;

  @override
  Main read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Main(
      temp: fields[0] as num,
      feelsLike: fields[1] as num,
      tempMin: fields[2] as num,
      tempMax: fields[3] as num,
      pressure: fields[4] as int,
      seaLevel: fields[5] as int,
      grndLevel: fields[6] as int,
      humidity: fields[7] as num,
      tempKf: fields[8] as num,
    );
  }

  @override
  void write(BinaryWriter writer, Main obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.temp)
      ..writeByte(1)
      ..write(obj.feelsLike)
      ..writeByte(2)
      ..write(obj.tempMin)
      ..writeByte(3)
      ..write(obj.tempMax)
      ..writeByte(4)
      ..write(obj.pressure)
      ..writeByte(5)
      ..write(obj.seaLevel)
      ..writeByte(6)
      ..write(obj.grndLevel)
      ..writeByte(7)
      ..write(obj.humidity)
      ..writeByte(8)
      ..write(obj.tempKf);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeatherAdapter extends TypeAdapter<Weather> {
  @override
  final int typeId = 3;

  @override
  Weather read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Weather(
      id: fields[0] as int,
      main: fields[1] as String,
      description: fields[2] as String,
      icon: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Weather obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.main)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WindAdapter extends TypeAdapter<Wind> {
  @override
  final int typeId = 4;

  @override
  Wind read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Wind(
      speed: fields[0] as num,
      deg: fields[1] as int,
      gust: fields[2] as num,
    );
  }

  @override
  void write(BinaryWriter writer, Wind obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.speed)
      ..writeByte(1)
      ..write(obj.deg)
      ..writeByte(2)
      ..write(obj.gust);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WindAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CoordAdapter extends TypeAdapter<Coord> {
  @override
  final int typeId = 5;

  @override
  Coord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Coord(
      lat: fields[0] as double,
      lon: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Coord obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.lon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
