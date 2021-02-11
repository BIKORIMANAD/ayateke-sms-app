
import 'package:smsApp/models/ProductModel.dart';
import 'package:smsApp/models/RequestModel.dart';
import 'package:flutter/material.dart';
import 'package:smsApp/providers/domain/service/request_api.dart';
import 'package:smsApp/providers/services.dart';

var _scaffoldState = GlobalKey<ScaffoldState>();

class AddProduct extends StatefulWidget {
  AddProduct({Key key, this.title, this.id, this.token}) : super(key: key);

  final String title, token;
  final int id;

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController searchController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  String filter;
  ProductModel selectedProduct;

  @override
  initState(){
    super.initState();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
  }
  @override
  void dispose(){
    searchController.dispose();
    super.dispose();
  }

  _displayDialog(String title) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 6,
            backgroundColor: Colors.transparent,
            child: openAddQuantityDialog(context, title),
          );
        });
  }


  List<String> productNameList = List<String>();
  String selectProductName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(8.0),
              child: new TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search Products',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            new Expanded(
                child: FutureBuilder(
                  future: getProductInStock(widget.token),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: Text("Loading..."),
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            //print(snapshot.data[index]);
                            return filter == null || filter == "" ?
                              ListTile(
                                onTap: () {
                                  //print("No open dialog");
                                  selectedProduct = snapshot.data[index];
                                  var result =  _displayDialog(snapshot.data[index].name);
                                  print(result);
                                },
                                title: Text(snapshot.data[index].name),
                                subtitle: Text(snapshot.data[index].price.toString() + " RWF"),
                                leading: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.blue,
                                  child: Text(snapshot.data[index].name[0].toUpperCase()),
                                ),
                              )
                            : '${snapshot.data[index].name}'.toLowerCase().contains(filter.toLowerCase())?
                              ListTile(
                                onTap: () {
                                  selectedProduct = snapshot.data[index];
                                  _displayDialog(snapshot.data[index].name);
                                },
                                title: Text(snapshot.data[index].name),
                                subtitle: Text(snapshot.data[index].price.toString() + " RWF"),
                                leading: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.blue,
                                  child: Text(snapshot.data[index].name[0]),
                                ),
                              )
                            :new Container()
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

  void showSnackBarMessage(String message) {
    _scaffoldState.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  Widget openAddQuantityDialog(BuildContext context, String title) => Container(
  height: 200,
  decoration: BoxDecoration(
    color:  Colors.white,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
  child: Column(
    children: <Widget>[
      SizedBox(height: 24),
      Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      SizedBox(height: 10),
      Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
          child: TextFormField(
            controller: quantityController,
            maxLines: 1,
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter Requested Quantity',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          )
      ),
      SizedBox(height: 10),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: 8),
          RaisedButton(
            color: Colors.blue,
            child: Text(
              "Save".toUpperCase(),
              style: TextStyle(
                color: Colors.white
              ),
            ),
            onPressed: () {
              //print(quantityController.text);
              //print(selectedProduct.id);
              //print('Update the user info');

              RequestModel request = RequestModel(
                requestId: widget.id,
                detailId: selectedProduct.id,
                quantity: double.parse(quantityController.text),
              );
              var result = requestItem(request, widget.token);
              //print("Result found!");
              result.then((value){
                if(value.success){
                  showSnackBarMessage(value.message);
                  Services.setRequestedChanged(true);
                  Navigator.of(context).pop("added");
                } else {
                  showSnackBarMessage(value.message);
                }
              });
              // return Navigator.of(context).pop(true);
            },
          )
        ],
      ),
    ],
  ),
);
}