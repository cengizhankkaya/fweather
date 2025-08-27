import 'package:flutter/material.dart';
import 'package:fweather/src/constants/color.dart';
import 'package:fweather/src/constants/paths.dart';
import 'package:fweather/src/models/hourly_weather.dart';
import 'package:fweather/src/services/api_helper.dart';
import 'package:fweather/src/widgets/SvgLoadingIndicator_widget.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Future<HourlyWeather> _hourlyWeatherFuture;

  final Map<String, String> weatherIconPaths = {
    '01d': WeatherPathsDay.dayclearsky,
    '01n': WeatherPathsNight.nightclearskyn,
    '02d': WeatherPathsDay.dayfewclouds,
    '02n': WeatherPathsNight.nightfewcloudsn,
    '03d': WeatherPathsDay.dayscatteredclouds,
    '03n': WeatherPathsNight.nightscatteredcloudsn,
    '04d': WeatherPathsDay.daybrokenclouds,
    '04n': WeatherPathsNight.nightbrokencloudsn,
    '09d': WeatherPathsDay.dayshowerrain,
    '09n': WeatherPathsNight.nightshowerrainn,
    '10d': WeatherPathsDay.daysrain,
    '10n': WeatherPathsNight.nightsrainn,
    '11d': WeatherPathsDay.daythunderstorm,
    '11n': WeatherPathsNight.nightthunderstormn,
    '13d': WeatherPathsDay.dayssnow,
    '13n': WeatherPathsNight.nightssnown,
    '50d': WeatherPathsDay.daysmist,
    '50n': WeatherPathsNight.nightsmistn,
  };

  @override
  void initState() {
    super.initState();
    _hourlyWeatherFuture = ApiHelper.getHourlyForecast();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.backroundblue, // Güncellenmiş arka plan rengi
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Hourly Forecast',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<HourlyWeather>(
        future: _hourlyWeatherFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: SvgLoadingIndicator(
              svgPath: SvgImage.thermo,
            ));
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.list.isEmpty) {
            return const Center(
              child: Text('No weather data available',
                  style: TextStyle(color: Colors.white)),
            );
          }

          final hourlyWeather = snapshot.data!;
          final weatherList = hourlyWeather.list;

          return SingleChildScrollView(
            child: Column(
              children: [
                MainWeatherWidget(
                  weatherEntry: weatherList.first,
                  weatherIconPaths: weatherIconPaths,
                  screenSize: screenSize,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: weatherList.length,
                  itemBuilder: (context, index) {
                    final weatherEntry = weatherList[index];
                    return WeatherCard(
                      weatherEntry: weatherEntry,
                      weatherIconPaths: weatherIconPaths,
                      screenSize: screenSize,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MainWeatherWidget extends StatelessWidget {
  final WeatherEntry weatherEntry;
  final Map<String, String> weatherIconPaths;
  final Size screenSize;

  const MainWeatherWidget({
    Key? key,
    required this.weatherEntry,
    required this.weatherIconPaths,
    required this.screenSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            weatherIconPaths[weatherEntry.weather.first.icon] ??
                WeatherPathsDay.dayclearsky,
            width: screenSize.width * 0.3, // Ekran genişliğinin %30'u
          ),
          SizedBox(height: screenSize.height * 0.02),
          Text(
            '${weatherEntry.main.temp}°',
            style: TextStyle(
                fontSize: screenSize.width * 0.1, // Ekran genişliğinin %10'u
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: screenSize.height * 0.01),
          Text(
            weatherEntry.weather.first.description,
            style: TextStyle(
                fontSize: screenSize.width * 0.05, color: Colors.white70),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Icon(Icons.air, color: Colors.white70),
                    SizedBox(width: screenSize.width * 0.02),
                    Text('${weatherEntry.wind.speed} km/h',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: screenSize.width * 0.04)),
                  ],
                ),
                SizedBox(width: screenSize.width * 0.05),
                Row(
                  children: [
                    const Icon(Icons.water_drop, color: Colors.white70),
                    SizedBox(width: screenSize.width * 0.02),
                    Text('${weatherEntry.main.humidity}%',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: screenSize.width * 0.04)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  final WeatherEntry weatherEntry;
  final Map<String, String> weatherIconPaths;
  final Size screenSize;

  const WeatherCard({
    Key? key,
    required this.weatherEntry,
    required this.weatherIconPaths,
    required this.screenSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backroundblueW, // Güncellenmiş kart rengi
      margin: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.03,
          vertical: screenSize.height * 0.01),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(screenSize.width * 0.04),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              weatherIconPaths[weatherEntry.weather.first.icon] ??
                  WeatherPathsDay.dayclearsky,
              width: screenSize.width * 0.15, // Ekran genişliğinin %15'i
            ),
            Row(
              children: [
                const Icon(Icons.hourglass_empty_rounded,
                    color: Colors.white70),
                SizedBox(width: screenSize.width * 0.02),
                Text(
                  weatherEntry.dtTxt.split(' ')[1].substring(0, 5),
                  style: TextStyle(
                      color: Colors.white, fontSize: screenSize.width * 0.04),
                ),
              ],
            ),
            Icon(Icons.arrow_forward, color: Colors.orange[300]),
            Row(
              children: [
                const Icon(Icons.water_drop, color: Colors.white70),
                SizedBox(width: screenSize.width * 0.02),
                Text(
                  '${weatherEntry.main.humidity}%',
                  style: TextStyle(
                      color: Colors.white, fontSize: screenSize.width * 0.04),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '${weatherEntry.main.temp}°',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenSize.width * 0.04,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
