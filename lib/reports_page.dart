import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample report data
    final List<Map<String, String>> reports = [
      {'title': 'Sales Report - Q1', 'date': '2024-01-31'},
      {'title': 'User Engagement Report - February', 'date': '2024-02-28'},
      {'title': 'Marketing Analysis - March', 'date': '2024-03-31'},
      {'title': 'Financial Overview - April', 'date': '2024-04-30'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reports List',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(reports[index]['title']!),
                      subtitle: Text('Date: ${reports[index]['date']}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: () {
                          // Implement report viewing functionality here
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(reports[index]['title']!),
                                content: const Text('Report details go here.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
