import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(1)
  String firstName;

  @HiveField(2)
  String lastName;

  @HiveField(3)
  String email;

  @HiveField(4)
  String password;

  @HiveField(5)
  bool isAdmin;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.isAdmin,
  });
}
