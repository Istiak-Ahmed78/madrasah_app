import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:madrasah_app/state_management/file_attach_state.dart';
import 'package:madrasah_app/views/route_management/route.dart';
import 'package:madrasah_app/views/route_management/route_name.dart';
import 'package:provider/provider.dart';
import 'di_contailer.dart' as di;
import 'state_management/auth_state.dart';
import 'state_management/storage_state.dart';

void main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => di.services<AuthState>()),
    ChangeNotifierProvider(create: (context) => di.services<FileAttechState>()),
    ChangeNotifierProvider(create: (constex) => di.services<StorageState>())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteMangement.generateRoute,
      initialRoute: RouteName.spleshScreen,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
