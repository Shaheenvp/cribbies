import 'package:cribbies/views/detail_page/detail_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailPageViewModel>.nonReactive(
      onViewModelReady: (model) {},
      onDispose: (model) {},
      builder: (context, viewModel, child) {
        return Scaffold(
          body: ListView(
            children: [
             ConstrainedBox(constraints: BoxConstraints(
               maxWidth: 360,
               minWidth: 280,
             )

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
