import 'package:flutter/widgets.dart';

double widthFactor(BuildContext context) =>
    MediaQuery.of(context).size.width / 1440;

double heightFactor(BuildContext context) =>
    MediaQuery.of(context).size.height / 1024;
