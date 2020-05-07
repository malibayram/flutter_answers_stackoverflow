import 'dart:async';
import 'package:answers/april25.dart';
import 'package:answers/april26.dart';
import 'package:answers/may8.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import "package:collection/collection.dart";

import 'package:flutter/material.dart';
import 'dart:convert';

//add this library to get data from the internet
import 'package:http/http.dart' as http;
import "dart:io";

// https://stackoverflow.com/questions/61419511/how-to-return-data-after-asynchronous-function-completes/61419647
Directory folderPath = Directory("/storage/people/");
Future<List> getData() async {
  List data = [];
  List<FileSystemEntity> entities = folderPath.listSync();

  for (FileSystemEntity e in entities) {
    var path = e.path;
    File infoFile = File("$path/info.json");
    String infoString = await infoFile.readAsString();
    Map info = json.decode(infoString);
    data.add(info);
  }
  return data;
}

List yourList = [];

void main() => runApp(MyApp());

extension NumberFormat on int {
  String formatMinute() {
    if (this < 10) {
      String newMin = '0' + this.toString();
      return newMin;
    }
    return this.toString();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
    );
  }
}

class ProductDetails {
  final String id;
  final String title;
  final String description;
  final String price;
  final String skuDetail;
  final String skProduct;
  ProductDetails(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      this.skProduct,
      this.skuDetail});
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _jsonString =
      '{ "count": 7, "result": [ { "iconId": 1, "id": 1, "name": "Kitchen", "timestamp": 1586951631 }, { "iconId": 2, "id": 2, "name": "android", "timestamp": 1586951646 }, { "iconId": 3, "id": 3, "name": "mobile", "timestamp": 1586951654 }, { "iconId": 4, "id": 4, "name": "bathroom", "timestamp": 1586951665 }, { "iconId": 5, "id": 5, "name": "parking", "timestamp": 1586974393 }, { "iconId": 6, "id": 6, "name": "theatre", "timestamp": 1586974429 }, { "iconId": 7, "id": 7, "name": "bedroom", "timestamp": 1586974457 } ] }';

  /* FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Firestore _fireStore = Firestore.instance; */

// https://stackoverflow.com/questions/61410097/firebase-add-value-to-array-which-already-exists/61410652
/*   Future logCount() async {
    DocumentSnapshot ds = await collection.document(id).get();
    List counts = ds.data['counts'];
    counts.add(count);

    return await _fireStore.collection
        .document(id)
        .updateData({'counts': counts});
  } */

  List itemName;
  List rate;
  List quantity;

  Future<String> _getDataFromWeb() async {
    http.Response response = await http.get("your-url.com");

/* 
// https://stackoverflow.com/questions/61442591/how-to-order-items-from-streambuilder/61442660
Firestore.instance.collection('messages').add({
  'message': _txtCtrl.text,
  'timestamp': FieldValue.serverTimestamp(),
});

Firestore.instance.collection('messages').orderBy('timestamp').snapshots();
 */
    if (response.statusCode == 200) {
      // If you are sure that your web service has json string, return it directly
      return response.body;
    } else {
      // create a fake response against any stuation that the data couldn't fetch from the web
      return '{ "count": 7, "result": []}';
    }
  }

  List<ProductDetails> _products = [];

  /* Future _future() async {
    FirebaseUser user = await _auth.currentUser();
    IdTokenResult idTokenResult = await user.getIdToken();

    Map<dynamic, List> _grouped = groupBy(_products, (p) => p.price);

    List _lastList = [];

    _grouped.values.forEach((f) => _lastList.add(f.first));

    /* GoogleSignInAccount user = await _googleSignIn.signIn();

    GoogleSignInAuthentication googleSignInAuthentication =
        await user.authentication;

    print(googleSignInAuthentication.accessToken); */

    print(idTokenResult.token);
  } */

/* Future<int> canWorkerApplyForTheJob(String workerEmail, Job j) async {
  int _minutes = 0;
  final _jobStartDate =
      '${DateTime.parse(j.jobStartDate).toString().split(' ')[0]} 00:00:00.000';
  final _jobStartTime =
      '${DateTime.parse(j.jobStartDate).toString().split(' ')[0]} ${j.jobStartTime.toString().split(' ')[1]}';
  QuerySnapshot _myDoc = await jobsCollection
      .where("jobStartDate", isEqualTo: _jobStartDate)
      .where("workers", arrayContainsAny: [workerEmail]).getDocuments();
  List<DocumentSnapshot> _myDocCount = _myDoc.documents;
  _myDocCount.forEach((key) {
    final job = key.data;
    final jobEndDate = job['jobEndDate'];
    final jobEndTime = job['jobEndTime'];
    DateTime newJobStartTime = DateTime.parse(
        '${j.jobStartDate.split(' ')[0]} ${j.jobStartTime.split(' ')[1]}');
    DateTime existingJobStartTime = DateTime.parse(
        '${jobEndDate.split(' ')[0]} ${jobEndTime.split(' ')[1]}');
    final inMinutes =
        newJobStartTime.difference(existingJobStartTime).inMinutes;
    if (inMinutes < 480) {
      _minutes += 1;
    }
  });
  return _minutes;
} */

//Create a stream controller to feed your streambuilder
  StreamController<List> _streamController = StreamController<List>();

/*   Future getQue() async {
    var response =
        await http.post(url, body: {'Tablename': your - table - name});
    return json.decode(response.body);
  }



  Future getData(File f) async {
    List<Images> list;

// String link = "https://clothest.herokuapp.com/";
    String link =
        "https://us-central1-velvety-rookery-274308.cloudfunctions.net/function-1";
    var stream = new http.ByteStream(DelegatingStream.typed(f.openRead()));
    var length = await f.length();
    var postUri = Uri.parse(link);
    var request = new http.MultipartRequest("POST", postUri);
    var multipartFileSign = new http.MultipartFile('File', stream, length,
        filename: basename(f.path));
    request.files.add(multipartFileSign);
    request.headers.addAll({"content-type": "application/json"});
    var response = await request.send();

    print(response.statusCode); //200 OK

    if (response.statusCode == 200) {
      response.stream.transform(utf8.decoder).listen((value) {
        var data = json.decode(value);
        var rest = data["Items"] as List;

        list = rest.map<Images>((json) => Images.fromJson(json)).toList();

        // Add your list to stream controller
        _streamController.add(list);

        print(list.toString());
      });
    }
    print(list.toString());
  } */

  @override
  void initState() {
    //getData(yourFile);
    super.initState();
  }

/*  */

  TextEditingController queryController;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List>(
      stream: _streamController.stream,
      builder: (context, snapshotStream) {
        return Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              if (queryController.text.length > 0)
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => queryController.clear(),
                )
            ],
            title: TextField(
              autofocus: true,
              controller: queryController,
              decoration: InputDecoration(
                hintText: 'Search...',
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          body: FutureBuilder<String>(
            future: _getDataFromWeb(),
            builder: (context, snapshot) {
              Map jsonMap = json.decode(snapshot.data);
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: jsonMap['count'],
                itemBuilder: (BuildContext c, int i) {
                  Map resultItem = jsonMap['result'][i];

                  return Card(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(30),
                          child: ButtonTheme(
                            minWidth: MediaQuery.of(context).size.width * 0.7,
                            height: 50.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0)),
                            child: RaisedButton(
                              child: Text(
                                'Play Online',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        Center(
                          child: Text("${resultItem['name']}"),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
