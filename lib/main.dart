import 'package:fundflow/providers/money_provider.dart';
import 'package:flutter/material.dart';
import 'package:fundflow/widgets/botomNavigationBar.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Required for using shared_preferences
  runApp(ChangeNotifierProvider(
    create: (_) => MoneyProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FundFlow',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(54, 137, 131, 1),
        appBarTheme: AppBarTheme(color: Color.fromRGBO(54, 137, 131, 1)),
      ),
      home: BottomNavBar(),
    );
  }
}
