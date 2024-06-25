import 'package:clock_app/core/constants/color.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'features/home/presentation/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: ColorPalette.primary),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
