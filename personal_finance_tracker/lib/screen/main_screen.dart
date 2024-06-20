import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/screen/expense.dart';
import 'package:personal_finance_tracker/screen/income.dart';
import 'package:personal_finance_tracker/screen/transactions.dart';
import 'package:personal_finance_tracker/transaction_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    double currentBalance =
        Provider.of<TransactionProvider>(context).currentBalance;
    final List<String> categories = [
      'Salary',
      'Business',
      'Investment',
      'Other',
      'Transport',
      'Bills',
      'Shopping',
      'Food'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Finance Application'),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 23),
        child: Column(
          children: [
            SizedBox(
              height: 120,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Current Balance",
                    style:
                        TextStyle(fontSize: 23, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    '₹$currentBalance'.toString(),
                    style: const TextStyle(
                        fontSize: 50, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 70,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.all(18),
                          backgroundColor: (Colors.green),
                          foregroundColor: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Income()),
                        );
                      },
                      child: const Text(
                        "Add Income",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.all(18),
                          backgroundColor: (Colors.red),
                          foregroundColor: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Expense()),
                        );
                      },
                      child: const Text(
                        "Add Expense",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 70,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.all(18),
                          backgroundColor: (Colors.orange),
                          foregroundColor: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Transactions()),
                        );
                      },
                      child: const Text(
                        "Transactions",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Expanded(child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
              String category = categories[index];
              double totalAmount = Provider.of<TransactionProvider>(context)
                  .getTotalAmountByCategory(category);

              return ListTile(
                  title: Text(category),
                  trailing: Text(
                    '₹${totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ));
            }))
          ],
        ),
      ),
    );
  }
}
