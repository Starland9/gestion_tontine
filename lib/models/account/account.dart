import 'package:gestion_tontine/models/user/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'account.g.dart';

@HiveType(typeId: 1)
class Account extends HiveObject {
  @HiveField(1)
  DateTime createdAt;

  @HiveField(2)
  double amount;

  @HiveField(3)
  String type;

  @HiveField(4)
  User user;

  Account({
    required this.createdAt,
    required this.amount,
    required this.type,
    required this.user,
  });
}
