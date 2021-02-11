import 'package:flutter/material.dart';
import 'package:smsApp/models/ProfileModel.dart';
import 'package:smsApp/providers/domain/service/request_api.dart';
import 'package:smsApp/models/RequestModel.dart';
import 'package:smsApp/providers/services.dart';

var _scaffoldState = GlobalKey<ScaffoldState>();

class ProfileScreen extends StatelessWidget {

  ProfileScreen({Key key, this.token, this.profile}) : super(key: key);
  final String token;
  final ProfileModel profile;
  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  _displayDialog(BuildContext context, String title) {
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
  
  @override
  Widget build(BuildContext context) {
    //print(profile);
    
    return Scaffold(
      body: 
        Column(
          children: <Widget>[
            new Expanded(
              child: FutureBuilder(
              future: requestProfile(token),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text("Loading..."),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.white, Colors.white]
                          )
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 350.0,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  child: Text(
                                    snapshot.data.name[0]??"A",
                                    style: TextStyle(
                                      fontSize: 110,
                                      color: Colors.white
                                    ),
                                  ),
                                  //child: Image.asset('assets/images/logo.jpg'),
                                  radius: 70.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  snapshot.data.name??"",
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Card(
                                  margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                                  clipBehavior: Clip.antiAlias,
                                  color: Colors.white,
                                  elevation: 5.0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 22.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(

                                            children: <Widget>[
                                              Text(
                                                "Requests",
                                                style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                snapshot.data.request.toString()??"0",
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.blueAccent,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(

                                            children: <Widget>[
                                              Text(
                                                "Total RWF",
                                                style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                snapshot.data.totalAmount.toString()??"0",
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.blueAccent,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  "Total Panding",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(snapshot.data.totalPending.toString()??"0",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: 300.00,

                        child: RaisedButton(
                          onPressed: (){
                            //print("Change Password clicked!");
                            _displayDialog(context, "Change Password");
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)
                          ),
                          elevation: 0.0,
                            padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [Colors.blue,Colors.blueAccent]
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text("Change Password",
                              style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight:FontWeight.w300),
                              ),
                            ),
                          )
                        ),
                      ),
                    ],
                  );
                }
              }),
            ),
            
          ],
        ),
      //)
    );
  }


  void showSnackBarMessage(String message) {
    _scaffoldState.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  Widget openAddQuantityDialog(BuildContext context, String title) => Container(
    height: 350,
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
        SizedBox(height: 2),
        Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
            child: TextFormField(
              controller: oldPasswordController,
              maxLines: 1,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Enter Old Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            )
        ),
        SizedBox(height: 2),
        Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
            child: TextFormField(
              controller: newPasswordController,
              maxLines: 1,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Enter New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            )
        ),
        SizedBox(height: 2),
        Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
            child: TextFormField(
              controller: confirmPasswordController,
              maxLines: 1,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            )
        ),
        SizedBox(height: 2),
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

                ProfileModel request = ProfileModel(
                  //requestId: widget.id,
                  //detailId: selectedProduct.id,
                  password: oldPasswordController.text,
                  newPassword: newPasswordController.text,
                  confirmPassword: confirmPasswordController.text,
                );
                var result = resetPassword(request, token);
                //print("Result found!");
                print(result);
                result.then((value){
                  print(value);
                  try{
                    if(value.success){
                      //showSnackBarMessage(value.message);
                      //Services.setRequestedChanged(true);
                      Navigator.of(context).pop("Password Changed");
                    } else {
                      showSnackBarMessage(value.message);
                    }
                  } catch(e){
                    print(e);
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