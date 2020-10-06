import 'package:flutter/material.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/models/menu_model.dart';

class MenuBar extends StatefulWidget {
  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.yellow[900],
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.yellow[900],
              leading: Icon(Icons.settings),
              centerTitle: false,
              title: Text(
                'Settings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: menuData(context).length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: menuData(context)[i].onPress,
                        child: ListTile(
                          leading: Icon(
                            menuData(context)[i].icon,
                            color: Colors.white,
                          ),
                          title: Text(
                            menuData(context)[i].name,
                            style: kTextStyle,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: 350,
                        child: Divider(
                          height: 20,
                          thickness: 1,
                          color: Color(0x90000000),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
