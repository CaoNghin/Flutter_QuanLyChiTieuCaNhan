import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import './screens/home_screen.dart';
import './screens/new_transaction.dart';
import './models/transaction.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Transactions(),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hệ thống quản lý chi tiêu cá nhân',
            theme: ThemeData(
              primaryColor: Color(0xFF4FC495),
              accentColor: Color(0xFF06834C),
              fontFamily: 'Quicksand',
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline1: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    button: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
              appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                      headline1: const TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
              ),
            ),
            routes: {
              HomeScreen.routeName: (_) => HomeScreen(),
              NewTransaction.routeName: (_) => NewTransaction(),
            },
          );
        });
  }
}
