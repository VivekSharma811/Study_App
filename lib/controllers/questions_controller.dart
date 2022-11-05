import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:study_app/firebase_ref/loading_status.dart';
import 'package:study_app/firebase_ref/references.dart';
import 'package:study_app/models/question_paper_model.dart';
import 'package:study_app/screens/questions/result_screen.dart';

class QuestionsController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;

  late QuestionPaperModel questionPaperModel;
  late List<Questions> allQuestions = <Questions>[];
  Rxn<Questions> currentQuestions = Rxn<Questions>();
  final questionIndex = 0.obs;

  bool get isFirstQuestion => questionIndex.value > 0;

  bool get isLastQuestion => questionIndex.value >= allQuestions.length - 1;

  //Timer
  Timer? _timer;
  int remainingSeconds = 1;
  final time = '00.00'.obs;

  @override
  void onReady() {
    final _questionPaper = Get.arguments as QuestionPaperModel;
    loadData(_questionPaper);
    super.onReady();
  }

  void loadData(QuestionPaperModel questionPaper) async {
    questionPaperModel = questionPaper;
    loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionsQuery =
          await questionPaperRF
              .doc(questionPaper.id)
              .collection("questions")
              .get();
      final questions = questionsQuery.docs
          .map((snapshot) => Questions.fromSnapshot(snapshot))
          .toList();

      questionPaper.questions = questions;

      for (var question in questionPaper.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answersSnapshot =
            await questionPaperRF
                .doc(questionPaper.id)
                .collection("questions")
                .doc(question.id)
                .collection("answers")
                .get();

        final answers = answersSnapshot.docs
            .map((snapshot) => Answers.fromSnapshot(snapshot))
            .toList();
        question.answers = answers;
      }
      if (questionPaper.questions != null &&
          questionPaper.questions!.isNotEmpty) {
        allQuestions.assignAll(questionPaper.questions!);
        currentQuestions.value = questionPaper.questions![0];
        _startTimer(questionPaper.timeSeconds);
        loadingStatus.value = LoadingStatus.completed;
      } else {
        loadingStatus.value = LoadingStatus.error;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void selectedAnswer(String? answer) {
    currentQuestions.value!.selectedAnswer = answer;
    update(['answers_list']);
  }

  void nextQuestion() {
    if (questionIndex.value >= allQuestions.length - 1) return;
    questionIndex.value++;

    currentQuestions.value = allQuestions[questionIndex.value];
  }

  void prevQuestion() {
    if (questionIndex.value <= 0) return;
    questionIndex.value--;
    currentQuestions.value = allQuestions[questionIndex.value];
  }

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = remainingSeconds % 60;
        time.value =
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        remainingSeconds--;
      }
    });
  }

  String get completedAnswerDetails {
    final answered = allQuestions
        .where((element) => element.selectedAnswer != null)
        .toList()
        .length;
    return '$answered out of ${allQuestions.length} answered';
  }

  void jumpToQuestion(int index, {bool isGoBack = true}) {
    questionIndex.value = index;
    currentQuestions.value = allQuestions[index];
    if (isGoBack) Get.back();
  }

  void finishQuiz() {
    _timer?.cancel();
    Get.offAndToNamed(ResultScreen.routeName);
  }
}
