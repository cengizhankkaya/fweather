class FamousCity {
  final String name;
  final double lat;
  final double lon;

  const FamousCity({
    required this.name,
    required this.lat,
    required this.lon,
  });
}

// List of famous cities with some Turkish cities included
List<FamousCity> famousCities = const [
  FamousCity(name: 'Tokyo', lat: 35.6833, lon: 139.7667),
  FamousCity(name: 'New Delhi', lat: 28.5833, lon: 77.2),
  FamousCity(name: 'Paris', lat: 48.85, lon: 2.3333),
  FamousCity(name: 'London', lat: 51.4833, lon: -0.0833),
  FamousCity(name: 'New York', lat: 40.7167, lon: -74.0167),
  FamousCity(name: 'Tehran', lat: 35.6833, lon: 51.4167),

  // Turkish cities
  FamousCity(name: 'Nevşehir', lat: 38.6244, lon: 34.7167),
  FamousCity(name: 'Istanbul', lat: 41.0082, lon: 28.9784),
  FamousCity(name: 'Ankara', lat: 39.9334, lon: 32.8597),
  FamousCity(name: 'Antalya', lat: 36.8969, lon: 30.7133),
  FamousCity(name: 'Bursa', lat: 40.1826, lon: 29.0661),
  FamousCity(name: 'Adana', lat: 37.0022, lon: 35.3213),
  FamousCity(name: 'Gaziantep', lat: 37.0662, lon: 37.3833),
  FamousCity(name: 'Konya', lat: 37.8662, lon: 32.4821),
  FamousCity(name: 'Mersin', lat: 36.8121, lon: 34.6416),
  FamousCity(name: 'Kayseri', lat: 38.7339, lon: 35.4864),
  FamousCity(name: 'Samsun', lat: 41.2867, lon: 36.33),
  FamousCity(name: 'Trabzon', lat: 41.0053, lon: 39.7258),
  FamousCity(name: 'Diyarbakır', lat: 37.9097, lon: 40.2290),
  FamousCity(name: 'Malatya', lat: 38.3558, lon: 38.3092),
  FamousCity(name: 'Eskişehir', lat: 39.7767, lon: 30.5206),
  FamousCity(name: 'Afyonkarahisar', lat: 38.7566, lon: 30.5434),
  FamousCity(name: 'Aksaray', lat: 38.3707, lon: 34.0209),
  FamousCity(name: 'Batman', lat: 37.8890, lon: 41.1416),
  FamousCity(name: 'Mardin', lat: 37.3218, lon: 40.7277),
  FamousCity(name: 'Ordu', lat: 40.9833, lon: 37.8667),
  FamousCity(name: 'Tekirdağ', lat: 40.9797, lon: 27.5116),
  FamousCity(name: 'Kocaeli', lat: 40.8333, lon: 29.9167),
  FamousCity(name: 'Zonguldak', lat: 41.4530, lon: 31.7985),
  FamousCity(name: 'Çorum', lat: 40.5533, lon: 34.9556),
  FamousCity(name: 'Sivas', lat: 39.7471, lon: 37.0167),
  FamousCity(name: 'Aydın', lat: 37.8494, lon: 27.8484),
  FamousCity(name: 'Kırıkkale', lat: 39.8461, lon: 33.5153),
  FamousCity(name: 'Çanakkale', lat: 40.1553, lon: 26.4142),
  FamousCity(name: 'Çorum', lat: 40.5533, lon: 34.9556),
  FamousCity(name: 'Isparta', lat: 37.7658, lon: 30.5569),
  FamousCity(name: 'Rize', lat: 41.0208, lon: 40.5234),
];
