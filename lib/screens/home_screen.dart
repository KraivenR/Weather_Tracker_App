import 'package:flutter/material.dart';
import 'package:weather_tracker/screens/search_screen.dart';
import 'package:weather_tracker/services/weather_api_service.dart';
import 'package:weather_tracker/models/weather_model.dart';
import 'package:weather_tracker/widgets/weather_info.dart';
import 'package:weather_tracker/providers/weather_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  WeatherModel? weather;

  @override 
  //Tells flutter to run
  void initState() {
    //Sets the background first
    super.initState();
    //Tells Flutter to wait for the layout is built to input data
      Future.microtask(() {
    // Once the screen is ready, it is safe to fetch the weather data.
    context.read<WeatherProvider>().loadWeather('warsaw');
  });
  }

  Future<void> loadweather([String cityName = 'warsaw']) async {
    final data = await WeatherService.getWeather(cityName);

  setState (() {
    weather = data;
  });
}

String getWeatherImage() {
  if (weather == null) {
    return 'error loading';
  }
  final condition = weather!.condition.toString().toLowerCase();

  switch (condition) {
    case 'clear':
      return 'images/6.png';
    case 'clouds':
      return 'images/8.png';
    case 'rain':
      return 'images/3.png';
    case 'drizzle':
      return 'images/2.png';
    case 'thunderstorm':
      return 'images/1.png';
    case 'snow':
      return 'images/4.png';
    case 'mist':
    case 'fog':
    case 'haze':
      return 'images/5.png';
    case 'windy':
      return 'images/9.png';
    case 'partially cloudy':
      return 'images/7.png';
    default:
      return 'images/7.png';
  }
}

String formatTime(dynamic timestamp) {
    final seconds = int.tryParse(timestamp.toString()) ?? 0;
    final date = DateTime.fromMillisecondsSinceEpoch(seconds * 1000, isUtc: true).toLocal();
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  String formatCurrentTime() {
  final now = DateTime.now();
  final hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
  final minute = now.minute.toString().padLeft(2, '0');
  final period = now.hour >= 12 ? 'PM' : 'AM';
  return '$hour:$minute $period';
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(183, 1, 35, 61),
      appBar: AppBar(
        title: const Text('Weather Hunter'),
        actions: [IconButton(
          icon: const Icon(Icons.search, color: Color.fromARGB(255, 255, 255, 255), size: 40),
          onPressed: () async{
            final selectedCity = await Navigator.of(context).push<String>(
              MaterialPageRoute(builder: (_) => SearchScreen()),
            );
           if (selectedCity != null) {
              loadweather(selectedCity);
           }
          },
        )
        ],
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      
      
      body: weather ==null
      ?const Center( 
         child: CircularProgressIndicator(),
      
      )
      : Center(
        
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

            children: [
            Text(
              '📍${weather!.city}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
            Text(
              formatCurrentTime(),
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20,
              ),
            ),
            Image.asset(
              getWeatherImage(),
              width: 200,
              height: 200,
            ),
            Text(
              '🌡️ ${weather!.temperature.round()}°C.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
              Text(
                weather!.description,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                ),
              ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WeatherInfo(
                  icon: Icons.local_fire_department,
                  iconColor: const Color.fromARGB(179, 90, 5, 5),
                  title: 'Max Temp',
                  value: '${weather!.maxTemperature.round()}°C',
                ),
                WeatherInfo(
                  icon: Icons.ac_unit,
                  iconColor: const Color.fromARGB(255, 1, 255, 221),
                  title: 'Min Temp',
                  value: '${weather!.minTemperature.round()}°C',
                ),
              ],
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WeatherInfo(
                  icon: Icons.sunny,
                  iconColor: const Color.fromARGB(255, 160, 137, 5),
                  title: 'Sunrise',
                  value: formatTime(weather!.sunRise),
                ),
                WeatherInfo(
                  icon: Icons.air,
                  iconColor: Colors.white70,
                  title: 'Wind',
                  value: '${weather!.windSpeed.round()} km/h',
                ),
                WeatherInfo(
                  icon: Icons.nights_stay,
                  iconColor: const Color.fromARGB(255, 0, 12, 22),
                  title: 'Sunset',
                  value: formatTime(weather!.sunSet),
                ),
              ],
            ),
            ],
          ),
        ),
        )
    );

  }
}
