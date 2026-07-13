import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_tracker/providers/weather_provider.dart';
import 'package:weather_tracker/repositories/weather_repository.dart';
import 'package:weather_tracker/services/weather_api_service.dart';
import 'package:weather_tracker/router/app_router.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WeatherProvider(
        WeatherRepository(
          WeatherService(),
        ),
      ),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
     routerConfig: appRouter,
    );
  }   
}