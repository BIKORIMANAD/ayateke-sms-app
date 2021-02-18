import 'package:smsApp/models/PumpFuelRecord.dart';
import 'package:smsApp/providers/domain/service/request_api.dart';
import 'package:flutter/material.dart';
import 'package:smsApp/styles/styles.dart';
import 'package:smsApp/widgets/styled_flat_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

var _scaffoldState = GlobalKey<ScaffoldState>();

class RecordFormScreen extends StatefulWidget {
  final int id;
  final String name;
  final int qty;
  final String token;

  RecordFormScreen({this.id, this.name, this.token,this.qty});

  @override
  _RecordFormScreenState createState() => _RecordFormScreenState();
}

class _RecordFormScreenState extends State<RecordFormScreen> {
  bool _isApiProcess = false;
  String _title;
  // TextEditingController _controllersta = TextEditingController();
  // TextEditingController _controllerqty = TextEditingController();
  TextEditingController _controllerstartm3 = TextEditingController();
  TextEditingController _controllerfinishm3 = TextEditingController();
  TextEditingController _controllerpressuregauge = TextEditingController();
  TextEditingController _controllerstartampere = TextEditingController();
  TextEditingController _controllerfinishampere = TextEditingController();
  FToast fToast;
  DateTime start_hour;
  DateTime finish_hour;
  @override
  void initState() {
    // _controllerName.text = widget.name;
    _title = widget.id == null?"create":"Update";
    super.initState();
    fToast = FToast();
    fToast.init(context);

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
                  DateTimePickerFormField(
                    inputType: InputType.time,
                    format: DateFormat("HH:mm"),
                    initialTime: TimeOfDay(hour: 5, minute: 5),
                    editable: false,
                    decoration: InputDecoration(
                        labelText: 'Start Hour',
                        hasFloatingPlaceholder: false
                    ),
                    onChanged: (dt) {
                      setState(() => start_hour = dt);
                    },
                  ),
                  SizedBox(height: 15.0),
                  DateTimePickerFormField(
                    inputType: InputType.time,
                    format: DateFormat("HH:mm"),
                    initialTime: TimeOfDay(hour: 5, minute: 5),
                    editable: false,
                    decoration: InputDecoration(
                        labelText: 'Finish Hour',
                        hasFloatingPlaceholder: false
                    ),
                    onChanged: (dt) {
                      setState(() => finish_hour = dt);
                      },
                  ),
                  TextFormField(
                      decoration: Styles.input.copyWith(labelText: "Enter Start m3" ),
                      keyboardType: TextInputType.number,
                      controller: _controllerstartm3,
                      style: Styles.h1),
                  SizedBox(height: 15.0),
                  TextFormField(
                      decoration: Styles.input.copyWith(labelText: "Enter Finish m3" ),
                      keyboardType: TextInputType.number,
                      controller: _controllerfinishm3,
                      style: Styles.h1),
                  SizedBox(height: 15.0),
                  TextFormField(
                      decoration: Styles.input.copyWith(labelText: "Enter pressure gauge" ),
                      keyboardType: TextInputType.number,
                      controller: _controllerpressuregauge,
                      style: Styles.h1),
                  SizedBox(height: 15.0),
                  TextFormField(
                      decoration: Styles.input.copyWith(labelText: "Enter Start gauge" ),
                      keyboardType: TextInputType.number,
                      controller: _controllerstartampere,
                      style: Styles.h1),
                  SizedBox(height: 15.0),
                  TextFormField(
                      decoration: Styles.input.copyWith(labelText: "Enter Finish gauge" ),
                      keyboardType: TextInputType.number,
                      controller: _controllerfinishampere,
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
                      String start_h = start_hour.toString();
                      String finish_h = finish_hour.toString();
                      String start_m3 = _controllerstartm3.text.trim();
                      String finish_m3 = _controllerfinishm3.text.trim();
                      String pressure_g = _controllerpressuregauge.text.trim();
                      String start_a = _controllerstartampere.text.trim();
                      String finish_a = _controllerfinishampere.text.trim();
                      if (start_h.isEmpty || finish_h.isEmpty ||  start_m3.isEmpty || finish_m3.isEmpty || pressure_g.isEmpty || start_a.isEmpty || finish_a.isEmpty) {
                        Widget toast = Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                25.0),
                            color: Colors.redAccent,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.close_rounded),
                              SizedBox(
                                width: 12.0,
                              ),
                              Text("All fields are required"),
                            ],
                          ),
                        );


                        fToast.showToast(
                          child: toast,
                          gravity: ToastGravity.CENTER,
                          toastDuration: Duration(seconds: 5),
                        );
                      } else {
                        setState(() {
                          _isApiProcess = true;
                        });
                        PumpFuelRecord data = PumpFuelRecord(
                            pump_id: widget.id,
                            start_hour: start_h,
                            finish_hour: finish_h,
                            start_m3: start_m3,
                            finish_m3: finish_m3,
                            pressure_gauge: pressure_g,
                            start_amp: start_a,
                            end_amp: finish_a,

                        );
                        print("POSTED DATA" + dataToJson(data));
                        //print(widget.token);
                        newReport(data, widget.token).then((response) {
                          _isApiProcess = false;
                          setState(() {});
                          // print("POSTED DATA STATUS =====>" + response.statusCode.toString());
                          // print(response.body);
                          if (response.statusCode == 200) {
                            print("response " + response.toString() );

                            Widget toast = Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    25.0),
                                color: Colors.greenAccent,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  Text(response.toString()),
                                ],
                              ),
                            );


                            fToast.showToast(
                              child: toast,
                              gravity: ToastGravity.CENTER,
                              toastDuration: Duration(seconds: 5),
                            );

                            Navigator.pop(context);
                          } else {
                            Widget toast = Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    25.0),
                                color: Colors.redAccent,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.close_rounded),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  Text(response.toString()),
                                ],
                              ),
                            );


                            fToast.showToast(
                              child: toast,
                              gravity: ToastGravity.CENTER,
                              toastDuration: Duration(seconds: 5),
                            );
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
