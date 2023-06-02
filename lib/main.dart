import 'package:fundflow/pages/LoginScreen1.dart';
import 'package:fundflow/pages/RegisterScreen.dart';
import 'package:fundflow/providers/money_provider.dart';
import 'package:flutter/material.dart';
import 'package:fundflow/utils/app_utilities.dart';
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
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: Utils.loadData("accessToken"),
      builder: (context, snapshot) {
        final accessToken = snapshot.data;
        Widget Function(BuildContext) builder;
        if (accessToken != null) {
          print(accessToken);
          builder = (_) => const BottomNavBar();
        } else {
          builder = (_) => const AppLoginScreen();
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FundFlow',
          theme: ThemeData(
            primaryColor: Color.fromRGBO(54, 137, 131, 1),
            appBarTheme: AppBarTheme(color: Color.fromRGBO(54, 137, 131, 1)),
          ),
          home: Builder(
            builder: builder,
          ),
          routes: {
            '/login': (context) => const AppLoginScreen(),
            '/register': (context) => const AppRegsiterScreen()
          },
        );
      },
    );
  }
}
