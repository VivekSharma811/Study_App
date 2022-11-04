import 'package:get/get.dart';
import 'package:study_app/controllers/my_zoom_drawer_controller.dart';
import 'package:study_app/controllers/question_paper/question_paper_controller.dart';
import 'package:study_app/screens/home/home_screen.dart';
import 'package:study_app/screens/login/login_screen.dart';
import 'package:study_app/screens/splash/splash_screen.dart';

import '../screens/intro/intro.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(name: "/intro", page: () => const AppIntroductionScreen()),
        GetPage(
            name: "/home",
            page: () => const HomeScreen(),
            binding: BindingsBuilder(() {
              Get.put(QuestionPaperController());
              Get.put(MyZoomDrawerController());
            })),
        GetPage(name: LoginScreen.routeName, page: ()=>LoginScreen()),
      ];
}
