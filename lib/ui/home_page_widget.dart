import 'package:dungeonsanddragons_helper/enums/main_menu_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage() : super(key: Key("HomePage"));

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  MainMenuItem? _currentItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Dungeons and Dragons Helper",
            )),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Text("Main menu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),),
              ),
              ListTile(
                title: Text("Players"),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _currentItem = MainMenuItem.PLAYERS;
                  });
                },
              ),
              ListTile(
                title: Text("Combat"),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _currentItem = MainMenuItem.COMBAT;
                  });
                },
              ),

            ],
          ),
        ),
        body: _getBodyFromSelection());
  }

  Widget _getBodyFromSelection() {
    switch(_currentItem) {

      case MainMenuItem.PLAYERS:
        return Center(child: Text("Players"));

      case MainMenuItem.COMBAT:
        // TODO: Handle this case.
        return Center(child: Text("Combat"));

      case null:
        return Center(child: Text("Welcome!"),);


    }
  }


}
