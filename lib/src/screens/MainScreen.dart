import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fweather/src/constants/color.dart';
import 'package:fweather/src/widgets/SvgLoadingIndicator_widget.dart';
import 'package:intl/intl.dart';

import 'package:fweather/src/constants/paths.dart';
import 'package:fweather/src/providers/get_current_weather_provider.dart';
import 'package:fweather/src/screens/CurrentScreen.dart';
import 'package:fweather/src/screens/WeeklyWeatherScreen.dart';
import 'package:fweather/src/widgets/Listview_drawer_widget.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final weatherAsyncValue = ref.watch(currentWeatherProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    final iconSize = screenHeight * 0.07;

    List<Widget> widgetOptions = <Widget>[
      weatherAsyncValue.when(
        data: (weather) => WeatherScreen(weather: weather),
        loading: () => const Center(
            child: SvgLoadingIndicator(
          svgPath: SvgImage.thermo,
        )),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      const WeeklyWeatherScreen(
        selectedIndex: 1,
        backgroundImageUrl: AssetPaths.smoothImage2,
      ),
      const WeeklyWeatherScreen(
        backgroundImageUrl: AssetPaths.image2,
        selectedIndex: 2,
      ),
      const WeeklyWeatherScreen(
        backgroundImageUrl: AssetPaths.image3,
        selectedIndex: 3,
      ),
      const WeeklyWeatherScreen(
        backgroundImageUrl: AssetPaths.smoothImage3,
        selectedIndex: 4,
      ),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    // Haftanın günlerini dinamik olarak al
    List<String> weekDays = List.generate(5, (index) {
      DateTime now = DateTime.now().add(Duration(days: index));
      return DateFormat('EEE')
          .format(now); // Kısa gün adları: Mon, Tue, Wed, vb.
    });

    // Hava durumu ikon yolları
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

    // Hava durumu simgelerini güncelleyebilmek için `weather` verisini kullanın
    List<String> iconCodes =
        List.generate(5, (index) => '01d'); // Varsayılan simge kodları

    weatherAsyncValue.when(
      data: (weather) {
        // Hava durumu simge kodlarını güncelle
        for (int i = 0; i < 5; i++) {
          if (i < weather.weather.length) {
            iconCodes[i] = weather.weather[i].icon;
          }
        }
      },
      loading: () {},
      error: (_, __) {},
    );

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Center(
            child: widgetOptions.elementAt(_selectedIndex),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              child: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Image.asset(
                    weatherIconPaths[iconCodes[0]] ??
                        WeatherPathsDay.dayclearsky,
                    width: iconSize,
                    height: iconSize,
                  ),
                  label: weekDays[0], // Bugünün ismi
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    weatherIconPaths[iconCodes[1]] ??
                        WeatherPathsDay.dayclearsky,
                    width: iconSize,
                    height: iconSize,
                  ),
                  label: weekDays[1], // Yarın
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    weatherIconPaths[iconCodes[2]] ??
                        WeatherPathsDay.dayclearsky,
                    width: iconSize,
                    height: iconSize,
                  ),
                  label: weekDays[2], // İki gün sonra
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    weatherIconPaths[iconCodes[3]] ??
                        WeatherPathsDay.dayclearsky,
                    width: iconSize,
                    height: iconSize,
                  ),
                  label: weekDays[3], // Üç gün sonra
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    weatherIconPaths[iconCodes[4]] ??
                        WeatherPathsDay.dayclearsky,
                    width: iconSize,
                    height: iconSize,
                  ),
                  label: weekDays[4], // Dört gün sonra
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: AppColors.backroundblueW,
              unselectedItemColor: Colors.white,
              enableFeedback: true,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent, // Şeffaf arka plan
              elevation: 1, // Gölgeyi kaldır
              onTap: _onItemTapped,
            ),
          ),
        ],
      ),
      endDrawer: const Drawer(
        clipBehavior: Clip.antiAlias,
        width: 200,
        backgroundColor: AppColors.backroundblue,
        child: ListViewDrawerWidget(),
      ),
    );
  }
}
