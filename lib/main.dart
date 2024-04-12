import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/helpers/preferences.dart';
import 'package:vpn_basic_project/screens/splash_screen.dart';


late Size mj; // global variable for holding the size of the screen


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // to ensure the app runs after the foloowing thinngs has been set or initialized
  
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]).
  then((value) => runApp(const MyApp()));
   await Preferences.initializeHive();
  
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SecVpn',
      home: SplashScreen(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(centerTitle: true,elevation: 0,color: Colors.blue)
        
      ),
      themeMode: ThemeMode.light,
      // darktheme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(centerTitle: true,elevation: 0,)
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
  extension AppTheme on ThemeData{

    Color get lightText => Get.isDarkMode ? Colors.white70 : Colors.black54 ;
  }

