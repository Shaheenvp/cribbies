import 'package:Potrack/views/purchaseOrder_page/purchaseOrder_viewmodel.dart';
import 'package:Potrack/widgets/customFloatingButton.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../models/productModel.dart';
import '../../widgets/drawer.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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
          body: SizedBox(
            child: GridView.builder(
              itemCount: 6,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    viewModel.onTapPurchaseOrder(context);
                  },
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Purchase Order 1',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: () {
                                  },
                                  icon: Icon(Icons.share)),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.delete))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () {
        return PurchaseOrderViewModel();
      },
    );
  }
}
