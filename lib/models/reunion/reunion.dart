import 'package:hive_flutter/hive_flutter.dart';

import '../user/user.dart';

part 'reunion.g.dart';

@HiveType(typeId: 5)
class Reunion extends HiveObject {
  @HiveField(1)
  String cause;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  List<User> participants;

  Reunion({
    required this.cause,
    required this.date,
    required this.participants,
  });
}
