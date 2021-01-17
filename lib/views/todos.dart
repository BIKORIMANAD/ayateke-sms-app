import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AyatekeApp/providers/auth.dart';
import 'package:AyatekeApp/views/request/request_main_screen.dart';
class Todos extends StatefulWidget {
  @override
  TodosState createState() => TodosState();
}

class TodosState extends State<Todos> {
  String token, username;
  void displayProfileMenu(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Log out'),
                  onTap: () {
                    Provider.of<AuthProvider>(context).logOut();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    AuthProvider.getToken().then((value){
      // print("Try to token: " + value);
      setState(() {
        token = value;
      });
    });
    AuthProvider.getName().then((value){
      setState(() {
        username = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text( username ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.account_circle),
              tooltip: 'Profile',
              onPressed: () {
                displayProfileMenu(context);
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              // Tab(icon: Icon(Icons.camera_alt)),
              // Tab(icon: Icon(Icons.business), text: 'Funds'),
              // HomeScreen();
              Tab(icon: Icon(Icons.payment), text: 'Request'),
              Tab(icon: Icon(Icons.payment ), text: 'Daily'),
              Tab(icon: Icon(Icons.list), text: 'Report'),
              Tab(icon: Icon(Icons.account_box), text: 'Profile'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RequestMainScreen(token: token),
            Icon(Icons.directions_car),
            Icon(Icons.directions_car),
            Icon(Icons.directions_car),

          ],
        ),
      ),
    );
  }
}
