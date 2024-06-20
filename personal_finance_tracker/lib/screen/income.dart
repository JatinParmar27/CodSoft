import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/transaction.dart';
import 'package:personal_finance_tracker/transaction_provider.dart';
import 'package:provider/provider.dart';

class Income extends StatefulWidget {
  const Income({super.key});

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  final _formKey = GlobalKey<FormState>();
  final List<String> categories = ['Salary', 'Business', 'Investment', 'Other'];
  String? selectedCategory;
  final TextEditingController _amountController = TextEditingController();
  
  get amount => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Income"),
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
                    hintText: 'Income',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please valid Number';
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

                        Provider.of<TransactionProvider>(context, listen: false)
                            .addTransaction(
                          Transaction(
                              type: 'Income',
                              category: category,
                              amount: amount,
                              color: Colors.green),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Data Saved')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid input ')),
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
