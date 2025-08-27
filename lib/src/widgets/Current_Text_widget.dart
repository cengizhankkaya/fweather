import 'package:flutter/material.dart';

class TextWidgets extends StatelessWidget {
  const TextWidgets({
    super.key,
    required this.formatted,
    required this.fontSize,
    required this.iconData, // İkon verisi için yeni bir parametre ekledik
  });

  final String formatted;
  final double fontSize;

  final IconData iconData; // İkonu temsil eden parametre

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Yatay hizalama
      children: [
        Icon(
          iconData, // İkon verisi
          color: Colors.white, // İkon rengi
          size: fontSize, // İkon boyutu
        ),
        SizedBox(width: 8), // İkon ile metin arasındaki boşluk
        Text(
          formatted,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
