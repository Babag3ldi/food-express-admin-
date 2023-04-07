import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_admin/subcollection/provider.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'subcollection/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider<ProviderPage>(create: (_) => ProviderPage())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      )));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const Home(),
//     );
//   }
// }
