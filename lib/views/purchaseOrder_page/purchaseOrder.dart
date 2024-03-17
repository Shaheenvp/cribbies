import 'package:Potrack/views/purchaseOrder_page/purchaseOrder_viewmodel.dart';
import 'package:Potrack/widgets/customFloatingButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../main.dart';
import '../../models/productModel.dart';
import '../../widgets/drawer.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../home/home.dart';

class PurchaseOrder extends StatefulWidget {
  const PurchaseOrder({super.key});

  @override
  State<PurchaseOrder> createState() => _PurchaseOrderState();
}

class _PurchaseOrderState extends State<PurchaseOrder> {
  final pdf = pw.Document();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PurchaseOrderViewModel>.nonReactive(
      onViewModelReady: (model) {},
      onDispose: (model) {},
      builder: (context, viewModel, child) {
        return Scaffold(
            key: viewModel.scaffoldKey,
            endDrawer: CustomDrawer(),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      viewModel.scaffoldKey.currentState!.openEndDrawer();
                    },
                    icon: Icon(Icons.menu),
                  ),
                ),
              ],
            ),
            floatingActionButton: CustomFloatingButton(
                onTap: () {
                  viewModel.showPopup(context);
                },
                text: 'Add Purchase Order'),
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("purchaseOrders")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final purchaseOrders = snapshot.data!.docs;

                return purchaseOrders.isNotEmpty
                    ? GridView.builder(
                        itemCount: purchaseOrders.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          final purchaseOrderData = purchaseOrders[index];

                          // Access purchase order data using purchaseOrderData
                          final String title =
                              purchaseOrderData['text'] ?? 'Purchase Order';
                          String purchaseOrderDocId = purchaseOrderData['id'];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home(
                                              purchaseOrderDocId:
                                                  purchaseOrderData['id'],
                                            )));
                              },
                              child: Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "PURCHASE ORDER ",
                                        style: TextStyle(
                                            fontSize: w * .03,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        title.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: w * .035,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                              onPressed: () async {

                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text("Confirm Deletion"),
                                                      content: Text(
                                                        "Are you sure you want to delete this PURCHASE ORDER ?",
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text("Cancel"),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            await FirebaseFirestore.instance
                                                                .collection(
                                                                'purchaseOrders')
                                                                .doc(
                                                                purchaseOrderData['id'])
                                                                .delete();
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text(
                                                            "Delete",
                                                            style: TextStyle(color: Colors.red),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              icon: Icon(
                                                CupertinoIcons.delete_solid,
                                                color: Colors.red,
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                        "NO PURCHASE ORDER FOUND",
                        style: TextStyle(
                            fontSize: w * .04, fontWeight: FontWeight.w700),
                      ));
              },
            ));
      },
      viewModelBuilder: () {
        return PurchaseOrderViewModel();
      },
    );
  }
}
