import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:study_app/configs/themes/custom_text.styles.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:study_app/controllers/question_paper/questions_controller_extension.dart';
import 'package:study_app/controllers/questions_controller.dart';
import 'package:get/get.dart';
import 'package:study_app/widgets/common/background_decoration.dart';
import 'package:study_app/widgets/common/custom_app_bar.dart';
import 'package:study_app/widgets/content_area.dart';
import 'package:study_app/widgets/questions/answer_card.dart';
import 'package:study_app/widgets/questions/question_number_card.dart';

class ResultScreen extends GetView<QuestionsController> {
  const ResultScreen({Key? key}) : super(key: key);

  static const String routeName = "/result";

  @override
  Widget build(BuildContext context) {
    Color _textColor = UIParameters.isDarkMode()
        ? Colors.white
        : Theme.of(context).primaryColor;
    return Scaffold(
        body: BackgroundDecoration(
      child: Column(
        children: [
          CustomAppBar(
            leadingWidget: const SizedBox(height: 80),
            title: controller.correctAnsweredQuestions,
          ),
          Expanded(
              child: ContentArea(
            child: Column(
              children: [
                SvgPicture.asset("assets/images/bulb.svg"),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 5),
                  child: Text(
                    'Congratulations',
                    style: headerText.copyWith(color: _textColor),
                  ),
                ),
                Text(
                  'You have got ${controller.points} points',
                  style: TextStyle(color: _textColor),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'Tab below to view correct answers',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 25,
                ),
                Expanded(
                    child: GridView.builder(
                        itemCount: controller.allQuestions.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Get.width ~/ 75,
                            childAspectRatio: 1,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                        itemBuilder: (_, int index) {
                          final _question = controller.allQuestions[index];
                          AnswerStatus _status = AnswerStatus.notAnswered;
                          final _selectedAnswer = _question.selectedAnswer;
                          final _correctAnswer = _question.correctAnswer;
                          if (_selectedAnswer == _correctAnswer) {
                            _status = AnswerStatus.correct;
                          } else if (_selectedAnswer == null) {
                            _status = AnswerStatus.notAnswered;
                          } else {
                            _status = AnswerStatus.wrong;
                          }
                          return QuestionNumberCard(
                              index: index + 1,
                              status: _status,
                              onTap: () => controller.jumpToQuestion(index,
                                  isGoBack: false));
                        }))
              ],
            ),
          ))
        ],
      ),
    ));
  }
}
