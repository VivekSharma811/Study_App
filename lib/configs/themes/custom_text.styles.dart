import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';

TextStyle cardTitle(BuildContext context) => TextStyle(
    color: UIParameters.isDarkMode()
        ? Theme.of(context).textTheme.bodyText1!.color
        : Theme.of(context).primaryColor,
    fontSize: 18,
    fontWeight: FontWeight.bold);

const detailText = TextStyle(fontSize: 12);
