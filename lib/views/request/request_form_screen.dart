import 'package:flutter/material.dart';
import 'package:AyatekeApp/providers/domain/request_model.dart';
import 'package:AyatekeApp/providers/domain/service/request_api.dart';
import 'package:AyatekeApp/styles/styles.dart';
import 'package:AyatekeApp/widgets/styled_flat_button.dart';

var _scaffoldState = GlobalKey<ScaffoldState>();

class RequestFormScreen extends StatefulWidget {
  int id;
  String name;

  bool _isApiProcess = false;
  RequestFormScreen({this.id, this.name});

  @override
  _RequestFormScreenState createState() => _RequestFormScreenState();
}

class _RequestFormScreenState extends State<RequestFormScreen> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerTotalAmount = TextEditingController();
  @override
  void initState() {
    _controllerName.text = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text("Create request"),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            (widget._isApiProcess)
                ? Stack(
                    children: <Widget>[
                      Opacity(
                        opacity: 0.3,
                        child: ModalBarrier(
                          dismissible: false,
                          color: Colors.grey,
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
                  TextFormField(
                    decoration: Styles.input.copyWith(hintText: "create request"),
                    keyboardType: TextInputType.text,
                    controller: _controllerName,
                  ),
                  SizedBox(height: 15.0),
                  widget.id == null
                      ? StyledFlatButton(
                          'Submit',
                          onPressed: () {
                            // Todo Something
                            String name = _controllerName.text.trim();
                            if (name.isEmpty) {
                              showSnackBarMessage("request is required");
                            } else {
                              setState(() {
                                widget._isApiProcess = true;
                                Post post = Post(
                                    // id: null, name: name, comment: comment);
                                    id: null, name: name);
                                // print("POSTED DATA" + postToJson(post));
                                createPost(post).then((response) {
                                  widget._isApiProcess = false;
                                  // print("POSTED DATA STATUS =====>" +
                                  // response.statusCode.toString());
                                  if (response.statusCode == 201) {
                                    // print("response + $response");
                                    // Navigator.pop(context);
                                    Navigator.pop(
                                        _scaffoldState.currentState.context);
                                  } else {
                                    showSnackBarMessage(
                                        "Failed to submit data");
                                  }
                                });
                              });
                            }
                          },
                        )
                      : StyledFlatButton(
                          'Save changes',
                          onPressed: () {
                            // To do something here
                            String name = _controllerName.text.trim();
                            if (name.isEmpty) {
                              showSnackBarMessage("Name is required");
                            } else {
                              setState(() {
                                widget._isApiProcess = true;
                              });
                              Post post = Post(
                                  id: widget.id, name: name,);
                                  // id: widget.id, name: name, comment: comment);
                              // print("POSTED DATA" + postToJson(post));
                              updatePost(post).then((response) {
                                widget._isApiProcess = false;
                                setState(() {});
                                print("POSTED DATA STATUS =====>" +
                                    response.statusCode.toString());
                                if (response.statusCode == 200) {
                                  // print("response + $response");
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
