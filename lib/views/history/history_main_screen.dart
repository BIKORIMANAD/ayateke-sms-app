import 'package:smsApp/models/history_model.dart';
import 'package:smsApp/providers/domain/service/history_api.dart';
import 'package:smsApp/views/history/history_detail_screen.dart';
import 'package:flutter/material.dart';

class HistoryMainScreen extends StatelessWidget {
  const HistoryMainScreen({Key key, this.token}) : super(key: key);
  final String token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getRequest(token),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              var response = snapshot.data as List<Post>;
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(),
                        child: ListView.builder(
                          itemCount: response.length,
                          itemBuilder: (BuildContext context, int position) {
                            var postItem = response[position];
                            String s = postItem.name;
                            return GestureDetector(
                              onTap: () => {
                                //
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 2.0,
                                    left: 1.0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        CircleAvatar(
                                            radius: 20.0,
                                            backgroundColor:
                                                Colors.brown.shade800,
                                            child:
                                                Text('${s[0].toUpperCase()}')),
                                        SizedBox(width: 5.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              postItem.name,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 5.0),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.55,
                                              child: Text(
                                                postItem.totalAmount.toString() + "RWF",
                                                style: TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 50.0,
                                          height: 15.0,
                                          child: FlatButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return HistoryDetailsScreen(
                                                        token: token,
                                                        id: postItem.id
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: Icon(Icons.keyboard_arrow_right,
                                                color: Colors.blue),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
