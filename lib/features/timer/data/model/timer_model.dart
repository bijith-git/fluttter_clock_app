import 'package:hive/hive.dart';

part 'timer_model.g.dart';

@HiveType(typeId: 1)
class Timer extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  Duration duration;

  @HiveField(2)
  bool timerStatus;

  Timer({
    required this.name,
    required this.duration,
    required this.timerStatus,
  });
}
