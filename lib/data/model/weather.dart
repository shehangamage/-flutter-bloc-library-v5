import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather extends Equatable {
  final String cityName;
  final double temperatureCelsius;
  final double temperatureFahrenheit;

  Weather({
    @required this.cityName,
    @required this.temperatureCelsius,
    this.temperatureFahrenheit,
  });

  @override
  List<Object> get props => [
    cityName,
    temperatureCelsius,
    temperatureFahrenheit
  ];

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);
  Map<String, dynamic> toJson()=>_$WeatherToJson(this);

}
