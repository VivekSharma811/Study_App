import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_app/controllers/questions_controller.dart';
import 'package:get/get.dart';
import '../../firebase_ref/references.dart';
import '../auth_controller.dart';

extension QuestionsControllerExtension on QuestionsController {
  int get correctQuestionCount => allQuestions
      .where((question) => question.selectedAnswer == question.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestions =>
      '$correctQuestionCount out of ${allQuestions.length} are correct';

  String get points {
    var points = (correctQuestionCount / allQuestions.length) *
        100 *
        (questionPaperModel.timeSeconds - remainingSeconds) /
        questionPaperModel.timeSeconds *
        100;
    return points.toStringAsFixed(2);
  }

  Future<void> saveTestResults() async {
    var batch = firestore.batch();
    User? _user = Get.find<AuthController>().getUser();
    if (_user == null) return;

    batch.set(
        userRF
            .doc(_user.email)
            .collection('myRecentTests')
            .doc(questionPaperModel.id),
        {
          "points": points,
          "correct_answer": '$correctQuestionCount/${allQuestions.length}',
          "question_id": questionPaperModel.id.toString(),
          "time": (questionPaperModel.timeSeconds - remainingSeconds).toString()
        });

    batch.commit();
    navigateToHomePage();
  }
}
