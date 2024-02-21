import 'package:Potrack/widgets/custom_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/custom_elevated_button.dart';
import 'add_item_viewmodel.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return ViewModelBuilder<AddItemViewModel>.nonReactive(
      onViewModelReady: (model) {},
      onDispose: (model) {},
      builder: (context, viewModel, child) {
        return WillPopScope(
          onWillPop: () {
            return Future(() => false);
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_outlined)),
            ),
            body:  SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                   Padding(
                    padding: EdgeInsets.only(left: w*.06),
                    child: Text('Product Photos',style: TextStyle(fontSize: w*0.04,fontWeight: FontWeight.w500),),
                  ),
                  const SizedBox(height: 10,),
                  Center(
                    child: Container(
                      height: h*0.15,
                      width: w*0.9,
                      decoration: BoxDecoration(border: Border.all(
                        color: Colors.black38
                      ),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(onPressed: (){
                              viewModel.pickImage();
                            }, icon:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(height: w*0.09,'assets/img_1.png'),
                                Text('Upload Files',style: TextStyle(fontSize: w*0.025,color: Colors.black54,),)
                              ],
                            ),
              
                            ),
                            IconButton(onPressed: (){
                              viewModel.takePicture();
                            }, icon:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(height: w*0.09,'assets/img_2.png'),
                                Text('Open Camera',style: TextStyle(fontSize: w*0.025,color: Colors.black54,),)
                              ],
                            ),
              
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.only(left: w*.06),
                    child:
                    Text('Name Of Product',style: TextStyle(fontSize: w*0.04,fontWeight: FontWeight.w500),),
                  ),
                  const SizedBox(height: 10,),
                  Center(
                    child: CustomTextFormField(
                        controller: viewModel.productNameController,
                        labelText: 'Name',
                      labelTextStyle: const TextStyle(
                        fontSize: 10,
                        color: Colors.black54
                      ),
                      height: h*0.05,
                      width: w*0.9,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.only(left: w*.06),
                    child:
                    Text('Quantity',style: TextStyle(fontSize: w*0.04,fontWeight: FontWeight.w500),),
                  ),
                  const SizedBox(height: 10,),
                  Center(
                    child: CustomTextFormField(
                        controller: viewModel.productNameController,
                        labelText: 'Quantity',
                      labelTextStyle: const TextStyle(
                        fontSize: 10,
                        color: Colors.black54
                      ),
                      height: h*0.05,
                      width: w*0.9,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.only(left: w*.06),
                    child: Text('CTC',style: TextStyle(fontSize: w*0.04,fontWeight: FontWeight.w500),),
                  ),
                  const SizedBox(height: 10,),
                  Center(
                    child: CustomTextFormField(
                        controller: viewModel.productNameController,
                        labelText: 'CTC',
                      labelTextStyle: const TextStyle(
                        fontSize: 10,
                        color: Colors.black54
                      ),
                      height: h*0.05,
                      width: w*0.9,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.only(left: w*.06),
                    child:  Text('Description',style: TextStyle(fontSize: w*0.04,fontWeight: FontWeight.w500),),
                  ),
                  const SizedBox(height: 10,),
                  Center(
                      child: CustomTextFormField(
                          controller: viewModel.productNameController,
                          labelText: 'Share some details...',
                        maxLines: 5,
                        labelTextStyle: const TextStyle(
                          fontSize: 10,
                          color: Colors.black54
                        ),
                        height: h*0.15,
                        width: w*0.9,
                      ),
                  ),
                   SizedBox(height: h*.05,),
                  Center(
                    child: CustomElevatedButton(
                        buttonStyle: ButtonStyle(
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                            backgroundColor:
                            MaterialStatePropertyAll(Color(0xffF6D5CA))),
                        width: w*0.6,
                        height: h*0.055,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xffF6D5CA)),
                        text: "SUBMIT",
                        margin: EdgeInsets.symmetric(horizontal: 32),
                        onPressed: () {

                        }),
                  ),


                ],
              ),
            ),
          ),
        );
      }, viewModelBuilder: () {
      return AddItemViewModel();
    },
    );
  }
}


