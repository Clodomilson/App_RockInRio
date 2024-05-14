import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_rockinrio/HomePage.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => RockInRio(),
    ),
  );
}

class RockInRio extends StatelessWidget {
  RockInRio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Rock in Rio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomePage(),
    );
  }
}
