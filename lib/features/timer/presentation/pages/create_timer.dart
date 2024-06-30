import 'package:flutter/material.dart';
class SlideUpTransition extends PageRouteBuilder {
  final Widget page;

  SlideUpTransition({required this.page})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              page,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0), // From bottom to top
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );

  // Override barrierLabel to return an empty string
  @override
  String get barrierLabel => '';
}

class CreatTimerScreen extends StatefulWidget {
  const CreatTimerScreen({super.key});

  @override
  State<CreatTimerScreen> createState() => _CreatTimerScreenState();
}

class _CreatTimerScreenState extends State<CreatTimerScreen> {
  String _timerValue = "00h 00m 00s";
  String _input = "";

  void _updateTimerValue(String number) {
    setState(() {
      if (_input.length + number.length <= 6) {
        _input += number;
        String paddedInput = _input.padLeft(6, '0');
        int hours = int.parse(paddedInput.substring(0, 2));
        int minutes = int.parse(paddedInput.substring(2, 4));
        int seconds = int.parse(paddedInput.substring(4, 6));

        if (seconds >= 60) {
          minutes += seconds ~/ 60;
          seconds %= 60;
        }

        if (minutes >= 60) {
          hours += minutes ~/ 60;
          minutes %= 60;
        }

        _timerValue =
            "${hours.toString().padLeft(2, '0')}h ${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s";
      }
    });
  }

  void _clearTimerValue() {
    setState(() {
      if (_input.isNotEmpty) {
        _input = _input.substring(0, _input.length - 1);
        String paddedInput = _input.padLeft(6, '0');

        int hours = int.parse(paddedInput.substring(0, 2));
        int minutes = int.parse(paddedInput.substring(2, 4));
        int seconds = int.parse(paddedInput.substring(4, 6));

        if (seconds >= 60) {
          minutes += seconds ~/ 60;
          seconds %= 60;
        }

        if (minutes >= 60) {
          hours += minutes ~/ 60;
          minutes %= 60;
        }

        _timerValue =
            "${hours.toString().padLeft(2, '0')}h ${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s";
      } else {
        _timerValue = "00h 00m 00s";
        _input = '';
      }
    });
  }

  Duration parseTimerValueToDuration(String timerValue) {
    timerValue = timerValue.trim();
    List<String> parts = timerValue
        .split(RegExp(r'[hms ]+'))
        .where((part) => part.isNotEmpty)
        .toList();
    int hours = 0, minutes = 0, seconds = 0;
    if (parts.isNotEmpty) {
      hours = int.tryParse(parts[0]) ?? 0;
    }
    if (parts.length >= 2) {
      minutes = int.tryParse(parts[1]) ?? 0;
    }
    if (parts.length >= 3) {
      seconds = int.tryParse(parts[2]) ?? 0;
    }
    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Timer',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 20),
          Text(_timerValue,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 48)),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: 12,
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                if (index == 9) {
                  return DialButton(
                    label: "00",
                    onPressed: () => _updateTimerValue("00"),
                  );
                } else if (index == 11) {
                  return DialButton(
                    icon: Icons.backspace,
                    onPressed: _clearTimerValue,
                  );
                } else {
                  String number = (index == 10 ? 0 : index + 1).toString();
                  return DialButton(
                    label: number,
                    onPressed: () => _updateTimerValue(number),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: FloatingActionButton(
              onPressed: () {
                var dur = parseTimerValueToDuration(_timerValue);
                print(dur);
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.play_arrow, size: 36),
            ),
          ),
        ],
      ),
    );
  }
}

class DialButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback? onPressed;

  const DialButton({super.key, this.label, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          shape: BoxShape.circle,
        ),
        child: Center(
          child: label != null
              ? Text(
                  label ?? "",
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                )
              : Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}
