import 'dart:core';

import 'package:flutter/material.dart';
import 'transaction.dart';

class TransactionProvider with ChangeNotifier {
  final List<Transaction> _transactions = []; 
  
  double _currentBalance = 0;

  List<Transaction> get transactions => _transactions;
  // List<Category> get categories => _categories;
  double get currentBalance => _currentBalance;

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);

    // Update current balance based on transaction type
    if (transaction.type == 'Income') {
      _currentBalance += transaction.amount;
    } else if (transaction.type == 'Expense') {
      _currentBalance -= transaction.amount;
    }

    notifyListeners();
  }

  double getTotalAmountByCategory(String category) {
    double totalAmount = 0.0;
    for (var transaction in _transactions) {
      if (transaction.category == category) {
        totalAmount += transaction.amount;
      }
    }
    return totalAmount;
}
}