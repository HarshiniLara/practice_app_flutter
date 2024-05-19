// import 'package:flutter/material.dart';

// class Record {
//   final String name;
//   final String regno;
//   final int year;

//   Record({required this.name, required this.regno, required this.year});

//   // Convert a Record object into a Map object
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'regno': regno,
//       'year': year,
//     };
//   }

//   // Extract a Record object from a Map object
//   factory Record.fromMap(Map<String, dynamic> map) {
//     return Record(
//       name: map['name'],
//       regno: map['regno'],
//       year: map['year'],
//     );
//   }
// }

// class AddRecord extends StatefulWidget {
//   const AddRecord({Key? key}) : super(key: key);

//   @override
//   _AddRecordState createState() => _AddRecordState();
// }

// class _AddRecordState extends State<AddRecord> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _regNoController = TextEditingController();
//   final TextEditingController _yearController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Record'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: _regNoController,
//               decoration: const InputDecoration(labelText: 'Reg No'),
//             ),
//             TextField(
//               controller: _yearController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'Year'),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(
//                   context,
//                   Record(
//                     name: _nameController.text,
//                     regno: _regNoController.text,
//                     year: int.parse(_yearController.text),
//                   ),
//                 );
//               },
//               child: const Text('Add Record'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class EditRecord extends StatefulWidget {
//   final Record record;

//   const EditRecord({Key? key, required this.record}) : super(key: key);

//   @override
//   _EditRecordState createState() => _EditRecordState();
// }

// class _EditRecordState extends State<EditRecord> {
//   late TextEditingController _nameController;
//   late TextEditingController _regNoController;
//   late TextEditingController _yearController;

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.record.name);
//     _regNoController = TextEditingController(text: widget.record.regno);
//     _yearController =
//         TextEditingController(text: widget.record.year.toString());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Record'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: _regNoController,
//               decoration: const InputDecoration(labelText: 'Reg No'),
//             ),
//             TextField(
//               controller: _yearController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'Year'),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(
//                   context,
//                   Record(
//                     name: _nameController.text,
//                     regno: _regNoController.text,
//                     year: int.parse(_yearController.text),
//                   ),
//                 );
//               },
//               child: const Text('Update Record'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _regNoController.dispose();
//     _yearController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'dart:convert';

class Record {
  final String name;
  final String regno;
  final int year;

  Record({required this.name, required this.regno, required this.year});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'regno': regno,
      'year': year,
    };
  }

  factory Record.fromMap(Map<String, dynamic> map) {
    return Record(
      name: map['name'],
      regno: map['regno'],
      year: map['year'],
    );
  }

  static String encode(List<Record> records) => json.encode(
        records.map<Map<String, dynamic>>((record) => record.toMap()).toList(),
      );

  static List<Record> decode(String records) =>
      (json.decode(records) as List<dynamic>)
          .map<Record>((item) => Record.fromMap(item))
          .toList();
}

class AddRecord extends StatefulWidget {
  const AddRecord({Key? key}) : super(key: key);

  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _regNoController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Record'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _regNoController,
              decoration: const InputDecoration(labelText: 'Reg No'),
            ),
            TextField(
              controller: _yearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Year'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  Record(
                    name: _nameController.text,
                    regno: _regNoController.text,
                    year: int.parse(_yearController.text),
                  ),
                );
              },
              child: const Text('Add Record'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditRecord extends StatefulWidget {
  final Record record;

  const EditRecord({Key? key, required this.record}) : super(key: key);

  @override
  _EditRecordState createState() => _EditRecordState();
}

class _EditRecordState extends State<EditRecord> {
  late TextEditingController _nameController;
  late TextEditingController _regNoController;
  late TextEditingController _yearController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.record.name);
    _regNoController = TextEditingController(text: widget.record.regno);
    _yearController =
        TextEditingController(text: widget.record.year.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Record'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _regNoController,
              decoration: const InputDecoration(labelText: 'Reg No'),
            ),
            TextField(
              controller: _yearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Year'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  Record(
                    name: _nameController.text,
                    regno: _regNoController.text,
                    year: int.parse(_yearController.text),
                  ),
                );
              },
              child: const Text('Update Record'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _regNoController.dispose();
    _yearController.dispose();
    super.dispose();
  }
}
