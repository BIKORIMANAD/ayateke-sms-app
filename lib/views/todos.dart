import 'package:smsApp/providers/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smsApp/providers/auth.dart';
import 'package:smsApp/views/pump/pump_main_screen.dart';
import 'package:smsApp/views/history/history_main_screen.dart';
import 'package:smsApp/views/tarif/tarif.dart';
import 'package:smsApp/views/profile/ProfileScreen.dart';

class Todos extends StatefulWidget {
  @override
  TodosState createState() => TodosState();
}

class TodosState extends State<Todos> {
  String token, username;
  String greeting;
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
        }
    );
  }

  @override
  void initState() { 
    super.initState();
    AuthProvider.getToken().then((value){
      // print("Try to have token: " + value);
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
          title: Text(Services.greeting()+", "+ username,
              style: TextStyle(fontSize: 16,color: Colors.white.withOpacity(0.6))
          ),
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
              Tab(icon: Icon(Icons.shopping_cart), text: 'My Pump'),
              Tab(icon: Icon(Icons.payment ), text: 'History'),
              Tab(icon: Icon(Icons.list), text: 'Tarif'),
              Tab(icon: Icon(Icons.account_box), text: 'Profile'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RequestMainScreen(token: token),
            HistoryMainScreen(token: token),
            Tarif(token: token),
            ProfileScreen(token: token),
            
          ],
        ),
      ),
    );
  }
}
