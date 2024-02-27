import 'package:cribbies/models/productModel.dart';
import 'package:cribbies/views/detail_page/detail_page_viewmodel.dart';
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     IconButton(
              //         onPressed: () {},
              //         icon: Icon(
              //           Icons.edit,
              //           color: Colors.green,
              //         )),
              //     SizedBox(
              //       width: 40,
              //     ),
              //     IconButton(
              //         onPressed: () {
              //
              //         },
              //         icon: Icon(
              //           Icons.delete,
              //           color: Colors.red,
              //         ))
              //   ],
              // )
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
