import 'package:flutter/material.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final List<Map<String, String>> reminders = [
    {
      'title': 'Doctor Appointment',
      'date': '2023-10-10',
      'time': '10:00 AM',
    },
    {
      'title': 'Meeting with Bob',
      'date': '2023-10-12',
      'time': '2:00 PM',
    },
    {
      'title': 'Grocery Shopping',
      'date': '2023-10-14',
      'time': '5:00 PM',
    },
    {
      'title': 'Call Mom',
      'date': '2023-10-15',
      'time': '3:00 PM',
    },
  ];

  void _addReminder() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String date = '';
        String time = '';

        return AlertDialog(
          title: const Text('Add Reminder'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
                onChanged: (value) {
                  date = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Time (HH:MM AM/PM)'),
                onChanged: (value) {
                  time = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (title.isNotEmpty && date.isNotEmpty && time.isNotEmpty) {
                  setState(() {
                    reminders.add({
                      'title': title,
                      'date': date,
                      'time': time,
                    });
                  });
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
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
        title: const Text('Reminders'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          final reminder = reminders[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                reminder['title']!,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${reminder['date']} at ${reminder['time']}',
                style: const TextStyle(fontSize: 16),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Action to delete the reminder
                  setState(() {
                    reminders.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addReminder,
        tooltip: 'Add Reminder',
        child: const Icon(Icons.add),
      ),
    );
  }
}
