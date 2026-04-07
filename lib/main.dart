import 'package:flutter/material.dart';
import 'views/start_view.dart';

void main() {
  runApp(const CafeGameApp());
}

class CafeGameApp extends StatelessWidget {
  const CafeGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloom Brew Café',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: const Color(0xFFFFF0F5),
      ),
      home: const StartView(),
    );
  }
}
