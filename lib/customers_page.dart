import 'package:flutter/material.dart';

class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  // Sample customer data
  List<Map<String, String>> customers = [
    {'id': '1', 'name': 'Alice Johnson', 'email': 'alice@example.com', 'phone': '123-456-7890'},
    {'id': '2', 'name': 'Bob Smith', 'email': 'bob@example.com', 'phone': '098-765-4321'},
    {'id': '3', 'name': 'Charlie Brown', 'email': 'charlie@example.com', 'phone': '555-123-4567'},
  ];

  void _editCustomer(BuildContext context, int index) {
    TextEditingController nameController = TextEditingController(text: customers[index]['name']);
    TextEditingController emailController = TextEditingController(text: customers[index]['email']);
    TextEditingController phoneController = TextEditingController(text: customers[index]['phone']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Customer'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  customers[index]['name'] = nameController.text;
                  customers[index]['email'] = emailController.text;
                  customers[index]['phone'] = phoneController.text;
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

  void _deleteCustomer(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Customer'),
          content: Text('Are you sure you want to delete this customer?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  customers.removeAt(index);
                  // Update IDs
                  for (int i = 0; i < customers.length; i++) {
                    customers[i]['id'] = (i + 1).toString(); // Reassign IDs
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Details'),
      ),
      body: Column(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Customers Overview',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Here you can manage and track your customers.',
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
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('Phone')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: List<DataRow>.generate(customers.length, (index) {
                      return DataRow(cells: [
                        DataCell(Text(customers[index]['id']!)),
                        DataCell(Text(customers[index]['name']!)),
                        DataCell(Text(customers[index]['email']!)),
                        DataCell(Text(customers[index]['phone']!)),
                        DataCell(Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                _editCustomer(context, index);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _deleteCustomer(index);
                              },
                            ),
                          ],
                        )),
                      ]);
                    }),
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
