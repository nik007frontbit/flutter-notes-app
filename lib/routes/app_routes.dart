
import 'package:get/get.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/signup', page: () => SignUpScreen()),
    GetPage(name: '/home', page: () => HomeScreen()),
  ];
}
