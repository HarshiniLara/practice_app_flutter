// import 'package:flutter/material.dart';
// import 'home.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Practice App',
//       theme: ThemeData(
//         primarySwatch:
//             Colors.green, // You can change this to any color you like
//         colorScheme:
//             ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(
//           secondary: Colors.green, // Set the accent color
//         ),
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const StartPage(),
//         '/home': (context) => const MyHomePage(title: 'Practice App'),
//       },
//     );
//   }
// }

// class StartPage extends StatelessWidget {
//   const StartPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Start Page'),
//         backgroundColor: const Color.fromARGB(255, 70, 120, 72),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'Click the button to navigate to the lucky draw page',
//               style: TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/home');
//               },
//               child: const Text('Play'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'home.dart';
import 'schema.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  List<Record> records = [];

  @override
  void initState() {
    super.initState();
    loadRecords();
  }

  void saveRecords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> recordsJson =
        records.map((record) => jsonEncode(record.toMap())).toList();
    await prefs.setStringList('records', recordsJson);
  }

  void loadRecords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? recordsJson = prefs.getStringList('records');
    if (recordsJson != null) {
      records = recordsJson
          .map((record) => Record.fromMap(jsonDecode(record)))
          .toList();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(
                        records: records, saveRecordsCallback: saveRecords),
                  ),
                ).then((_) {
                  setState(() {});
                });
              },
              child: const Text('View Records'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddRecord(),
            ),
          );
          if (result != null) {
            setState(() {
              records.add(result);
            });
            saveRecords();
          }
        },
        tooltip: 'Add Record',
        child: const Icon(Icons.add),
      ),
    );
  }
}
