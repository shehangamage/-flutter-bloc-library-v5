import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_v1_tutorial/data/model/weather.dart';
import 'package:flutter_bloc_v1_tutorial/data/weather_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends HydratedBloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    yield WeatherLoading();

    if (event is GetWeather) {
      try {
        final weather = await weatherRepository.fetchWeather(event.cityName);
        yield WeatherLoaded(weather);
      } on NetworkError {
        yield WeatherError("Couldn't fetch weather.");
      }
    } else if (event is GetDetailedWeather) {
      try {
        final weather = await weatherRepository.fetchDetailedWeather(event.cityName, event.temperatureCelsius);
        yield WeatherLoaded(weather);
      } on NetworkError {
        yield WeatherError("Couldn't fetch weather details.");
      }
    }
  }

  @override
  WeatherState fromJson(Map<String, dynamic> json) {
    try {
      final weather = Weather.fromJson(json);
      return WeatherLoaded(weather);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(WeatherState state) {
    if (state is WeatherLoaded) {
      return state.weather.toJson();
    } else {
      return null;
    }
  }
}
