import 'package:flutter/material.dart';
import 'package:apkekskul/form_page.dart';
import 'package:apkekskul/hasil_page.dart';
import 'package:apkekskul/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pendaftaran Ekstrakurikuler',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/form': (context) => const FormPage(),
        '/hasil': (context) => const HasilPage(),
      },
    );
  }
}