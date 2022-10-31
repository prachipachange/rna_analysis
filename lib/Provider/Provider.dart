import 'package:flutter/cupertino.dart';

class ProviderModifier extends ChangeNotifier {
  bool spinner = false;
  void updateSpinner(bool value) {
    this.spinner = value;
    notifyListeners();
  }
}
