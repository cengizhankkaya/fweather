import 'package:flutter/material.dart';
import 'package:fweather/src/constants/color.dart';
import 'package:fweather/src/models/famous_city.dart';
import 'package:fweather/src/models/weather.dart';
import 'package:fweather/src/services/api_helper.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Weather? _weather;
  bool _isLoading = false;
  String _errorMessage = '';

  FamousCity? _selectedCity;

  void _searchWeather() async {
    if (_selectedCity == null) {
      setState(() {
        _errorMessage = 'Please select a city';
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Hava durumu API çağrısını yap
      _weather =
          await ApiHelper.getWeatherByCityName(cityName: _selectedCity!.name);
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load weather';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _selectCity() async {
    final selectedCity = await showDialog<FamousCity>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select a City'),
        content: Container(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: famousCities.map((city) {
                return ListTile(
                  title: Text(city.name),
                  onTap: () {
                    Navigator.of(context).pop(city);
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );

    if (selectedCity != null) {
      setState(() {
        _selectedCity = selectedCity;
        _searchController.text = selectedCity.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.backroundblue,
          title: const Text(
            'Weather Search',
            style: TextStyle(color: Colors.white),
          )),
      backgroundColor: AppColors.backroundblueW,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: _searchController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.arrow_drop_down),
                  onPressed: _selectCity,
                ),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.backroundblue,
              ),
              onPressed: _searchWeather,
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_errorMessage.isNotEmpty)
              Text(_errorMessage, style: const TextStyle(color: Colors.red))
            else if (_weather != null)
              WeatherDisplay(weather: _weather!),
          ],
        ),
      ),
    );
  }
}

class WeatherDisplay extends StatelessWidget {
  final Weather weather;

  const WeatherDisplay({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.backroundblue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Şehir ve Tarih
          Text(
            '${weather.name}',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            DateFormat('dd MMM, EEEE')
                .format(DateTime.now()), // Tarih formatlama
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 20),

          // Hava durumu ikonu ve sıcaklık bilgisi
          Column(
            children: [
              Icon(
                Icons
                    .deblur_rounded, // Hava durumu ikonu (duruma göre değiştirilebilir)
                size: 80,
                color: Colors.yellow.shade700,
              ),
              const SizedBox(height: 10),
              Text(
                '${weather.main.temp}°C',
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Hava durumu açıklaması
          Text(
            '${weather.weather.first.description}',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),

          // Rüzgar hızı, görünürlük ve diğer bilgiler
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WeatherDetailItem(
                icon: Icons.air,
                value: '${weather.wind.speed} m/s',
                label: 'Wind',
              ),
              WeatherDetailItem(
                icon: Icons.visibility,
                value: '${weather.visibility ?? 'N/A'} m',
                label: 'Visibility',
              ),
              WeatherDetailItem(
                icon: Icons.thermostat,
                value: '${weather.main.feelsLike}°C',
                label: 'Feels Like',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WeatherDetailItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const WeatherDetailItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.white70),
        ),
      ],
    );
  }
}
