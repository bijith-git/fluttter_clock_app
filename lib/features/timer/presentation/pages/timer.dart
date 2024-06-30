import 'dart:math';

import 'package:clock_app/core/constants/color.dart';
import 'package:clock_app/features/timer/presentation/pages/create_timer.dart';
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Timer",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          itemCount: 1,
          itemBuilder: (_, i) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  color: ColorPalette.primary.withOpacity(.5),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("40s timer"),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.close))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomPaint(
                        painter: CircularTimerIndicator(),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                              color: Colors.amber, shape: BoxShape.circle),
                        ),
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {}, child: const Text("+ 1:00")),
                          ElevatedButton(
                              onPressed: () {}, child: const Text("+ 1:00"))
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        heroTag: UniqueKey(),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(SlideUpTransition(page: CreatTimerScreen()));
        },
      ),
    );
  }
}

class CircularTimerIndicator extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawArc(Rect.fromCenter(center: center, width: 150, height: 150),
        pi / 2, 3 * pi / 4, true, Paint()..color = ColorPalette.grey);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
