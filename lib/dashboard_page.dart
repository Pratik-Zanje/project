import 'package:flutter/material.dart';
import 'package:pratik_2/reminder.dart';
import 'package:pratik_2/reports_page.dart';
import 'attendance_page.dart';
import 'calls_page.dart';
import 'card_widget.dart';
import 'customers_page.dart';
import 'header.dart';
import 'invoices_page.dart';
import 'leads_page.dart';
import 'login_page.dart';
import 'notice_board_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required String message});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _isDarkMode = false; // State variable for theme mode

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode; // Toggle dark mode
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Dashboard'),
            IconButton(
              icon: Icon(_isDarkMode ? Icons.brightness_7 : Icons.brightness_2),
              onPressed: _toggleTheme,
            ),
          ],
        ),
      ),

      drawer: Drawer(
        // Set background color based on dark mode
        child: Container(
          color: _isDarkMode ? Colors.black : Colors.white, // Set drawer background color
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: _isDarkMode ? Colors.grey[850] : Colors.blueAccent,
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/tiger.png'),
                      radius: 40,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Admin Panel',
                      style: TextStyle(
                        color: _isDarkMode ? Colors.white : Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              // Update ListTile text color based on dark mode
              ListTile(
                leading: const Icon(Icons.home, color: Colors.blue),
                title: Text(
                  'Home',
                  style: TextStyle(
                    color: _isDarkMode ? Colors.white : Colors.black, // Text color
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Dashboard(message: '')));
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications, color: Colors.blue),
                title: Text(
                  'Reminder',
                  style: TextStyle(
                    color: _isDarkMode ? Colors.white : Colors.black, // Text color
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ReminderPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.report, color: Colors.blue),
                title: Text(
                  'Reports',
                  style: TextStyle(
                    color: _isDarkMode ? Colors.white : Colors.black, // Text color
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ReportsPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.note_alt, color: Colors.blue),
                title: Text(
                  'Attendance',
                  style: TextStyle(
                    color: _isDarkMode ? Colors.white : Colors.black, // Text color
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AttendancePage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.event_note, color: Colors.blue),
                title: Text(
                  'Notice Board',
                  style: TextStyle(
                    color: _isDarkMode ? Colors.white : Colors.black, // Text color
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NoticeBoardPage()));
                },
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body:  Container(
        color: _isDarkMode ? Colors.black : const Color(0xFFFFFFFF),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dashboard Overview Title
              Center(
                child: Text(
                  'Dashboard Overview',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _isDarkMode ? Colors.white : Colors.black, // Color condition
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              // First Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LeadsPage()));
                    },
                    child: const SizedBox(
                      width: 150,
                      height: 150,
                      child: CardWidget(
                        title: 'Leads',
                        color: Color(0xFF4DD0E1),
                        icon: Icons.accessibility_new_sharp,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerPage()));
                    },
                    child: const SizedBox(
                      width: 150,
                      height: 150,
                      child: CardWidget(
                        title: 'Customers',
                        color: Color(0xFF4DD0E1),
                        icon: Icons.people,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Second Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => InvoicePage()));
                    },
                    child: const SizedBox(
                      width: 150,
                      height: 150,
                      child: CardWidget(
                        title: 'Invoices',
                        color: Color(0xFF4DD0E1),
                        icon: Icons.attach_money,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CallsPage()));
                    },
                    child: const SizedBox(
                      width: 150,
                      height: 150,
                      child: CardWidget(
                        title: 'Calls',
                        color: Color(0xFF4DD0E1),
                        icon: Icons.call,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Lead Sources Table
              Center(
                child: Text(
                  'Lead Sources',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,
                    color: _isDarkMode ? Colors.white : Colors.black,),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: _isDarkMode ? Colors.grey[850] : Colors.blue[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('Source',
                          style: TextStyle(
                          color: _isDarkMode ? Colors.white : Colors.black,),)),
                        DataColumn(label: Text('Count',
                          style: TextStyle(
                            color: _isDarkMode ? Colors.white : Colors.black,),)),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Row(
                            children: [
                              const Icon(Icons.facebook, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text('Facebook',
                                style: TextStyle(
                                  color: _isDarkMode ? Colors.white : Colors.black,),
                              ),
                            ],
                          )),
                          DataCell(Text('10',
                            style: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black,),)),
                        ]),
                        DataRow(cells: [
                          DataCell(Row(
                            children: [
                              const Icon(Icons.group, color: Colors.green),
                              const SizedBox(width: 8),
                              Text('Referral',
                                style: TextStyle(
                                  color: _isDarkMode ? Colors.white : Colors.black,),),
                            ],
                          )),
                          DataCell(Text('5',
                            style: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black,),)),
                        ]),
                        DataRow(cells: [
                          DataCell(Row(
                            children: [
                              const Icon(Icons.share, color: Colors.orange),
                              const SizedBox(width: 8),
                              Text('Social Media',
                                style: TextStyle(
                                  color: _isDarkMode ? Colors.white : Colors.black,),),
                            ],
                          )),
                          DataCell(Text('8',
                            style: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black,),)),
                        ]),
                        DataRow(cells: [
                          DataCell(Row(
                            children: [
                              const Icon(Icons.email, color: Colors.red),
                              const SizedBox(width: 8),
                              Text('Email Campaign',
                                style: TextStyle(
                                  color: _isDarkMode ? Colors.white : Colors.black,),),
                            ],
                          )),
                          DataCell(Text('4',
                            style: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black,),)),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Lead Status Overview Table
              Center(
                child: Text(
                  'Lead Status Overview',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,
                    color: _isDarkMode ? Colors.white : Colors.black,),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: _isDarkMode ? Colors.grey[850] : Colors.green[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('Status',
                          style: TextStyle(
                            color: _isDarkMode ? Colors.white : Colors.black,),)),
                        DataColumn(label: Text('Count',
                          style: TextStyle(
                            color: _isDarkMode ? Colors.white : Colors.black,),)),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Row(
                            children: [
                              const Icon(Icons.fiber_new, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text('New Leads',
                                style: TextStyle(
                                  color: _isDarkMode ? Colors.white : Colors.black,),),
                            ],
                          )),
                          DataCell(Text('12',
                            style: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black,),)),
                        ]),
                        DataRow(cells: [
                          DataCell(Row(
                            children: [
                              const Icon(Icons.access_time, color: Colors.orange),
                              const SizedBox(width: 8),
                              Text('In Progress',
                                style: TextStyle(
                                  color: _isDarkMode ? Colors.white : Colors.black,),),
                            ],
                          )),
                          DataCell(Text('5',
                            style: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black,),)),
                        ]),
                        DataRow(cells: [
                          DataCell(Row(
                            children: [
                              const Icon(Icons.check_circle, color: Colors.green),
                              const SizedBox(width: 8),
                              Text('Total Leads',
                                style: TextStyle(
                                  color: _isDarkMode ? Colors.white : Colors.black,),),
                            ],
                          )),
                          DataCell(Text('8',
                            style: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black,),)),
                        ]),
                        DataRow(cells: [
                          DataCell(Row(
                            children: [
                              const Icon(Icons.cancel, color: Colors.red),
                              const SizedBox(width: 8),
                              Text('Closed Lost',
                                style: TextStyle(
                                  color: _isDarkMode ? Colors.white : Colors.black,),),
                            ],
                          )),
                          DataCell(Text('3',
                            style: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black,),)),
                        ]),
                        DataRow(cells: [
                          DataCell(Row(
                            children: [
                              const Icon(Icons.star, color: Colors.yellow),
                              const SizedBox(width: 8),
                              Text('Opportunities',
                                style: TextStyle(
                                  color: _isDarkMode ? Colors.white : Colors.black,),),
                            ],
                          )),
                          DataCell(Text('7',
                            style: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black,),)),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
