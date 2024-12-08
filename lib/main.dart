import 'package:chief_app/cubit/Auth_cubit.dart';
import 'package:chief_app/cubit/home_cubit/home_cubit.dart';
import 'package:chief_app/cubit/menu_cubit/menu_cubit.dart';
import 'package:chief_app/network_helper/dio_helper.dart';
import 'package:chief_app/screens/home_screen.dart';
import 'package:chief_app/shared/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/Login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();

  var prefs = await SharedPreferences.getInstance();
  token ??= prefs.getString('token');
  print("tooooooooooooooooooooooken:$token");

  idd = prefs.getString('id');

  print(idd);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => MenuCubit()..getMeals(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chef App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: token == null ? LoginScreen() : const HomeScreen(),
      ),
    );
  }
}
