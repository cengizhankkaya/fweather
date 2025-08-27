import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fweather/src/models/hourly_weather.dart';
import 'package:fweather/src/services/api_helper.dart';

final hourlyForecastProvider = FutureProvider.autoDispose<HourlyWeather>(
  (ref) => ApiHelper.getHourlyForecast(),
);
