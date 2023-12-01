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

  @HiveField(6)
  String? imagePath;

  @HiveField(7)
  String profession;

  @HiveField(8)
  DateTime birthDate;

  @HiveField(9)
  double amount;

  String get fullName {
    return "$firstName $lastName";
  }

  String get initiales =>
      fullName.split(' ').map((e) => e[0]).take(2).join().toUpperCase();

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.isAdmin,
    required this.profession,
    required this.birthDate,
    this.amount = 0.0,
  });
}
