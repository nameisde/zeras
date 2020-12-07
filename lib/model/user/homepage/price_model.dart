import 'package:flutter/foundation.dart';

class PriceModel with ChangeNotifier {
  int _price = 1500;

  int get price => _price;
  set price(int value) {
    _price = value;
    notifyListeners();
  }
}
