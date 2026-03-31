import 'package:flutter/material.dart';

class BillItem {
  final String name;
  final double amount;

  BillItem({required this.name, required this.amount});
}

class BillsScreen extends StatefulWidget {
  final List<BillItem> billsList;
  final Function(BillItem) onBillAdded;

  const BillsScreen({
    super.key,
    required this.billsList,
    required this.onBillAdded,
  });

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  void _showAddBillDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Bill'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Bill Name (e.g. Water)',
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
                  BillItem newBill = BillItem(
                    name: nameController.text,
                    amount: double.tryParse(amountController.text) ?? 0.0,
                  );
                  widget.onBillAdded(newBill);
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
        title: const Text('My Bills'),
        backgroundColor: const Color(0xFF4A9060),
        foregroundColor: Colors.white,
      ),

      body: widget.billsList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No bills added yet.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF264A31),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _showAddBillDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF264A31),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      "Create New Bill",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: widget.billsList.length,
              itemBuilder: (context, index) {
                final bill = widget.billsList[index];
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
                      bill.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    trailing: Text(
                      "${bill.amount.toStringAsFixed(2)} TL",
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
      floatingActionButton: widget.billsList.isNotEmpty
          ? FloatingActionButton(
              onPressed: _showAddBillDialog,
              backgroundColor: const Color(0xFF4A9060),
              foregroundColor: Colors.white,
              child: const Text('+', style: TextStyle(fontSize: 28)),
            )
          : null,
    );
  }
}
