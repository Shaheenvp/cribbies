import 'package:Potrack/views/add_itempage/add_item.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel{
  final scaffoldKey = GlobalKey<ScaffoldState>();
  onTapAddButton(context) {
   Navigator.push(
       context, MaterialPageRoute(builder: (context) => AddItemPage()));
  }

}