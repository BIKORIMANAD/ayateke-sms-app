import 'package:smsApp/models/detail_model.dart';
import 'package:flutter/material.dart';
import 'package:smsApp/providers/domain/service/history_api.dart';

class HistoryDetailsScreen extends StatelessWidget {

  final int id;
  final String name;
  final String token;
  HistoryDetailsScreen({this.id, this.name, this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Details',
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold))),
      body: SafeArea(
        child: FutureBuilder(future: getHistoryIdBy(token,id),

          builder: (context, snapshot) {
          // print(snapshot);
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              var response = snapshot.data as List<Details>;
              // print(response);
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
                            String s = postItem.detailName;
                            return InkWell(
                              onTap: () {
                                final snackBar = SnackBar(content: Text("Tap"));

                                Scaffold.of(context).showSnackBar(snackBar);
                              },
                              child: ListTile(
                            onTap: null,
                            leading: CircleAvatar(
                              radius: 10,
                            backgroundColor: Colors.blue,
                              child: Text(postItem.detailName[0]),
                            ),
                            title: Row(

                            children: <Widget>[

                              Expanded(child: Text(postItem.detailName)),
                              Expanded(child: Text(postItem.qty.toString() +" * " + postItem.prc.toString() + " Frw  = ")),
                              Expanded(child: Text(postItem.subTotal.toString() + " Frw",style: TextStyle(color: Color(0xFF84A2AF),fontWeight: FontWeight.bold)))
                            ]
                            )
                            ),);
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

    );
  }
}
