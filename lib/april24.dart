import 'package:flutter/material.dart';
import 'dart:convert';

class April24 extends StatefulWidget {
  @override
  _April24State createState() => _April24State();
}

//https://stackoverflow.com/questions/61398262/the-method-where-was-called-on-null-when-using-streambuilder-with-firestore/61398399

class _April24State extends State<April24> {
  Map<List, String> _mapList = {
    [1, 'A']: "1A",
    [2, 'B']: "2A"
  };

//https://stackoverflow.com/questions/61419663/how-can-we-pass-list-through-named-route-in-flutter/61420418
  List _yourListFromArguments;

  @override
  void didChangeDependencies() {
    _yourListFromArguments = ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // https://stackoverflow.com/questions/61399355/how-to-iterate-a-maplist-string/61399392
    _mapList.forEach((key, value) {
      print(key);
      print(value);
    });

    _mapList.map((key, value) {
      print(key);
      print(value);
      return MapEntry("transformed_key", "transformed_value");
    });

    for (var key in _mapList.keys) {
      print(key);
      print(_mapList[key]);
    }

// https://stackoverflow.com/questions/61399973/flutter-edit-json-data-in-sharedpreferences/61400044
/* String jsonString = await storage.getString("user");
var yourJson = json.decode(jsonString);
/// Edit your json
/// and convert it to String again
String editedJsonString = json.encode(yourJson); 
/// finally save it to shared with same key
storage.setString("user", editedJsonString); */

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        /* child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Consumer<AppState>(
          builder: (context, appState, _) => StreamBuilder<List<Dentist>>(
            stream: database.dentistsStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return Column(
                  children: <Widget>[
                    for (final dentist in snapshot.data.where((e) =>
                        e.categoryIds.contains(appState.selectedCategoryId)))
                      GestureDetector(
                        onTap: () {},
                        child: DentistItem(
                          dentist: dentist,
                        ),
                      ),
                  ],
                );
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ), */
        );
  }
}
