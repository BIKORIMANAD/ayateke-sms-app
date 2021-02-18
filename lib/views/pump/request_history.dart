import 'package:flutter/material.dart';
import 'package:smsApp/providers/domain/service/request_api.dart';

var _scaffoldState = GlobalKey<ScaffoldState>();

class RequestHistory extends StatefulWidget {
  final String token;
  RequestHistory({Key key,this.token}) : super(key: key);

  @override
  _RequestHistoryState createState() => _RequestHistoryState();
}

class _RequestHistoryState extends State<RequestHistory> {
  TextEditingController searchController = new TextEditingController();
  String filter;
  BuildContext myctx;

  @override
  initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
    myctx = context;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,

      body: Column(

          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(8.0),
              child: new TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'search in request',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),

            new Expanded(
              child: FutureBuilder(
                  future: getPumpRequest(this.widget.token),

                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    var data = snapshot.data;
                    print(data);
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          // child: CircularProgressIndicator(backgroundColor: Colors.blueAccent,),
                          child: Text("Syncing data..."),
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {

                            print(snapshot.data[index]);

                            return filter == null || filter == "" ?
                            ListTile(
                              title: Text(snapshot.data[index].name,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              subtitle: Text(snapshot.data[index].price
                                  .toString() + " RWF",style: TextStyle(fontSize: 20)),
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.blue,
                                child: Text(snapshot.data[index].name[0]),
                              ),
                            )
                                : '${snapshot.data[index].name}'
                                .toLowerCase()
                                .contains(filter.toLowerCase()) ?
                            ListTile(
                              onTap: () {
                                // _displayDialog(snapshot.data[index].name);
                              },
                              title: Text(snapshot.data[index].name,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              // subtitle: Text(
                              //     snapshot.data[index].price.toString() +
                              //         " RWF",style: TextStyle(fontSize: 20)),
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.blue,
                                child: Text(snapshot.data[index].name[0]),
                              ),
                            )
                                : new Container()
                            ;
                          }
                      );
                    }
                  }
              ),
            ),
          ]
      ),
    );
  }
}
