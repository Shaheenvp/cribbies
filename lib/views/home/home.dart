import 'package:cribbies/views/detail_page/detail_page.dart';
import 'package:cribbies/views/home/home_viewmodel.dart';
import 'package:cribbies/widgets/custom_floatingaction_button.dart';
import 'package:cribbies/widgets/drawer.dart';
import 'package:cribbies/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      onViewModelReady: (model) {},
      onDispose: (model) {},
      builder: (context, viewModel, child) {
        return Scaffold(
          key:viewModel.scaffoldKey,
            backgroundColor: Colors.white,
            endDrawer: CustomDrawer(),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
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
            floatingActionButton: CustomFloatingActionButton(
              onPressed: () {
                viewModel.onTapAddButton(context);
              },
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return  Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Card(
                      elevation: 1,
                      color: Colors.white,
                      child: SizedBox(height: 120, child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage()));
                          },
                          child: ItemWidget())),
                    ),
                  );
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
