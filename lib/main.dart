import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'core/app_colors.dart';
import 'services/background_services.dart';
import 'views/screens/splash_screen.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) async {
      runApp(
        const MyApp(),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      title: 'Ubenwa',
      theme: ThemeData(
          primaryColor: AppColors.PRIMARY,
          scaffoldBackgroundColor: AppColors.BACKGROUND,
          primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}
