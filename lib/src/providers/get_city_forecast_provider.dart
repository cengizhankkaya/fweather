import 'package:fweather/src/models/weather.dart';
import 'package:fweather/src/services/api_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cityForecastProvider = FutureProvider.autoDispose.family<Weather, String>(
  (ref, cityName) => ApiHelper.getWeatherByCityName(
    cityName: cityName,
  ),
);
