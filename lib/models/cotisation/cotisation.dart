import 'package:hive_flutter/hive_flutter.dart';

import '../user/user.dart';

part 'cotisation.g.dart';

@HiveType(typeId: 4)
class Cotisation extends HiveObject {
  @HiveField(1)
  double currentAmount;

  @HiveField(2)
  double targetAmount;

  @HiveField(3)
  User user;

  Cotisation({
    required this.currentAmount,
    required this.targetAmount,
    required this.user,
  });
}
