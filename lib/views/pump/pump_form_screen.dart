import 'package:smsApp/models/Pump.dart';
import 'package:smsApp/providers/domain/service/request_api.dart';
import 'package:flutter/material.dart';
import 'package:smsApp/styles/styles.dart';
import 'package:smsApp/widgets/styled_flat_button.dart';

var _scaffoldState = GlobalKey<ScaffoldState>();

class RequestFormScreen extends StatefulWidget {
  final int id;
  final String name;
  final int qty;
  final String token;

  RequestFormScreen({this.id, this.name, this.token,this.qty});

  @override
  _RequestFormScreenState createState() => _RequestFormScreenState();
}

class _RequestFormScreenState extends State<RequestFormScreen> {
  bool _isApiProcess = false;
  String _title;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerqty = TextEditingController();
  @override
  void initState() {
    // _controllerName.text = widget.name;
    _title = widget.id == null?"create":"Update";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            (_isApiProcess)
                ? Stack(
                    children: <Widget>[
                      Opacity(
                        opacity: 0.6,
                        child: ModalBarrier(
                          dismissible: false,
                          color: Colors.black38,
                        ),
                      ),
                      Center(child: CircularProgressIndicator())
                    ],
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "REQUEST FOR FUEL FOR : " + widget.name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
                  ),
                  SizedBox(height: 15.0),
                  SizedBox(height: 15.0),
                  TextFormField(
                    decoration: Styles.input.copyWith(labelText: "Enter Request name" ),
                    keyboardType: TextInputType.text,
                    controller: _controllerName,
                      style: Styles.h1),
                  SizedBox(height: 15.0),
                  TextFormField(
                      decoration: Styles.input.copyWith(labelText: "Enter fuel in litter" ),
                      keyboardType: TextInputType.number,
                      controller: _controllerqty,
                      style: Styles.h1),
                  SizedBox(height: 15.0),
                  widget.id == null
                      ? StyledFlatButton(
                          'Submit',
                          onPressed: () {
                            // Todo Something

                          },
                        )
                      : StyledFlatButton(
                          'Submit Request',
                          onPressed: () {
                            // To do something here
                            String name = _controllerName.text.trim();
                            String qty = _controllerqty.text.trim();
                            if (name.isEmpty || qty.isEmpty) {
                              showSnackBarMessage("Some is required");
                            } else {
                              setState(() {
                                _isApiProcess = true;
                              });
                              Pump post = Pump(
                                  id: widget.id, name: name, qty: qty);
                                  // id: widget.id, name: name, comment: comment);
                              print("POSTED DATA" + postToJson(post));
                              //print(widget.token);
                              newRequest(post, widget.token).then((response) {
                                _isApiProcess = false;
                                setState(() {});
                                print("POSTED DATA STATUS =====>" +
                                    response.statusCode.toString());
                                print(response.body);
                                if (response.statusCode == 200) {
                                  //print("response " + response.toString() );
                                  Navigator.pop(context);
                                } else {
                                  showSnackBarMessage("Failed to submit data");
                                }
                              });
                            }
                          },
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showSnackBarMessage(String message) {
    _scaffoldState.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
}
