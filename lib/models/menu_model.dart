import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MenuModel {
  final IconData icon;
  final String name;
  final Function onPress;

  MenuModel({
    @required this.icon,
    @required this.name,
    this.onPress,
  });
}

List<MenuModel> menuData(BuildContext context) => [
      MenuModel(
        icon: FontAwesome.home,
        name: 'Home',
        onPress: () {
          Navigator.pop(context);
        },
      ),
      MenuModel(
        icon: Octicons.location,
        name: 'Manage Location',
      ),
      MenuModel(
        icon: FlutterIcons.ad_faw5s,
        name: 'Remove ads',
      ),
      MenuModel(
        icon: FlutterIcons.feedback_mdi,
        name: 'Unit Settings',
      ),
      MenuModel(
        icon: FlutterIcons.feedback_mdi,
        name: 'Feedback',
      ),
    ];
