import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/configs/themes/custom_text.styles.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:study_app/controllers/questions_controller.dart';
import 'package:study_app/screens/questions/test_overview_screen.dart';
import 'package:study_app/widgets/common/background_decoration.dart';
import 'package:get/get.dart';
import 'package:study_app/widgets/common/custom_app_bar.dart';
import 'package:study_app/widgets/common/loading_place_holder.dart';
import 'package:study_app/widgets/common/main_button.dart';
import 'package:study_app/widgets/content_area.dart';
import 'package:study_app/widgets/questions/answer_card.dart';
import 'package:study_app/widgets/questions/countdown_timer.dart';

import '../../firebase_ref/loading_status.dart';

class QuestionScreen extends GetView<QuestionsController> {
  static const String routeName = "/questions";

  const QuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leadingWidget: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: const ShapeDecoration(
              shape: StadiumBorder(
                  side: BorderSide(color: onSurfaceTextColor, width: 2))),
          child: Obx(() => CountdownTimer(
                time: controller.time.value,
                color: onSurfaceTextColor,
              )),
        ),
        showActionIcon: true,
        titleWidget: Obx(() => Text(
              'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
              style: appBarText,
            )),
      ),
      body: BackgroundDecoration(
        child: Obx(() => Column(
              children: [
                if (controller.loadingStatus.value == LoadingStatus.loading)
                  const Expanded(
                      child: ContentArea(child: LoadingPlaceHolder())),
                if (controller.loadingStatus.value == LoadingStatus.completed)
                  Expanded(
                      child: ContentArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          Text(
                            controller.currentQuestions.value!.question,
                            style: questionText,
                          ),
                          GetBuilder<QuestionsController>(
                            id: 'answers_list',
                            builder: (context) {
                              return ListView.separated(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(top: 25),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final answer = controller
                                        .currentQuestions.value!.answers[index];
                                    return AnswerCard(
                                      answer:
                                          '${answer.identifier}. ${answer.answer}',
                                      onTap: () {
                                        controller
                                            .selectedAnswer(answer.identifier);
                                      },
                                      isSelected: answer.identifier ==
                                          controller.currentQuestions.value!
                                              .selectedAnswer,
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const SizedBox(
                                            height: 10,
                                          ),
                                  itemCount: controller
                                      .currentQuestions.value!.answers.length);
                            },
                          ),
                        ],
                      ),
                    ),
                  )),
                ColoredBox(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: UIParameters.mobileScreenPadding,
                    child: Row(
                      children: [
                        Visibility(
                            visible: controller.isFirstQuestion,
                            child: SizedBox(
                              width: 55,
                              height: 55,
                              child: MainButton(
                                onTap: () {
                                  controller.prevQuestion();
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: UIParameters.isDarkMode()
                                      ? onSurfaceTextColor
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                            )),
                        Expanded(
                          child: Visibility(
                              visible: controller.loadingStatus.value ==
                                  LoadingStatus.completed,
                              child: MainButton(
                                onTap: () {
                                  controller.isLastQuestion
                                      ? Get.toNamed(
                                          TestOverviewScreen.routeName)
                                      : controller.nextQuestion();
                                },
                                title: controller.isLastQuestion
                                    ? 'Complete'
                                    : 'Next',
                              )),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
