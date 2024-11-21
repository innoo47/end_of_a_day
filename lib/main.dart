import 'package:end_of_a_day/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '하루의 끝',
          themeMode: ThemeMode.light,
          theme: ThemeData.light(
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          home: child,
        );
      },
      child: const HomeScreen(),
    );
  }
}

// MaterialApp(
// debugShowCheckedModeBanner: false,
// title: 'Flutter Demo',
// themeMode: ThemeMode.light,
// theme: ThemeData.light(
// useMaterial3: true,
// ),
// darkTheme: ThemeData.dark(
// useMaterial3: true,
// ),
// home: const HomeScreen(),
// ),
