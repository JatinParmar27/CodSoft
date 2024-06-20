import 'package:flutter/material.dart';

class BalanceProvider with ChangeNotifier {
  double _currentBalance = 0;

  double get currentBalance => _currentBalance;

  void updateBalance(double newBalance) {
    _currentBalance = newBalance;
    notifyListeners();
  }
}
