import 'package:Potrack/models/productModel.dart';
import 'package:Potrack/utils/navigation_service.dart';
import 'package:Potrack/views/detail_page/detail_page_viewmodel.dart';
import 'package:Potrack/views/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DetailPage extends StatelessWidget {
  final String tag;
  final ProductModel productModel;
  const DetailPage({super.key, required this.productModel, required this.tag});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return ViewModelBuilder<DetailPageViewModel>.nonReactive(
      onViewModelReady: (model) {},
      onDispose: (model) {},
      builder: (context, viewModel, child) {
        return Scaffold(
          body: ListView(
            children: [
              Stack(children: [
                Hero(
                  tag: tag,
                  child: Container(
                    height: h * 0.4,
                    width: w,
                    color: Colors.white38,
                    child: InteractiveViewer(
                      child: Image.network(
                        productModel.imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          CupertinoIcons.back,
                          color: Colors.white,
                        ),
                      )),
                )
              ]),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  productModel.productName,
                  style: TextStyle(
                      fontSize: w * 0.047, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Quantity : ${productModel.quantity}',
                  style: TextStyle(
                      fontSize: w * 0.04, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'CTC : ${productModel.ctc.toString()}',
                  style: TextStyle(
                      fontSize: w * 0.04, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Description : ${productModel.description}',
                  style: TextStyle(
                      fontSize: w * 0.04, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(
                  //       Icons.edit,
                  //       color: Colors.green,
                  //     )),
                  // SizedBox(
                  //   width: 40,
                  // ),
                  IconButton(
                    onPressed: () async {
                      // Show an alert dialog to confirm deletion
                      bool confirmDelete = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirm Deletion"),
                            content: Text(
                              "Are you sure you want to delete this \n${productModel.productName}?",
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(
                                      false); // User does not want to delete
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                  Navigator.pop(context);
                                },
                                child: Text("Delete"),
                              ),
                            ],
                          );
                        },
                      );

                      // If user confirms deletion, proceed with deleting the document
                      if (confirmDelete ?? false) {
                        DocumentReference docRef = FirebaseFirestore.instance
                            .collection('products')
                            .doc(productModel.id);
                        await docRef.delete();
                      }
                    },
                    icon: Icon(
                      CupertinoIcons.delete_solid,
                      color: Colors.red,
                      size: w * .15,
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
      viewModelBuilder: () {
        return DetailPageViewModel();
      },
    );
  }
}
