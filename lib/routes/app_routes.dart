import 'package:get/get.dart';
import 'package:study_app/controllers/my_zoom_drawer_controller.dart';
import 'package:study_app/controllers/question_paper/question_paper_controller.dart';
import 'package:study_app/controllers/questions_controller.dart';
import 'package:study_app/screens/home/home_screen.dart';
import 'package:study_app/screens/login/login_screen.dart';
import 'package:study_app/screens/questions/answer_check_screen.dart';
import 'package:study_app/screens/questions/questions_screen.dart';
import 'package:study_app/screens/questions/result_screen.dart';
import 'package:study_app/screens/questions/test_overview_screen.dart';
import 'package:study_app/screens/splash/splash_screen.dart';

import '../screens/intro/intro.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(
            name: AppIntroductionScreen.routeName,
            page: () => const AppIntroductionScreen()),
        GetPage(
            name: HomeScreen.routeName,
            page: () => const HomeScreen(),
            binding: BindingsBuilder(() {
              Get.put(QuestionPaperController());
              Get.put(MyZoomDrawerController());
            })),
        GetPage(name: LoginScreen.routeName, page: () => LoginScreen()),
        GetPage(
            name: QuestionScreen.routeName,
            page: () => QuestionScreen(),
            binding: BindingsBuilder(() {
              Get.put<QuestionsController>(QuestionsController());
            })),
        GetPage(
            name: TestOverviewScreen.routeName,
            page: () => const TestOverviewScreen()),
        GetPage(name: ResultScreen.routeName, page: () => const ResultScreen()),
        GetPage(
            name: AnswerCheckScreen.routeName,
            page: () => const AnswerCheckScreen()),
      ];
}
