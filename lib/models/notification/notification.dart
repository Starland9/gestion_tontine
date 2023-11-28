import 'package:hive_flutter/hive_flutter.dart';

part 'notification.g.dart';

@HiveType(typeId: 2)
class Notification extends HiveObject {
  @HiveField(1)
  String title;

  @HiveField(2)
  String body;

  @HiveField(3)
  DateTime createdAt;

  Notification({
    required this.title,
    required this.body,
    required this.createdAt,
  });
}
