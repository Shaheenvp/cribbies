import 'package:Potrack/views/home/home.dart';
import 'package:Potrack/widgets/custom_elevated_button.dart';
import 'package:Potrack/widgets/custom_textfeild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PurchaseOrderViewModel extends BaseViewModel{

  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController purchaseorderctrl = TextEditingController();

  onTapPurchaseOrder(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }


  void showPopup(BuildContext context){
  showDialog(
      context: context,
      builder: (BuildContext context)
  {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Center(
        child: Text('Add Purchase Order',style: TextStyle(
          fontSize: 16,
        ),),
      ),
      content:CustomTextFormField(
          controller: purchaseorderctrl, labelText: 'PO Name'),
        actions: [
          CustomElevatedButton(
            alignment: Alignment.center,
              onPressed: (){},
              buttonStyle: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color(0xffF6D5CA),),
                  shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),
              width: 100,
              height: 36,
              text: 'CREATE')
      ],
    );
  });
}
}