import 'package:clock_app/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  final _isHours = true;

  late StopWatchTimer _stopWatchTimer;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countUp,
      onChange: (value) => setState(() => isTimeRunning = true),
      onStopped: () => setState(() => isTimeRunning = false),
    );
  }

  bool isTimeRunning = false;

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text('Stopwatch',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /// Display stop watch time
            Center(
              child: StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: _stopWatchTimer.rawTime.value,
                builder: (context, snap) {
                  final value = snap.data!;
                  final displayTime =
                      StopWatchTimer.getDisplayTime(value, hours: _isHours);
                  return Container(
                    width: 300,
                    height: 300,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorPalette.primary.withOpacity(.5)),
                    child: Text(
                      displayTime,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 40,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),

            /// Lap time.
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                height: 200,
                child: StreamBuilder<List<StopWatchRecord>>(
                  stream: _stopWatchTimer.records,
                  initialData: _stopWatchTimer.records.value,
                  builder: (context, snap) {
                    final value = snap.data!;
                    if (value.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    // Future.delayed(const Duration(milliseconds: 100), () {
                    //   _scrollController.animateTo(
                    //       _scrollController.position.maxScrollExtent,
                    //       duration: const Duration(milliseconds: 200),
                    //       curve: Curves.easeOut);
                    // });

                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 50),
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        final data = value[index];
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            '#${index + 1} ${data.displayTime}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                      itemCount: value.length,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                _stopWatchTimer.clearPresetTime();
                _stopWatchTimer.records.value.clear();
              },
              child: const Icon(Icons.restart_alt_rounded),
            ),
            isTimeRunning
                ? ElevatedButton(
                    onPressed: _stopWatchTimer.onStopTimer,
                    child: const Icon(Icons.pause),
                  )
                : ElevatedButton(
                    onPressed: _stopWatchTimer.onStartTimer,
                    child: const Icon(Icons.play_arrow),
                  ),
            ElevatedButton(
              onPressed: _stopWatchTimer.onAddLap,
              child: const Icon(Icons.timer_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
