import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Potrack/views/detail_page/detail_page.dart';
import 'package:Potrack/views/home/home_viewmodel.dart';
import 'package:Potrack/widgets/drawer.dart';
import 'package:Potrack/widgets/item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../main.dart';
import '../../models/productModel.dart';
import '../../widgets/customFloatingButton.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      onViewModelReady: (model) {},
      onDispose: (model) {},
      builder: (context, viewModel, child) {
        return Scaffold(
            key: viewModel.scaffoldKey,
            backgroundColor: Colors.white,
            endDrawer: CustomDrawer(),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: Text(
                'HOME SCREEN',
                style:
                    TextStyle(fontSize: w * .06, fontWeight: FontWeight.w500),
              ),
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
                viewModel.onTapAddButton(context);
              },
              text: 'ADD PRODUCT ',
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child:
                          LinearProgressIndicator(), // Show a loading indicator
                    );
                  }

                  // If we reach here, we have data
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return ListView.builder(
                    padding: EdgeInsets.only(bottom: w * .25),
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      final product =
                          ProductModel.fromSnapshot(documents[index]);

                      // Replace the below return statement with your custom widget
                      return Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Card(
                            elevation: 1,
                            color: Colors.white,
                            child: SizedBox(
                                height: 120,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) => DetailPage(
                                                    tag: 'tag$index',
                                                    productModel: product,
                                                  )));
                                    },
                                    child: ItemWidget(
                                      tag: 'tag$index',
                                      ctc: product.ctc.toString(),
                                      name: product.productName,
                                      qty: product.quantity.toString(),
                                      imageUrl: product.imageUrl,
                                    ))),
                          ));
                    },
                  );
                  // return Padding(
                  //   padding: EdgeInsets.all(6.0),
                  //   child: Card(
                  //     elevation: 1,
                  //     color: Colors.white,
                  //     child: SizedBox(
                  //         height: 120,
                  //         child: InkWell(
                  //             onTap: () {
                  //               Navigator.push(
                  //                   context,
                  //                   CupertinoPageRoute(
                  //                       builder: (context) => DetailPage()));
                  //             },
                  //             child: ItemWidget())),
                  //   ),
                  // );
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
