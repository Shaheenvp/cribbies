import 'package:Potrack/views/home/printing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Potrack/views/detail_page/detail_page.dart';
import 'package:Potrack/views/home/home_viewmodel.dart';
import 'package:Potrack/widgets/drawer.dart';
import 'package:Potrack/widgets/item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../../main.dart';
import '../../models/productModel.dart';
import '../../widgets/customFloatingButton.dart';
import '../purchaseOrder_page/purchaseOrder.dart';

String userName = '';

class Home extends StatefulWidget {
  final String purchaseOrderDocId;
  const Home({super.key, required this.purchaseOrderDocId});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUsernameFromFirestore();
  }

  Future<String?> getUsernameFromFirestore() async {
    // Retrieve userId from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    // Query Firestore for the user document
    DocumentSnapshot userSnapshot =
    await FirebaseFirestore.instance.collection('users').doc(userId).get();

    // Extract username from the user document
    userName = userSnapshot['userName'];
    print(userName);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        onViewModelReady: (model) {},
        onDispose: (model) {},
        builder: (context, viewModel, child) {
          return Scaffold(
              key: viewModel.scaffoldKey,
              backgroundColor: Colors.white,
              endDrawer: CustomDrawer(),
              appBar: AppBar(
                automaticallyImplyLeading: true,
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


              floatingActionButton: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  shape: CircleBorder(
                      side: BorderSide(
                        color: Color(0xffF6D5CA),
                      )),
                  backgroundColor: Color(0xffF6D5CA),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    viewModel.onTapAddButton(context, widget.purchaseOrderDocId);
                  },
                ),
              ),





              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('purchaseOrders')
                      .doc(widget.purchaseOrderDocId)
                      .collection('products')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child:
                        CircularProgressIndicator(), // Show a loading indicator
                      );
                    }

                    // If we reach here, we have data
                    final List<DocumentSnapshot> documents = snapshot.data!.docs;
                    return documents.isNotEmpty
                        ? ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: w * .25),
                      itemCount: documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = ProductModel.fromSnapshot(documents[index]);
                        // If snapshot has data, retrieve the products
                        List<ProductModel> productList =
                        ProductModel.productListFromSnapshot(
                            snapshot.data!);
                        // Replace the below return statement with your custom widget
                        GestureDetector(
                          child: IconButton(
                            icon: Icon(CupertinoIcons.share),
                            onPressed: () async {
                              // Show a loading indicator
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );

                              // Generate and share the PDF
                              await generatePDF(productList);

                              // Close the loading indicator
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                             Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Card(
                              elevation: 1,
                              color: Colors.white,
                              child: SizedBox(
                                  height: w * .45,
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    DetailPage(
                                                      tag: 'tag$index',
                                                      productModel:
                                                      product,
                                                      purchaseOrderDocId:
                                                      widget
                                                          .purchaseOrderDocId,
                                                    )));
                                      },
                                      child: ItemWidget(
                                        userName: product.userName
                                            .toUpperCase(),
                                        tag: 'tag$index',
                                        ctc: product.ctc.toString(),
                                        name: product.productName,
                                        qty:
                                        product.quantity.toString(),
                                        imageUrl: product.imageUrl,
                                        description: product.description
                                            .toString(),
                                      ))),
                            ));
                      },
                    )
                        : Center(
                        child: Text(
                          'No Products Added !',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: w * .04),
                        ));
                  },
                ),
              ));
        },
        viewModelBuilder: () {
          return HomeViewModel();
          },
        );
    }
}
