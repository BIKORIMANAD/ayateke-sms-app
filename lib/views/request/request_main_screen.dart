import 'package:flutter/material.dart';
import 'package:AyatekeApp/providers/domain/request_model.dart';
import 'package:AyatekeApp/providers/domain/service/request_api.dart';
import 'package:AyatekeApp/views/request/request_form_screen.dart';



class RequestMainScreen extends StatelessWidget {
  const RequestMainScreen({Key key, this.token}) : super(key: key);

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
              // print("response + $response");
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.only(
                            // topLeft: Radius.circular(30.0),
                            // topRight: Radius.circular(30.0),
                            ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            // topLeft: Radius.circular(30.0),
                            // topRight: Radius.circular(30.0),
                            ),
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
                                    left: 2.0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      // topRight: Radius.circular(50.0),
                                      // bottomRight: Radius.circular(50.0),
                                      ),
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

                                            // print();
                                            child:
                                                Text('${s[0].toUpperCase()}')),
                                        SizedBox(width: 5.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              postItem.name + " --  " +postItem.status,
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
                                                postItem.datec.toString(),
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
                                            // shape: RoundedRectangleBorder(
                                            //     borderRadius:
                                            //         new BorderRadius.circular(20.0),
                                            //     side: BorderSide(
                                            //       color: Colors.blue,
                                            //     )),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return RequestFormScreen(
                                                        id: postItem.id,
                                                        name: postItem.name
                                                            );
                                                  },
                                                ),
                                              );
                                            },
                                            child: Icon(Icons.edit,
                                                color: Colors.blue),
                                          ),
                                        ),
                                        Container(
                                          width: 30.0,
                                          height: 15.0,
                                          child: FlatButton(
                                            // shape: RoundedRectangleBorder(
                                            //     borderRadius:
                                            //         new BorderRadius.circular(20.0),
                                            //     side: BorderSide(
                                            //       color: Colors.red,
                                            //     )),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text('Delete!'),
                                                    content: Text(
                                                        "Are you sure , you want to delete ${postItem.name}?"),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        onPressed: () {
                                                          deletePost(
                                                                  postItem.id)
                                                              .then((response) {
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        },
                                                        child: Text("Yes"),
                                                      ),
                                                      FlatButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("No"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Icon(Icons.delete_forever,
                                                color: Colors.red),
                                          ),
                                        ),

                                        // : SizedBox.shrink(),
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
              // return Center(
              //   child: Text("Success"),
              // );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return RequestFormScreen();
          }));
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
