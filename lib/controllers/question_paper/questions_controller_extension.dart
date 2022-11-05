import 'package:study_app/controllers/questions_controller.dart';

extension QuestionsControllerExtension on QuestionsController {
  int get correctQuestionCount =>
      allQuestions
          .where((question) =>
      question.selectedAnswer == question.correctAnswer)
          .toList()
          .length;

  String get correctAnsweredQuestions =>
      '$correctQuestionCount out of ${allQuestions.length} are correct';

  String get points {
    var points = (correctQuestionCount / allQuestions.length) * 100 *
        (questionPaperModel.timeSeconds - remainingSeconds) /
        questionPaperModel.timeSeconds * 100;
    return points.toStringAsFixed(2);
  }
}
