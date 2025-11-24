import 'package:flutter/material.dart';

void main() => runApp(const VisoraApp());

class VisoraApp extends StatelessWidget {
  const VisoraApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visora AI Studio',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Visora AI Studio')),
      body: const Center(child: Text('Build test: Visora minimal app')),
    );
  }
}
