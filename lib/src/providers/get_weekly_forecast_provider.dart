import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fweather/src/models/weekly_weather.dart';
import 'package:fweather/src/services/api_helper.dart';

final weeklyForecastProvider = FutureProvider.autoDispose<WeeklyWeather>(
  (ref) => ApiHelper.getWeeklyForecast(),
);
