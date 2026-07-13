import 'package:flutter/material.dart';
import 'package:weather_tracker/models/weather_model.dart';
import 'package:weather_tracker/repositories/weather_repository.dart';

//provider holds the state of the app
// when loading, when the weather is returned and when theres an error
class WeatherProvider extends ChangeNotifier {

  final WeatherRepository weatherRepository;

 
  WeatherProvider(this.weatherRepository);

  // Stores the current weather data.
  WeatherModel? weather;


  bool isLoading = false;

  String? errorMessage;

  Future<void> loadWeather(String cityName) async {
    // Start loading.
    isLoading = true;

    errorMessage = null;

    notifyListeners();

    try {
    
      weather = await weatherRepository.getWeather(cityName);

      errorMessage = null;
    } catch (e) {
      errorMessage = 'Failed to load weather data';

      weather = null;
    }
  //Fineshes loading whether successful or unsuccessful
    isLoading = false;

    notifyListeners();
  }
}