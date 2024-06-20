import 'dart:ui';
// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';

class Transaction {
  final String type;
  final String category;
  final double amount;
  final Color color;

  Transaction({
    required this.type,
    required this.category,
    required this.amount,
    required this.color,
  });
}
