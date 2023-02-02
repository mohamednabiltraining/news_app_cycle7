import 'package:flutter/material.dart';
import 'package:news_app/base/base_navigator.dart';

class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier {
  N? navigator;
}
