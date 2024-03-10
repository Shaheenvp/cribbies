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

String userName = '';

class Home extends StatefulWidget {
  const Home({super.key});

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
              // title: IconButton(onPressed: (){
              //   final w = MediaQuery.of(context).size.width;
              //   pdf.addPage(
              //       pw.Page(build: (pw.Context context) {
              //     return pw.ListView.builder(
              //       padding:
              //           pw.EdgeInsets.only(bottom: w * .25),
              //       itemCount: viewModel..length,
              //       itemBuilder: (context, int index) {
              //         final product =
              //             ProductModel.fromSnapshot(
              //                 documents[index]);
              //
              //         // Replace the below return statement with your custom widget
              //         return pw.Padding(
              //             padding: pw.EdgeInsets.all(6.0),
              //             child: pw.SizedBox(
              //                 height: 150,
              //                 child: pw.Stack(
              //                   children: [
              //                     pw.Positioned(
              //                       left: 8,
              //                       top: 10,
              //                       bottom: 10,
              //                       child: pw.Container(
              //                         height: 120,
              //                         width: 115,
              //                         decoration: const pw
              //                             .BoxDecoration(
              //                           borderRadius: pw
              //                                   .BorderRadius
              //                               .all(pw.Radius
              //                                   .circular(
              //                                       17)),
              //                         ),
              //                         child:
              //                             pw.Image.network(
              //                           product.imageUrl,
              //                           fit: BoxFit.cover,
              //                         ),
              //                       ),
              //                     ),
              //                     pw.Positioned(
              //                       left: 140,
              //                       top: 10,
              //                       bottom: 10,
              //                       child: pw.Column(
              //                         crossAxisAlignment: pw
              //                             .CrossAxisAlignment
              //                             .start,
              //                         children: [
              //                           pw.Text(
              //                               '${product.}',
              //                               style: pw
              //                                   .TextStyle(
              //                                       fontSize:
              //                                           15)),
              //                           pw.SizedBox(
              //                             height: 6,
              //                           ),
              //                           pw.Row(
              //                             children: [
              //                               pw.Text(
              //                                   'QTY : ${product.quantity}',
              //                                   style: pw
              //                                       .TextStyle(
              //                                     fontSize:
              //                                         12,
              //                                     // fontWeight: FontWeight.w300,
              //                                   )),
              //                               pw.SizedBox(
              //                                 width:
              //                                     w * .07,
              //                               ),
              //                               pw.Text(
              //                                   'CTC : - ${product.ctc}',
              //                                   style: pw
              //                                       .TextStyle(
              //                                     fontSize:
              //                                         12,
              //                                     // fontWeight: FontWeight.w300,
              //                                   )),
              //                             ],
              //                           ),
              //                           pw.SizedBox(
              //                             height: 6,
              //                           ),
              //                           pw.Container(
              //                             width: MediaQuery.of(
              //                                         context)
              //                                     .size
              //                                     .width -
              //                                 188,
              //                             child: pw.Text(
              //                                 'Dis : ${product.description}\n\n',
              //                                 maxLines: 3,
              //                                 style: pw
              //                                     .TextStyle(
              //                                   fontSize:
              //                                       12,
              //                                   // fontWeight: FontWeight.w300,
              //                                 )),
              //                           ),
              //                           pw.SizedBox(
              //                             height: 6,
              //                           ),
              //                           pw.Text(
              //                             'ADDED BY -: ${product.userName}',
              //                             style: pw.TextStyle(
              //                                 // fontWeight: FontWeight.w500,
              //                                 fontSize: 11),
              //                           )
              //                         ],
              //                       ),
              //                     ),
              //                     pw.SizedBox(
              //                       width: w * .05,
              //                     ),
              //                   ],
              //                 )));
              //       },
              //     );
              //   }));
              //
              // }, icon: Icon(Icons.share)),
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
                shape: CircleBorder(side: BorderSide(color: Color(0xffF6D5CA),)),
                backgroundColor: Color(0xffF6D5CA),
                child: Icon(Icons.add,color: Colors.white,),
                onPressed: () {
                viewModel.onTapAddButton(context);
              },),
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
                          CircularProgressIndicator(), // Show a loading indicator
                    );
                  }

                  // If we reach here, we have data
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;

                  return documents.isNotEmpty
                      ?
                  ListView.builder(
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
                                      height: 150,
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        DetailPage(
                                                          tag: 'tag$index',
                                                          productModel: product,
                                                        )));
                                          },
                                          child: ItemWidget(
                                            userName:
                                                product.userName.toUpperCase(),
                                            tag: 'tag$index',
                                            ctc: product.ctc.toString(),
                                            name: product.productName,
                                            qty: product.quantity.toString(),
                                            imageUrl: product.imageUrl,
                                            description: product.description.toString(),
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
