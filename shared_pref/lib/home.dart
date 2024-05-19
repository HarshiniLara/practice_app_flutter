// import 'package:flutter/material.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<int> lucky_draw = [2, 6, 4, 9, 1, 5, 3, 8, 7];
//   int i = 0;

//   void draw() {
//     setState(() {
//       i = (i + 1) % lucky_draw.length;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 70, 120, 72),
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'Click the floating action button to display the number',
//             ),
//             Text(
//               lucky_draw[i].toString(),
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: draw,
//         tooltip: 'Get Number',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'schema.dart';

class Home extends StatefulWidget {
  final List<Record> records;
  final Function saveRecordsCallback;

  const Home(
      {Key? key, required this.records, required this.saveRecordsCallback})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Records'),
      ),
      body: ListView.builder(
        itemCount: widget.records.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.records[index].name),
            subtitle: Text(
                'Reg No: ${widget.records[index].regno}, Year: ${widget.records[index].year}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.records.removeAt(index);
                      widget.saveRecordsCallback();
                    });
                  },
                  icon: const Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditRecord(record: widget.records[index]),
                      ),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          widget.records[index] = value;
                          widget.saveRecordsCallback();
                        });
                      }
                    });
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
