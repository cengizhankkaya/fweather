import 'package:flutter/material.dart';
import 'package:fweather/src/constants/color.dart';
import 'package:fweather/src/constants/paths.dart';
import 'package:fweather/src/models/weather.dart';
import 'package:fweather/src/screens/DetailsScreen.dart';
import 'package:fweather/src/widgets/Current_Text_widget.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  final Weather weather;

  const WeatherScreen({
    super.key,
    required this.weather,
  });

  @override
  // ignore: library_private_types_in_public_api
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    final weather = widget.weather;

    final date = DateTime.fromMillisecondsSinceEpoch(
        weather.dt * 1000); // Unix timestamp'ten tarih oluşturma
    final formattedDate = DateFormat('d MMMM').format(date);
    final formattedDay = DateFormat('EEEE').format(date);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPaths.smoothImage2), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: DraggableScrollableSheet(
          expand: true,
          initialChildSize: 0.6, // Initial size
          minChildSize: 0.2, // Minimum size
          maxChildSize: 0.9, // Maximum size
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailsScreen(),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: AppColors.backroundblue.withOpacity(0.3),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // Ekran boyutlarına göre font boyutlarını hesaplayın
                        double width = constraints.maxWidth;

                        double getFontSize(double ratio) {
                          return width * ratio / 100;
                        }

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextWidgets(
                              iconData: Icons.calendar_today,
                              formatted: formattedDay,
                              fontSize: getFontSize(5),
                            ),
                            const SizedBox(height: 8),
                            TextWidgets(
                              iconData: Icons.date_range,
                              formatted: formattedDate,
                              fontSize: getFontSize(4),
                            ),
                            const SizedBox(height: 8),
                            TextWidgets(
                              iconData: Icons.location_city,
                              formatted: weather.name,
                              fontSize: getFontSize(5),
                            ),
                            const SizedBox(height: 4),
                            TextWidgets(
                              iconData: Icons.thermostat,
                              formatted:
                                  '${weather.main.temp.toStringAsFixed(0)}°C',
                              fontSize: getFontSize(5),
                            ),
                            const SizedBox(height: 4),
                            TextWidgets(
                              iconData: Icons.device_thermostat_outlined,
                              formatted:
                                  'Min: ${weather.main.tempMin.toStringAsFixed(0)}°C / Max: ${weather.main.tempMax.toStringAsFixed(0)}°C',
                              fontSize: getFontSize(4),
                            ),
                            const SizedBox(height: 4),
                            TextWidgets(
                              iconData: Icons.wb_sunny,
                              formatted: 'Humidity: ${weather.main.humidity}%',
                              fontSize: getFontSize(4),
                            ),
                            const SizedBox(height: 4),
                            TextWidgets(
                              iconData: Icons.waves_sharp,
                              formatted: 'Wind: ${weather.wind.speed} m/s',
                              fontSize: getFontSize(4),
                            ),
                            const SizedBox(height: 4),
                            TextWidgets(
                              iconData: Icons.cloud_circle_sharp,
                              formatted:
                                  'Pressure: ${weather.main.pressure} hPa',
                              fontSize: getFontSize(4),
                            ),
                            const SizedBox(height: 4),
                            TextWidgets(
                              iconData: Icons.visibility,
                              formatted:
                                  'Visibility: ${weather.visibility != null ? (weather.visibility! / 100).toStringAsFixed(1) : 'No data'} km',
                              fontSize: getFontSize(4),
                            ),
                            const SizedBox(height: 4),
                            TextWidgets(
                              iconData: Icons.wb_sunny,
                              formatted:
                                  'Sunrise: ${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(weather.sys.sunrise * 1000))}',
                              fontSize: getFontSize(4),
                            ),
                            const SizedBox(height: 4),
                            TextWidgets(
                              iconData: Icons.wb_sunny,
                              formatted:
                                  'Sunset: ${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(weather.sys.sunset * 1000))}',
                              fontSize: getFontSize(4),
                            ),
                            const SizedBox(height: 4),
                            TextWidgets(
                              iconData: Icons.wb_sunny_outlined,
                              formatted:
                                  'Weather: ${weather.weather[0].description}',
                              fontSize: getFontSize(4),
                            ),
                            const SizedBox(height: 4),
                            TextWidgets(
                              iconData: Icons.wb_twilight_rounded,
                              formatted:
                                  'Main Weather: ${weather.weather[0].main}',
                              fontSize: getFontSize(4),
                            ),
                            const SizedBox(height: 4),
                            TextWidgets(
                              iconData: Icons.web,
                              formatted:
                                  'Weather Description: ${weather.weather[0].description}',
                              fontSize: getFontSize(4),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
