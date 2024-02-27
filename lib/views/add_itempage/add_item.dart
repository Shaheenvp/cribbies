import 'dart:io';

import 'package:cribbies/utils/custom_snackBar.dart';
import 'package:cribbies/utils/navigation_service.dart';
import 'package:cribbies/views/home/home.dart';
import 'package:cribbies/widgets/customFloatingButton.dart';
import 'package:cribbies/widgets/custom_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../models/productModel.dart';
import '../../widgets/custom_elevated_button.dart';
import 'add_item_viewmodel.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return ViewModelBuilder<AddItemViewModel>.reactive(
      onViewModelReady: (model) {},
      onDispose: (model) {},
      createNewViewModelOnInsert: true,
      builder: (context, viewModel, child) {
        return _isLoading
            ? Scaffold(body: Center(child: LinearProgressIndicator()))
            : WillPopScope(
                onWillPop: () {
                  return Future(() => false);
                },
                child: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_outlined)),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * .06),
                          child: Text(
                            'Product Photos',
                            style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            height: h * 0.2,
                            width: w * 0.9,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            padding: EdgeInsets.all(15),
                            child: viewModel.pickedImage != null
                                ? GestureDetector(
                                    onTap: () async {
                                      viewModel.takePicture();
                                    },
                                    child: Image.file(
                                      File(viewModel.pickedImage!.path),
                                      fit: BoxFit.fill,
                                      width: w * .5,
                                      height: 50,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          viewModel.pickImage();
                                        },
                                        icon: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                                height: w * 0.09,
                                                'assets/img_1.png'),
                                            Text(
                                              'Upload Files',
                                              style: TextStyle(
                                                fontSize: w * 0.025,
                                                color: Colors.black54,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          viewModel.takePicture();
                                        },
                                        icon: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                                height: w * 0.09,
                                                'assets/img_2.png'),
                                            Text(
                                              'Open Camera',
                                              style: TextStyle(
                                                fontSize: w * 0.025,
                                                color: Colors.black54,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * .06),
                          child: Text(
                            'Name Of Product',
                            style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: CustomTextFormField(
                            controller: viewModel.productNameController,
                            labelText: 'Name',
                            labelTextStyle: const TextStyle(
                                fontSize: 10, color: Colors.black54),
                            height: h * 0.05,
                            width: w * 0.9,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * .06),
                          child: Text(
                            'Quantity',
                            style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: CustomTextFormField(
                            keyboardType: TextInputType.number,
                            controller: viewModel.qtyController,
                            labelText: 'Quantity',
                            labelTextStyle: const TextStyle(
                                fontSize: 10, color: Colors.black54),
                            height: h * 0.05,
                            width: w * 0.9,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * .06),
                          child: Text(
                            'CTC',
                            style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: CustomTextFormField(
                            keyboardType: TextInputType.number,
                            controller: viewModel.ctcController,
                            labelText: 'CTC',
                            labelTextStyle: const TextStyle(
                                fontSize: 10, color: Colors.black54),
                            height: h * 0.05,
                            width: w * 0.9,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * .06),
                          child: Text(
                            'Description',
                            style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: CustomTextFormField(
                            controller: viewModel.descriptionController,
                            labelText: 'Share some details...',
                            maxLines: 5,
                            labelTextStyle: const TextStyle(
                                fontSize: 10, color: Colors.black54),
                            height: h * 0.15,
                            width: w * 0.9,
                          ),
                        ),
                        SizedBox(
                          height: h * .15,
                        ),
                      ],
                    ),
                  ),
                  floatingActionButton: CustomFloatingButton(
                    text: 'SUBMIT',
                    onTap: () async {
                      setState(() {
                        _isLoading =
                            true; // Set isLoading to true when starting upload
                      });
                      try {
                        if (viewModel.pickedImage != null) {
                          String? imageUrl =
                              await viewModel.uploadImageToFirebase();

                          ProductModel product = ProductModel(
                            productName: viewModel.productNameController.text,
                            quantity: int.parse(viewModel.qtyController.text),
                            ctc: double.parse(viewModel.ctcController.text),
                            description: viewModel.descriptionController.text,
                            imageUrl: imageUrl.toString(),
                          );
                          await viewModel.addProductToFirestore(product);

                          showSnackBar(
                              content: 'Product Added Successfully',
                              context: context,
                              color: Colors.green);
                          NavigationService.navigatePushReplacement(
                              screen: const Home(), context: context);
                        } else {
                          if (viewModel.pickedImage == null) {
                            showSnackBar(
                                content: 'Please Upload Image',
                                context: context,
                                color: Colors.red);
                          } else {
                            showSnackBar(
                                content: 'Error Adding Product',
                                context: context,
                                color: Colors.red);
                          }
                        }
                      } catch (e) {
                        showSnackBar(
                            content: 'Error Adding Productaaaaaaa',
                            context: context,
                            color: Colors.red);
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                  ),
                ),
              );
      },
      viewModelBuilder: () {
        return AddItemViewModel();
      },
    );
  }
}
