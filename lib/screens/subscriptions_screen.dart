import 'package:flutter/material.dart';

class SubscriptionItem {
  final String name;
  final double amount;

  SubscriptionItem({required this.name, required this.amount});
}

class SubscriptionsScreen extends StatefulWidget {
  final List<SubscriptionItem> subscriptionsList;
  final Function(SubscriptionItem) onSubscriptionAdded;

  const SubscriptionsScreen({
    super.key,
    required this.subscriptionsList,
    required this.onSubscriptionAdded,
  });

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  void _showAddSubscriptionDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Subscription'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Subscription Name (e.g. Netflix)',
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount (TL)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    amountController.text.isNotEmpty) {
                  SubscriptionItem newSub = SubscriptionItem(
                    name: nameController.text,
                    amount: double.tryParse(amountController.text) ?? 0.0,
                  );
                  widget.onSubscriptionAdded(newSub);
                  setState(() {});
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4B9461),
                foregroundColor: Colors.white,
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAEFEB),
      appBar: AppBar(
        title: const Text('My Subscriptions'),
        backgroundColor: const Color(0xFF4A9060),
        foregroundColor: Colors.white,
      ),

      body: widget.subscriptionsList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No subscriptions added yet.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF264A31),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _showAddSubscriptionDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF264A31),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      "Create New Sub",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: widget.subscriptionsList.length,
              itemBuilder: (context, index) {
                final sub = widget.subscriptionsList[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    title: Text(
                      sub.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    trailing: Text(
                      "${sub.amount.toStringAsFixed(2)} TL",
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: Color(0xFF264A31),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: widget.subscriptionsList.isNotEmpty
          ? FloatingActionButton(
              onPressed: _showAddSubscriptionDialog,
              backgroundColor: const Color(0xFF4A9060),
              foregroundColor: Colors.white,
              child: const Text('+', style: TextStyle(fontSize: 28)),
            )
          : null,
    );
  }
}
