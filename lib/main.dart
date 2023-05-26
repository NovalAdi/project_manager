import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_manager/cubit/home/home_cubit.dart';
import 'package:project_manager/ui/pages/home_page.dart';
import 'package:project_manager/ui/pages/login_page.dart';

import 'local/secure_strorage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await SecureStorage.deleteDataLokal();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String initialRoute = '';

  @override
  void initState() {
    SecureStorage.getToken().then((value) {
      if (value == null) {
        setState(() {
          initialRoute = 'login';
        });
      } else {
        setState(() {
          initialRoute = 'home';
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()..getUser(),

        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Rubik',
          primarySwatch: Colors.blue,
        ),
        home: initialRoute == 'login' ? LoginPage() : HomePage(),
      ),
    );
  }
}
