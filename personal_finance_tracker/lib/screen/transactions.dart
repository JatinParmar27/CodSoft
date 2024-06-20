import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/transaction_provider.dart';
import 'package:provider/provider.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});


  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  final transactions = Provider.of<TransactionProvider>(context).transactions;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Transactions"),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return ListTile(
            leading: Icon(Icons.monetization_on, color: transaction.color),
            title: Text(transaction.category),
            subtitle: Text(transaction.amount.toString()),
          );
        },
      ),
    );
  }
}
