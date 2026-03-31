import 'package:flutter/material.dart';
import 'bills_screen.dart';
import 'subscriptions_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double myBalance = 0.0;

  List<BillItem> myBills = [];
  List<SubscriptionItem> mySubscriptions = [];

  double get totalBillsAmount {
    double total = 0;
    for (var bill in myBills) {
      total += bill.amount;
    }
    return total;
  }

  double get totalSubscriptionsAmount {
    double total = 0;
    for (var sub in mySubscriptions) {
      total += sub.amount;
    }
    return total;
  }

  void _showMoneyDialog(bool isAdding) {
    TextEditingController amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isAdding ? 'Add to Balance' : 'Remove from Balance'),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Enter amount (e.g. 100)",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  double amount = double.tryParse(amountController.text) ?? 0.0;
                  if (isAdding) {
                    myBalance += amount;
                  } else {
                    myBalance -= amount;
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color cardGreen = Color(0xFF4B9461);
    const Color headerGreen = Color(0xFF65AE78);
    const Color darkText = Color(0xFF264A31);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: headerGreen,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        '<',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: headerGreen,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Text(
                        'MAIN PAGE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardGreen,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Balance:',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      myBalance.toStringAsFixed(2),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 25),
                    InkWell(
                      onTap: () => _showMoneyDialog(true),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add to balance',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            '+',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () => _showMoneyDialog(false),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Remove from balance',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            '-',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardGreen,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'BILLS:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            'TOTAL\nPAYMENT:',
                            '${totalBillsAmount.toStringAsFixed(2)} TL',
                            darkText,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildActionCard('Add Bill', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BillsScreen(
                                  billsList: myBills,
                                  onBillAdded: (newBill) {
                                    setState(() {
                                      myBills.add(newBill);
                                      myBalance -= newBill.amount;
                                    });
                                  },
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      'SUBSCRIPTIONS:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            'TOTAL\nPAYMENT:',
                            '${totalSubscriptionsAmount.toStringAsFixed(2)} TL',
                            darkText,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildActionCard('Add Sub', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubscriptionsScreen(
                                  subscriptionsList: mySubscriptions,
                                  onSubscriptionAdded: (newSub) {
                                    setState(() {
                                      mySubscriptions.add(newSub);
                                      myBalance -= newSub.amount;
                                    });
                                  },
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String amount, Color textColor) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF4B9461),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
