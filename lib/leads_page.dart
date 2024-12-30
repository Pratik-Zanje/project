import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LeadsPage extends StatefulWidget {
  const LeadsPage({super.key});

  @override
  _LeadsPageState createState() => _LeadsPageState();
}

class _LeadsPageState extends State<LeadsPage> {
  final List<Map<String, String>> leads = [
    {
      'id': '1',
      'name': 'Swapy',
      'email': 'swapy@example.com',
      'phone': '123-456-7890',
      'source': 'Website',
      'status': 'New',
    },
    {
      'id': '2',
      'name': 'Boby',
      'email': 'bob@example.com',
      'phone': '098-765-4321',
      'source': 'Referral',
      'status': 'Contacted',
    },
    {
      'id': '3',
      'name': 'Charlie',
      'email': 'charlie@example.com',
      'phone': '555-555-5555',
      'source': 'Social Media',
      'status': 'Follow Up',
    },
    {
      'id': '4',
      'name': 'Mufasa',
      'email': 'mufasa@example.com',
      'phone': '777-777-7777',
      'source': 'Direct Call',
      'status': 'Closed',
    },
  ];

  void _addLead(Map<String, String> newLead) {
    setState(() {
      leads.add(newLead);
    });
  }

  void _showAddLeadDialog({Map<String, String>? leadToEdit}) {
    final TextEditingController nameController = TextEditingController(text: leadToEdit?['name']);
    final TextEditingController emailController = TextEditingController(text: leadToEdit?['email']);
    final TextEditingController phoneController = TextEditingController(text: leadToEdit?['phone']);
    final TextEditingController sourceController = TextEditingController(text: leadToEdit?['source']);
    String status = leadToEdit?['status'] ?? 'New';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(leadToEdit == null ? 'Add New Lead' : 'Edit Lead'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: sourceController,
                decoration: const InputDecoration(labelText: 'Lead Source'),
              ),
              DropdownButton<String>(
                value: status,
                items: <String>['New', 'Contacted', 'Follow Up', 'Closed']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    status = newValue!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    phoneController.text.isNotEmpty &&
                    sourceController.text.isNotEmpty) {
                  if (leadToEdit == null) {
                    _addLead({
                      'id': (leads.length + 1).toString(),
                      'name': nameController.text,
                      'email': emailController.text,
                      'phone': phoneController.text,
                      'source': sourceController.text,
                      'status': status,
                    });
                  } else {
                    setState(() {
                      leadToEdit['name'] = nameController.text;
                      leadToEdit['email'] = emailController.text;
                      leadToEdit['phone'] = phoneController.text;
                      leadToEdit['source'] = sourceController.text;
                      leadToEdit['status'] = status;
                    });
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Text(leadToEdit == null ? 'Add Lead' : 'Save Changes'),
            ),
          ],
        );
      },
    );
  }

  void _showFollowUpOptions(String leadName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Follow Up Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.watch_later_sharp, color: Colors.green),
                title: const Text('WhatsApp'),
                onTap: () {
                  Navigator.of(context).pop();
                  if (kDebugMode) {
                    print('WhatsApp follow-up for $leadName');
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.message, color: Colors.blue),
                title: const Text('Message'),
                onTap: () {
                  Navigator.of(context).pop();
                  if (kDebugMode) {
                    print('Message follow-up for $leadName');
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.email, color: Colors.red),
                title: const Text('Email'),
                onTap: () {
                  Navigator.of(context).pop();
                  if (kDebugMode) {
                    print('Email follow-up for $leadName');
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteLead(Map<String, String> lead) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Lead'),
          content: const Text('Are you sure you want to delete this lead?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  leads.remove(lead); // Remove the lead
                  _rearrangeIds(); // Rearrange IDs after deletion
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _rearrangeIds() {
    for (int i = 0; i < leads.length; i++) {
      leads[i]['id'] = (i + 1).toString(); // Update ID to be 1-based index
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leads'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Leads Overview',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Here you can manage and track your leads.',
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
                child: DataTable(
                  border: TableBorder.all(
                    color: Colors.black, // Set the color of the border
                    width: 1.0, // Set the width of the border
                  ),
                  columns: const [
                    DataColumn(label: Text('Id')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Phone')),
                    DataColumn(label: Text('Lead Source')),
                    DataColumn(label: Text('Lead Status')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: leads.map((lead) {
                    return DataRow(cells: [
                      DataCell(Text(lead['id']!)),
                      DataCell(Text(lead['name']!)),
                      DataCell(Text(lead['email']!)),
                      DataCell(Text(lead['phone']!)),
                      DataCell(Text(lead['source']!)),
                      DataCell(
                        Chip(
                          label: Text(lead['status']!),
                          backgroundColor: _getStatusColor(lead['status']!),
                        ),
                      ),
                      DataCell(
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert),
                          onSelected: (value) {
                            if (value == 'Follow Up') {
                              _showFollowUpOptions(lead['name']!);
                            } else if (value == 'Edit') {
                              _showAddLeadDialog(leadToEdit: lead);
                            } else if (value == 'Delete') {
                              _deleteLead(lead);
                            } else {
                              // Handle other actions based on selected value
                              if (kDebugMode) {
                                print('$value action for ${lead['name']} (ID: ${lead['id']})');
                              }
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              const PopupMenuItem<String>(
                                value: 'Follow Up',
                                child: Row(
                                  children: [
                                    Icon(Icons.follow_the_signs, color: Colors.blue),
                                    SizedBox(width: 10),
                                    Text('Follow Up'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem<String>(
                                value: 'Auto Assign',
                                child: Row(
                                  children: [
                                    Icon(Icons.assignment, color: Colors.green),
                                    SizedBox(width: 10),
                                    Text('Auto Assign'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem<String>(
                                value: 'Convert to Customer',
                                child: Row(
                                  children: [
                                    Icon(Icons.person_add, color: Colors.orange),
                                    SizedBox(width: 10),
                                    Text('Convert to Customer'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem<String>(
                                value: 'Edit',
                                child: Row(
                                  children: [
                                    Icon(Icons.edit, color: Colors.yellow),
                                    SizedBox(width: 10),
                                    Text('Edit'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem<String>(
                                value: 'Delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: Colors.red),
                                    SizedBox(width: 10),
                                    Text('Delete'),
                                  ],
                                ),
                              ),
                            ];
                          },
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddLeadDialog(),
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'New':
        return Colors.green;
      case 'Contacted':
        return Colors.blue;
      case 'Follow Up':
        return Colors.orange;
      case 'Closed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
