import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final List<Map<String, dynamic>> attendees = [
    {'name': 'Saurabh', 'present': false},
    {'name': 'Bunty', 'present': false},
    {'name': 'Charlie', 'present': false},
    {'name': 'Mufasa', 'present': false},
  ];

  void _toggleAttendance(int index) {
    setState(() {
      attendees[index]['present'] = !attendees[index]['present'];
    });
  }

  void _addAttendee(String name) {
    if (name.isNotEmpty) {
      setState(() {
        attendees.add({'name': name, 'present': false});
      });
    }
  }

  void _showAddAttendeeDialog() {
    String newName = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Attendee'),
          content: TextField(
            onChanged: (value) {
              newName = value;
            },
            decoration: const InputDecoration(hintText: 'Enter name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addAttendee(newName);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddAttendeeDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Attendance List',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: attendees.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(attendees[index]['name']),
                      trailing: Checkbox(
                        value: attendees[index]['present'],
                        onChanged: (value) {
                          _toggleAttendance(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle save action here
                final presentCount = attendees.where((a) => a['present']).length;
                final totalCount = attendees.length;
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Attendance Summary'),
                    content: Text('Total Present: $presentCount / $totalCount'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Save Attendance'),
            ),
          ],
        ),
      ),
    );
  }
}
