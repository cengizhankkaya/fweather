import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildWeatherInfo(
  BuildContext context, {
  required String name,
  required DateTime date,
  required double temperature,
}) {
  String formattedDate = DateFormat('d MMMM').format(date);
  String formattedDay = DateFormat('EEEE').format(date);

  return Positioned(
    top: MediaQuery.of(context).size.height * 0.25,
    left: MediaQuery.of(context).size.width * 0.05,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          
          name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontSize: 30,
              ),
        ),
        Text(
          '$formattedDate, $formattedDay',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
        ),
        Text(
          '${temperature.toStringAsFixed(0)}°C',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.2,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    ),
  );
}
