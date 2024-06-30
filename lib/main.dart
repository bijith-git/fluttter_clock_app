import "package:provider/provider.dart";
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:clock_app/core/constants/color.dart';

import 'core/db/database.dart';
import 'core/providers/providers.dart';
import 'features/features.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await hiveDatabase.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AlramProvider>(
          create: (_) => AlramProvider(),
        ),
        Provider<TimerProvider>(
          create: (_) => TimerProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Clock',
        theme: ThemeData(
          textTheme: GoogleFonts.nunitoTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: ColorPalette.primary),
          useMaterial3: true,
        ),
        home: const Home(),
      ),
    );
  }
}
