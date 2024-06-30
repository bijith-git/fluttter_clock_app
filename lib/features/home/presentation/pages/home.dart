import 'package:clock_app/core/constants/color.dart';
import 'package:clock_app/features/alram/presentation/pages/alram.dart';
import 'package:clock_app/features/clock/presentation/pages/clock.dart';
import 'package:clock_app/features/stopwatch/presentation/pages/stopwatch.dart';
import 'package:clock_app/features/timer/presentation/pages/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/active_icon.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  onNavigationTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> body = [
    const AlramScreen(),
    const ClockScreen(),
    const TimerScreen(),
    const StopWatchScreen(),
    const Center(
      child: Text("Bed Time"),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: body,
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          elevation: 10,
          selectedItemColor: ColorPalette.primary,
          mouseCursor: MouseCursor.defer,
          type: BottomNavigationBarType.fixed,
          onTap: onNavigationTap,
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.alarm),
                activeIcon: ActiveIcon(icon: Icons.alarm),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.language),
                activeIcon: ActiveIcon(icon: Icons.language),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.hourglass_bottom),
                activeIcon: ActiveIcon(icon: Icons.hourglass_bottom),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.timer_outlined),
                activeIcon: ActiveIcon(icon: Icons.timer_outlined),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.hotel_outlined),
                activeIcon: ActiveIcon(icon: Icons.hotel_outlined),
                label: ""),
          ],
        ),
      ),
    );
  }
}
