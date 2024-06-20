import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/transaction.dart';
import 'package:personal_finance_tracker/transaction_provider.dart';
import 'package:provider/provider.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final _formKey = GlobalKey<FormState>();
  final List<String> categories = ['Transport', 'Bills', 'Shopping', 'Food'];
  String? selectedCategory;
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense"),
      ),
      body: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 23),
            child: Column(
              children: [
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Expense',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid number';
                    }
                    try {
                      double.parse(value);
                    } catch (e) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 23,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          style: BorderStyle.solid,
                          color: Colors.black54),
                      borderRadius: BorderRadius.circular(3)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      hint: const Text("Select Category"),
                      value: selectedCategory,
                      isExpanded: true,
                      items: categories.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategory = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 23,
                ),
                ElevatedButton(
                  onPressed: () {
                   if (_formKey.currentState!.validate()) {
                    try {
                      double amount = double.parse(_amountController.text);
                      String category = selectedCategory!;

                      Provider.of<TransactionProvider>(context, listen: false).addTransaction(
                        Transaction(type: 'Expense', category: category, amount: amount, color: Colors.red),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Expense Saved')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invalid input')),
                      );
                    }
                  }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          )),
    );
  }
}
