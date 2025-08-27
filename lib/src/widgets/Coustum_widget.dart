import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
          Icons.tsunami_sharp), // Burada istediğiniz ikonu kullanabilirsiniz
      onPressed: () {
        Scaffold.of(context).openEndDrawer(); // endDrawer'ı açmak için
      },
      tooltip: 'Details',
      padding: EdgeInsets.all(10),
      splashColor: Colors.blueAccent,
      highlightColor: Colors.blue[200],
      splashRadius: 15,
    );
  }
}
