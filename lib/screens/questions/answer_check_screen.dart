import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/themes/custom_text.styles.dart';
import 'package:study_app/controllers/questions_controller.dart';
import 'package:study_app/screens/questions/result_screen.dart';
import 'package:study_app/widgets/common/background_decoration.dart';
import 'package:study_app/widgets/common/custom_app_bar.dart';
import 'package:study_app/widgets/content_area.dart';
import 'package:study_app/widgets/questions/answer_card.dart';

class AnswerCheckScreen extends GetView<QuestionsController> {
  const AnswerCheckScreen({Key? key}) : super(key: key);

  static const String routeName = "/checkAnswer";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(() =>
            Text(
              'Q. ${(controller.questionIndex.value + 1).toString().padLeft(
                  2, '0')}',
              style: appBarText,
            )),
        showActionIcon: true,
        onMenuActionTap: () {
          Get.toNamed(ResultScreen.routeName);
        },
      ),
      body: BackgroundDecoration(
        child: Obx(() =>
            Column(
              children: [
                Expanded(
                    child: ContentArea(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Text(controller.currentQuestions.value!.question),
                            GetBuilder<QuestionsController>(
                              id: 'answer_check_list',
                              builder: (_) {
                                return ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, int index) {
                                      final answer = controller.currentQuestions
                                          .value!.answers[index];
                                      final _selectedAnswer = controller
                                          .currentQuestions.value!
                                          .selectedAnswer;
                                      final _correctAnswer = controller
                                          .currentQuestions.value!
                                          .correctAnswer;
                                      final answerText = '${answer
                                          .identifier}. ${answer.answer}';
                                      if (_correctAnswer == _selectedAnswer &&
                                          answer.identifier ==
                                              _selectedAnswer) {
                                        return CorrectAnswer(answer: answerText);
                                      } else if (_selectedAnswer == null) {
                                        return NotAnswered(answer: answerText);
                                      } else
                                      if (_correctAnswer != _selectedAnswer &&
                                          answer.identifier ==
                                              _selectedAnswer) {
                                        return WrongAnswer(answer: answerText);
                                      } else
                                      if (_correctAnswer == answer.identifier) {
                                        return CorrectAnswer(answer: answerText);
                                      }
                                        return AnswerCard(
                                            answer: answerText,
                                            isSelected: false,
                                            onTap: () {

                                        });
                                    },
                                    separatorBuilder: (_, int index) {
                                      return const SizedBox(height: 10,);
                                    },
                                    itemCount: controller
                                        .currentQuestions.value!.answers
                                        .length);
                              },
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
