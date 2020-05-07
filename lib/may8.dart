import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'main.dart';

//https://stackoverflow.com/questions/61668052/how-to-i-take-the-return-statement-of-a-future-and-put-it-in-a-widget/61668242#61668242
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text("My School Calendar"),
        ),
        body: Container(
          child: Align(
              alignment: Alignment(0, -0.9),
              child: Column(
                children: <Widget>[
                  FlatButton.icon(
                    color: Colors.teal,
                    icon: Icon(Icons.plus_one), //`Icon` to display
                    label: Text('Create new entry'), //`Text` to display
                    onPressed: () {
                      Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => new SecondScreen()),
                      );
                    },
                  ),
                  FlatButton.icon(
                    color: Colors.green,
                    icon: Icon(Icons.remove_red_eye), //`Icon` to display
                    label: Text('View assignments'), //`Text` to display
                    onPressed: () {
                      Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => new ThirdScreen()),
                      );
                    },
                  )
                ],
              )),
        ));
  }
}

class SecondScreen extends StatefulWidget {
  SecondScreen({Key key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> _selectDate(BuildContext ctxt) async {
    final DateTime picked = await showDatePicker(
      context: ctxt,
      initialDate: _date,
      firstDate: new DateTime.now().subtract(Duration(days: 1)),
      lastDate: new DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != _date) {
      print('Date selected: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }

  Future<Null> _selectTime(BuildContext ctxt) async {
    final TimeOfDay picked =
        await showTimePicker(context: ctxt, initialTime: _time);
    if (picked != null && picked != _time) {
      print('Time selected: ${_time.toString()}');
      setState(() {
        _time = picked;
      });
    }
  }

  Future<File> get _localDate async {
    final path = await _localDatePath;
    return File('$path/date.txt');
  }

  Future<String> get _localDatePath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localTime async {
    final path = await _localTimePath;
    return File('$path/time.txt');
  }

  Future<String> get _localTimePath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localNames async {
    final path = await _localNamesPath;
    return File('$path/names.txt');
  }

  Future<String> get _localNamesPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<int> readName() async {
    try {
      final file = await _localNames;

      // Read the file
      String contents = await file.readAsString();
      print('Name read from file: ' + contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> writeName() async {
    final file = await _localNames;

    // Write the file.
    String nameToWrite = myController.text;
    return file.writeAsString(nameToWrite);
  }

  Future<int> readDate() async {
    try {
      final file = await _localDate;

      // Read the file
      String contents = await file.readAsString();
      print('Date read from file: ' + contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> writeDate() async {
    final file = await _localDate;

    // Write the file.
    String dateToWrite = '${_date.month}/${_date.day}/${_date.year}';
    return file.writeAsString(dateToWrite);
  }

  Future<int> readTime() async {
    try {
      final file = await _localTime;

      // Read the file
      String contents = await file.readAsString();
      print('Time read from file: ' + contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> writeTime() async {
    final file = await _localTime;

    // Write the file.
    String timeToWrite = '${_time.hour}:${_time.minute.formatMinute()}';
    return file.writeAsString(timeToWrite);
  }

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
        home: Scaffold(
            appBar: new AppBar(
              title: new Text("Enter assignment details"),
            ),
            body: Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Align(
                alignment: Alignment(0, -0.9),
                child: Column(children: <Widget>[
                  TextField(
                    controller: myController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        hintText: 'Enter assignment name'),
                  ),
                  FlatButton.icon(
                      color: Colors.redAccent,
                      icon: Icon(Icons.calendar_today), //`Icon` to display
                      label: Text('Select date'), //`Text` to display
                      onPressed: () {
                        _selectDate(ctxt);
                      }),
                  Text(
                      'Date selected: ${_date.month}/${_date.day}/${_date.year}'),
                  FlatButton.icon(
                      color: Colors.grey,
                      icon: Icon(Icons.access_time), //`Icon` to display
                      label: Text('Select time'), //`Text` to display
                      onPressed: () {
                        _selectTime(ctxt);
                      }),
                  Text(
                      'Time selected: ${_time.hour}:${_time.minute.formatMinute()}'),
                  FlatButton.icon(
                      color: Colors.lightBlueAccent,
                      icon: Icon(Icons.check_box), //`Icon` to display
                      label: Text('Submit'), //`Text` to display
                      onPressed: () {
                        writeDate();
                        readDate();
                        writeTime();
                        readTime();
                        writeName();
                        readName();
                      }),
                ]),
              ),
            )));
  }
}

class ThirdScreen extends StatefulWidget {
  ThirdScreen({Key key}) : super(key: key);

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

Future<File> get _localDate async {
  final path = await _localDatePath;
  return File('$path/date.txt');
}

Future<String> get _localDatePath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localTime async {
  final path = await _localTimePath;
  return File('$path/time.txt');
}

Future<String> get _localTimePath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localNames async {
  final path = await _localNamesPath;
  return File('$path/names.txt');
}

Future<String> get _localNamesPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

class _ThirdScreenState extends State<ThirdScreen> {
  Future<String> readTime() async {
    try {
      final file = await _localTime;

      // Read the file
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return 'Error';
    }
  }

  Future<String> readDate() async {
    try {
      final file = await _localDate;

      // Read the file
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return 'Error';
    }
  }

  Future<Widget> readName() async {
    try {
      final file = await _localNames;

      // Read the file
      String contents = await file.readAsString();
      return Text('Assignment' + contents);
    } catch (e) {
      // If encountering an error, return 0
      return Text('Error');
    }
  }

  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          title: new Text("My assignments"),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: Align(
            alignment: Alignment(0, -0.9),
            child: Column(
              children: <Widget>[
                // Need Text Here
                FutureBuilder<Widget>(
                    future: readName(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) return snapshot.data;
                      return Center(child: CircularProgressIndicator());
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
