import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/app_icons.dart';
import 'package:study_app/configs/themes/custom_text.styles.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:study_app/widgets/app_circle_button.dart';
import 'package:get/get.dart';

import '../../screens/questions/test_overview_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showActionIcon;
  final Widget? leadingWidget;
  final Widget? titleWidget;
  final VoidCallback? onMenuActionTap;

  const CustomAppBar(
      {Key? key,
      this.title = '',
      this.showActionIcon = false,
      this.leadingWidget,
      this.titleWidget,
      this.onMenuActionTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: mobileScreenPadding, vertical: mobileScreenPadding),
      child: Stack(
        children: [
          Positioned.fill(
              child: titleWidget == null
                  ? Center(
                      child: Text(
                        title,
                        style: appBarText,
                      ),
                    )
                  : Center(
                      child: titleWidget,
                    )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leadingWidget ??
                  Transform.translate(
                    offset: const Offset(-14, 0),
                    child: const BackButton(),
                  ),
              if (showActionIcon)
                Transform.translate(
                  offset: const Offset(10, 0),
                  child: AppCircleButton(
                    onTap: onMenuActionTap ??
                        ()=> Get.toNamed(TestOverviewScreen.routeName),
                    child: const Icon(AppIcons.menu),
                  ),
                )
            ],
          )
        ],
      ),
    ));
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 80);
}
