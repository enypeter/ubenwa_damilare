import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'core/app_colors.dart';
import 'services/new_born_services.dart';
import 'views/screens/splash_screen.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,

      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  var isEnabled = await const FlutterSecureStorage().read(
    key: "enableBackground",
  );
  if (isEnabled == 'true') {
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
          title: "My App Service",
          content: "Updated at ${DateTime.now()}",
        );
      }
      createNewBaby();
    });
  }
}

createNewBaby() async {
  await NewBornServices.createNewBorn(
    name: 'Ifeoluwa Samson',
    gestation: '6',
    gender: 'male',
  );
}

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
