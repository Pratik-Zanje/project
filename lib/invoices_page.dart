import 'package:flutter/material.dart';

class InvoicePage extends StatefulWidget {
  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  // Sample data
  List<Map<String, String>> invoices = [
    {'id': '1', 'invoiceNo': 'INV-001', 'customer': 'John Doe', 'date': '2024-10-01', 'status': 'Paid'},
    {'id': '2', 'invoiceNo': 'INV-002', 'customer': 'Jane Smith', 'date': '2024-10-05', 'status': 'Pending'},
    {'id': '3', 'invoiceNo': 'INV-003', 'customer': 'Sam Wilson', 'date': '2024-10-10', 'status': 'Overdue'},
  ];

  void _editInvoice(int index) {
    final invoice = invoices[index];
    TextEditingController invoiceNoController = TextEditingController(text: invoice['invoiceNo']);
    TextEditingController customerController = TextEditingController(text: invoice['customer']);
    TextEditingController dateController = TextEditingController(text: invoice['date']);
    TextEditingController statusController = TextEditingController(text: invoice['status']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Invoice'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: invoiceNoController, decoration: InputDecoration(labelText: 'Invoice No')),
                TextField(controller: customerController, decoration: InputDecoration(labelText: 'Customer Name')),
                TextField(controller: dateController, decoration: InputDecoration(labelText: 'Invoice Date')),
                TextField(controller: statusController, decoration: InputDecoration(labelText: 'Status')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  invoices[index]['invoiceNo'] = invoiceNoController.text;
                  invoices[index]['customer'] = customerController.text;
                  invoices[index]['date'] = dateController.text;
                  invoices[index]['status'] = statusController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _deleteInvoice(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Invoice'),
          content: Text('Are you sure you want to delete this invoice?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  invoices.removeAt(index); // Removes the selected invoice
                  // Update IDs
                  for (int i = 0; i < invoices.length; i++) {
                    invoices[i]['id'] = (i + 1).toString(); // Reassign IDs
                  }
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancel action
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Details'),
      ),
      body: Column(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Invoices Overview',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Here you can manage and track your invoices.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1), // Border for the table
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: DataTable(
                    border: TableBorder(
                      horizontalInside: BorderSide(color: Colors.grey, width: 1),
                      verticalInside: BorderSide(color: Colors.grey, width: 1),
                      top: BorderSide(color: Colors.grey, width: 1),
                      bottom: BorderSide(color: Colors.grey, width: 1),
                      left: BorderSide(color: Colors.grey, width: 1),
                      right: BorderSide(color: Colors.grey, width: 1),
                    ),
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Invoice No')),
                      DataColumn(label: Text('Customer')),
                      DataColumn(label: Text('Invoice Date')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: List<DataRow>.generate(
                      invoices.length,
                          (index) {
                        return DataRow(cells: [
                          DataCell(Text(invoices[index]['id']!)),
                          DataCell(Text(invoices[index]['invoiceNo']!)),
                          DataCell(Text(invoices[index]['customer']!)),
                          DataCell(Text(invoices[index]['date']!)),
                          DataCell(Text(invoices[index]['status']!)),
                          DataCell(Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _editInvoice(index),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteInvoice(index),
                              ),
                            ],
                          )),
                        ]);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
