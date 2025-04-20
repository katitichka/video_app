class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final current = json['current_condition'][0];
    return Weather(
      cityName: json['nearest_area'][0]['areaName'][0]['value'],
      temperature: double.parse(current['temp_C']),
      mainCondition: current['weatherDesc'][0]['value'],
    );
  }
}
