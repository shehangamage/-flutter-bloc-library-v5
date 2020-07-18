import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_v1_tutorial/bloc/SimpleBlocObserver.dart';
import 'package:flutter_bloc_v1_tutorial/bloc/weather_bloc.dart';
import 'package:flutter_bloc_v1_tutorial/data/weather_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'pages/weather_search_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Bloc.observer = SimpleBlocObserver();
    return MaterialApp(
      title: 'Weather App',
      home: BlocProvider(
        create: (context) => WeatherBloc(FakeWeatherRepository()),
        child: WeatherSearchPage(),
      ),
    );
  }
}
