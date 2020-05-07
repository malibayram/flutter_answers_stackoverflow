import 'package:flutter/material.dart';

import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

class April26 extends StatefulWidget {
  @override
  _April26State createState() => _April26State();
}

class _April26State extends State<April26> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(color: Colors.amber),
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Container(
          height: 50.0,
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 25.0,
            right: 25.0,
          ),
          decoration: BoxDecoration(
            color: Color(0xFFffffff),
          ),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new SizedBox(
                child: RaisedButton(
                  color: Color(0xFF2e616f),
                  textColor: Colors.white,
                  onPressed: () {},
                  child: Text('Apply', style: new TextStyle(fontSize: 14.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp26April extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Server',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: April26(),
    );
  }
}

class MyHomePage26 extends StatefulWidget {
  MyHomePage26({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePage26State createState() => _MyHomePage26State();
}

class _MyHomePage26State extends State<MyHomePage26> {
  StreamController<List> _streamController = StreamController<List>();
  Timer _timer;

  Future getData() async {
    var url = 'https://milk-white-reveille.000webhostapp.com/get.php';
    http.Response response = await http.get(url);
    List data = json.decode(response.body);

    //Add your data to stream
    _streamController.add(data);
  }

  @override
  void initState() {
    getData();

    //Check the server every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 5), (timer) => getData());

    super.initState();
  }

  @override
  void dispose() {
    //cancel the timer
    if (_timer.isActive) _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("widget.title"),
        centerTitle: true,
      ),
      body: StreamBuilder<List>(
        stream: _streamController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData)
            return ListView(
              children: [
                for (Map document in snapshot.data)
                  ListTile(
                    title: Text(document['title']),
                    subtitle: Text(document['type']),
                  ),
                for (Map document in snapshot.data)
                  ListTile(
                    title: Text(document['title']),
                    subtitle: Text(document['type']),
                  ),
              ],
            );
          return Text('Loading...');
        },
      ),
    );
  }
}
