import 'package:cribbies/views/detail_page/detail_page_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

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
           Stack(
             children:[ Container(
               height: h*0.4,
               width: w,
               color: Colors.red,
             ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: CircleAvatar(
                   backgroundColor: Colors.white12,
                   child: IconButton(onPressed: (){
                     Navigator.pop(context);
                   }, icon: Icon(CupertinoIcons.back,color: Colors.white,),)
                 ),
               )
           ]),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                Text('Name Of Product',style: TextStyle(fontSize: w*0.047,fontWeight: FontWeight.w700),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                Text('Quantity',style: TextStyle(fontSize: w*0.04,fontWeight: FontWeight.w500),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                Text('CTC',style: TextStyle(fontSize: w*0.04,fontWeight: FontWeight.w500),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                Text('Description',style: TextStyle(fontSize: w*0.04,fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 100,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: Colors.green,)),
                  SizedBox(width: 40,),
                  IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.red,))
              ],)
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
