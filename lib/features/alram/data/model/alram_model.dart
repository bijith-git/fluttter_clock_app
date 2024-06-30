import 'package:hive/hive.dart';

part 'alram_model.g.dart';

@HiveType(typeId: 0)
class Alarm extends HiveObject {
  @HiveField(0)
  String label;

  @HiveField(1)
  DateTime time;

  @HiveField(2)
  String music;

  @HiveField(3)
  bool vibration;

  @HiveField(4)
  bool paused;

  @HiveField(5)
  bool alarmStatus;

  @HiveField(6)
  List<WeekDay> activeDays;

  @HiveField(7)
  bool isExpanded;

  Alarm({
    required this.label,
    required this.time,
    required this.music,
    required this.vibration,
    required this.paused,
    required this.alarmStatus,
    required this.activeDays,
    required this.isExpanded,
  });
}

@HiveType(typeId: 0)
enum WeekDay {
  @HiveField(0)
  monday,
  @HiveField(1)
  tuesday,
  @HiveField(2)
  wednesday,
  @HiveField(3)
  thursday,
  @HiveField(4)
  friday,
  @HiveField(5)
  saturday,
  @HiveField(6)
  sunday,
}
