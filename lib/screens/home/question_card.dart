import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/app_icons.dart';
import 'package:study_app/configs/themes/custom_text.styles.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:study_app/models/question_paper_model.dart';
import 'package:get/get.dart';
import 'package:study_app/widgets/app_icon_text.dart';

class QuestionCard extends StatelessWidget {
  final QuestionPaperModel model;

  const QuestionCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _padding = 10.0;
    return Container(
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: Theme.of(context).cardColor),
      child: Padding(
        padding: const EdgeInsets.all(_padding),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ColoredBox(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    child: SizedBox(
                      height: Get.width * 0.15,
                      width: Get.width * 0.15,
                      child: CachedNetworkImage(
                        imageUrl: model.imageUrl!,
                        placeholder: (context, url) => Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            Image.asset("assets/images/app_splash_logo.png"),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title,
                        style: cardTitle(context),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 15),
                          child: Text(model.description)),
                      Row(
                        children: [
                          AppIconText(
                              icon: Icon(
                                Icons.help_outline_sharp,
                                color: UIParameters.isDarkMode()
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                              text: Text(
                                '${model.questionCount} questions',
                                style: detailText.copyWith(
                                    color: UIParameters.isDarkMode()
                                        ? Colors.white
                                        : Theme.of(context).primaryColor),
                              )),
                          const SizedBox(
                            width: 15,
                          ),
                          AppIconText(
                              icon: Icon(
                                Icons.timer,
                                color: UIParameters.isDarkMode()
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                              text: Text(
                                model.timeInMinutes(),
                                style: detailText.copyWith(
                                    color: UIParameters.isDarkMode()
                                        ? Colors.white
                                        : Theme.of(context).primaryColor),
                              )),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Positioned(
                bottom: -_padding,
                right: -_padding,
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    child: const Icon(
                      AppIcons.trophyOutline,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(cardBorderRadius),
                            bottomRight: Radius.circular(cardBorderRadius)),
                        color: Theme.of(context).primaryColor),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
