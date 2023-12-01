import 'package:gestion_tontine/models/reunion/reunion.dart';
import 'package:gestion_tontine/models/user/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'operation.g.dart';

@HiveType(typeId: 6)
class Operation extends HiveObject {
  @HiveField(1)
  String number;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  double amount;

  @HiveField(4)
  String type;

  @HiveField(5)
  String description;

  @HiveField(6)
  User user;

  Operation({
    required this.number,
    required this.date,
    required this.amount,
    required this.type,
    required this.description,
    required this.user,
  });
}
