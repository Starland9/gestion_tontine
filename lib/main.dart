import 'package:flutter/material.dart';
import 'package:gestion_tontine/screens/home/landing_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/account/account.dart';
import 'models/cotisation/cotisation.dart';
import 'models/notification/notification.dart' as notif;
import 'models/operation/operation.dart';
import 'models/profile/profile.dart';
import 'models/reunion/reunion.dart';
import 'models/user/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // Register Adapters
  Hive.registerAdapter(ReunionAdapter());
  Hive.registerAdapter(OperationAdapter());
  Hive.registerAdapter(CotisationAdapter());
  Hive.registerAdapter(ProfileAdapter());
  Hive.registerAdapter(AccountAdapter());
  Hive.registerAdapter(notif.NotificationAdapter());
  Hive.registerAdapter(UserAdapter());

  // Open boxes
  await Hive.openBox<Reunion>('reunions');
  await Hive.openBox<Operation>('operations');
  await Hive.openBox<Cotisation>('cotisations');
  await Hive.openBox<Profile>('profiles');
  await Hive.openBox<Account>('accounts');
  await Hive.openBox<notif.Notification>('notifications');
  await Hive.openBox<User>('users');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomePage(
      //   user: User(
      //     firstName: "Landry",
      //     lastName: "Simo",
      //     email: "landrysimo99@gmail.com",
      //     password: "stilll2003",
      //     isAdmin: true,
      //     profession: "Developpeur",
      //     birthDate: DateTime(2003, 11, 4),
      //   ),
      // ),
      home: LandingPage(),
    );
  }
}
