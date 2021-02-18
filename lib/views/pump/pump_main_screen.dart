import 'package:smsApp/models/Pump.dart';
import 'package:smsApp/providers/domain/service/request_api.dart';
import 'package:smsApp/providers/services.dart';
import 'package:smsApp/views/pump/fuel_pump_request_screen.dart';
import 'package:smsApp/views/pump/fuel_pump_record_screen.dart';
import 'package:flutter/material.dart';

class RequestMainScreen extends StatefulWidget {
  final String text;
  final String token;
  RequestMainScreen({this.token,this.text});

  @override
  _RequestMainScreenState createState() => _RequestMainScreenState();
}

class _RequestMainScreenState extends State<RequestMainScreen> {
  //const _RequestMainScreenState({Key key, this.token}) : super(key: key);

  //final String token;

  openAddItemPage(BuildContext context, Pump item) async{
    Services.setRequestedChanged(false);
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ;
    }));

    if(result == "Changed" || Services.getRequestedChanged()){
      //here refresh the page
      setState(() {}); 
    } else {
      //
      print("No changes");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(

        child: FutureBuilder(
          future: getPump(this.widget.token),
          
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: CircularProgressIndicator(
                backgroundColor: Colors.redAccent,
                valueColor: AlwaysStoppedAnimation(Colors.green),
                strokeWidth: 10,
              ), );
            } else if (snapshot.connectionState == ConnectionState.done) {
              var response = snapshot.data as List<Pump>;
              // print("response + $response");
              return Column(

                children: <Widget>[
                  Expanded(
                    child: Container(

                        child: ListView.builder(
                          itemCount: response.length,
                          itemBuilder: (BuildContext context, int position) {
                            var postItem = response[position];
                            String s = postItem.name;
                            return Flexible(
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(bottom: BorderSide())),
                                margin: EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        CircleAvatar(
                                          child: Text(postItem.name.substring(0, 1)),
                                        ),
                                        Text(postItem.name,

                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        Container(
                                          margin: EdgeInsets.only(left: 5.0),
                                          child: Text(" WSS: "+ " "+postItem.line,
                                              style: TextStyle(color: Colors.black)),
                                        ),

                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(left: 3.0),
                                                child: Text(postItem.type,
                                                    style: TextStyle(color: Colors.green)),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.import_export_sharp, color: Colors.blueAccent),
                                              Container(
                                                margin: EdgeInsets.only(left: 3.0),
                                                child: Text("Maintenance",
                                                    style: TextStyle(color: Colors.black45)),
                                              )
                                              ],
                                          ),

                                          Row(
                                            children: <Widget>[
                                              TextButton.icon(
                                                label: Text('Submit',style: TextStyle(color: Colors.black45)),
                                                icon: Icon(Icons.arrow_circle_up),
                                                onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                    return RecordFormScreen(id: postItem.pump_id,name: postItem.name,
                                                      token: this.widget.token,
                                                    );
                                                  })).then((val)=> {
                                                    //getRequest(this.widget.token);
                                                    setState(() {})
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              TextButton.icon(
                                                  label: Text('Fuel',style: TextStyle(color: Colors.black45)),
                                                  icon: Icon(Icons.add_road_sharp),
                                                onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                    return RequestFormScreen(id: postItem.pump_id,name: postItem.name,
                                                      token: this.widget.token,
                                                    );
                                                  })).then((val)=> {
                                                    //getRequest(this.widget.token);
                                                    setState(() {})
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              );
              // return Center(
              //   child: Text("Success"),
              // );
            } else {
              return Center(child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return RequestFormScreen(token: this.widget.token,);
          })).then((val)=> {
            //getRequest(this.widget.token);
            //if(Services.requestedChanged){
              setState(() {})
            //}
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
