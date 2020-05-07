import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> _httpCall() async {
    return Future.value([]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List>(
        future: _httpCall(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return ListView.builder(
              itemCount: (snapshot.data.length * (2 / 3)).floor(),
              itemBuilder: (context, index) {
                if (index % 3 == 0)
                  return Container(
                    // Your full-width item
                    width: double.maxFinite,
                    child: Text("${snapshot.data[index]}"),
                  );
                else
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text("${snapshot.data[index]}"),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text("${snapshot.data[index + 1]}"),
                        ),
                      ),
                    ],
                  );
              },
            );
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
