import 'package:flutter/material.dart';
import 'package:fweather/src/constants/paths.dart';
import 'package:fweather/src/models/weekly_weather.dart';
import 'package:fweather/src/services/api_helper.dart';
import 'package:fweather/src/widgets/SvgLoadingIndicator_widget.dart';
import 'package:intl/intl.dart';

class WeeklyWeatherScreen extends StatefulWidget {
  final int selectedIndex;
  final String backgroundImageUrl;

  const WeeklyWeatherScreen({
    Key? key,
    required this.selectedIndex,
    required this.backgroundImageUrl,
  }) : super(key: key);

  @override
  _WeeklyWeatherScreenState createState() => _WeeklyWeatherScreenState();
}

class _WeeklyWeatherScreenState extends State<WeeklyWeatherScreen> {
  late Future<WeeklyWeather> _weeklyWeatherFuture;

  @override
  void initState() {
    super.initState();
    _weeklyWeatherFuture = ApiHelper.getWeeklyForecast(); // API'den veri al
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<WeeklyWeather>(
        future: _weeklyWeatherFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: SvgLoadingIndicator(
              svgPath: SvgImage.thermo, // SVG dosyasının yolu
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          } else {
            final dailyData = snapshot.data!.daily;
            final selectedIndex = widget.selectedIndex;

            if (selectedIndex < 0 || selectedIndex >= dailyData.time.length) {
              return const Center(child: Text('Invalid index'));
            }

            final dateStr = dailyData.time[selectedIndex];
            final temperatureMax =
                dailyData.temperature2mMax[selectedIndex].toDouble();
            final temperatureMin =
                dailyData.temperature2mMin[selectedIndex].toDouble();

            final date = DateTime.parse(dateStr);
            final formattedDate = DateFormat('d MMMM').format(date);
            final formattedDay = DateFormat('EEEE').format(date);

            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.backgroundImageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Card(
                  margin: const EdgeInsets.all(80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.white.withOpacity(0.3),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          formattedDay,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          formattedDate,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.thermostat,
                              color: Colors.orange,
                              size: MediaQuery.of(context).size.width *
                                  0.08, // Boyutu küçülttük
                            ),
                            const SizedBox(
                                width:
                                    8), // Metin ile simge arasında boşluk oluşturur
                            Flexible(
                              child: Text(
                                'Max: ${temperatureMax.toStringAsFixed(0)}°C \nMin: ${temperatureMin.toStringAsFixed(0)}°C',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      fontWeight: FontWeight.bold,
                                    ),
                                overflow: TextOverflow
                                    .ellipsis, // Taşmayı önlemek için
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
