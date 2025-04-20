import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:video_app/models/weather_model.dart';
import 'package:video_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService();
  Weather? _weather;

  _fetchWeather() async {
    try {
      String cityName = await _weatherService.getCurrentCity();
      print("🔍 Город по геолокации: $cityName");

      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print("Ошибка при получении погоды: $e");
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    final condition = mainCondition.toLowerCase();
    if (condition.contains('cloud')) return 'assets/cloud.json';
    if (condition.contains('rain')) return 'assets/rain.json';
    if (condition.contains('thunder')) return 'assets/thunder.json';
    if (condition.contains('clear') || condition.contains('sun')) return 'assets/sunny.json';

    return 'assets/sunny.json';
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: _weather == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_weather!.cityName, style: const TextStyle(fontSize: 24)),
                  Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
                  Text('${_weather!.temperature.round()}°C', style: const TextStyle(fontSize: 32)),
                  Text(_weather!.mainCondition, style: const TextStyle(fontSize: 20)),
                ],
              ),
      ),
    );
  }
}
