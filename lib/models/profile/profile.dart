import 'package:hive_flutter/hive_flutter.dart';

part 'profile.g.dart';

@HiveType(typeId: 3)
class Profile extends HiveObject {
  @HiveField(1)
  String name;

  Profile({required this.name});
}
