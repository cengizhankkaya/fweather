import 'package:flutter/material.dart';

import 'package:fweather/src/constants/color.dart';
import 'package:fweather/src/screens/HelpAndFeedbackScreen.dart';
import 'package:fweather/src/screens/SearchScreen.dart';
import 'package:fweather/src/widgets/Drawer_widget.dart';

class ListViewDrawerWidget extends StatelessWidget {
  const ListViewDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // DrawerHeader tasarımı
          LayoutBuilder(
            builder: (context, constraints) {
              return const DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 114, 9, 2), // Koyu kırmızı
                      AppColors.backroundblue,
                    ], // Degrade koyu mavi tonları
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.water_drop_outlined,
                        size: 40,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'WeatherF',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          // Drawer içerik öğeleri
          DrawerWidget(
            title: 'Search City',
            icon: Icons.search,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),

          DrawerWidget(
            title: 'Help & Feedback',
            icon: Icons.help_outline,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => HelpAndFeedbackScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
