import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dashboard_page.dart';

class CallsPage extends StatefulWidget {
  @override
  _CallsPageState createState() => _CallsPageState();
}

class _CallsPageState extends State<CallsPage> {
  List<CallLogEntry> calls = [];

  @override
  void initState() {
    super.initState();
    _fetchCallLogs();
  }

  Future<void> _fetchCallLogs() async {
    var status = await Permission.phone.request();
    if (status.isGranted) {
      Iterable<CallLogEntry> callLogs = await CallLog.get();
      setState(() {
        calls = callLogs.toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission to access call logs was denied.')),
      );
    }
  }

  // Method to format the timestamp
  String formatTimestamp(int? timestamp) {
    if (timestamp == null) {
      return 'Unknown time'; // Placeholder for null timestamps
    }
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calls'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Dashboard(message: '',)));
          },
        ),
      ),
      body: ListView.builder(
        itemCount: calls.length,
        itemBuilder: (context, index) {
          final call = calls[index];
          return ListTile(
            leading: Icon(
              call.callType == CallType.incoming
                  ? Icons.call_received
                  : call.callType == CallType.outgoing
                  ? Icons.call_made
                  : Icons.call_missed,
              color: call.callType == CallType.missed ? Colors.red : Colors.green,
            ),
            title: Text(call.name ?? 'Unknown'),
            subtitle: Text(formatTimestamp(call.timestamp)), // Use the updated method
          );
        },
      ),
    );
  }
}
