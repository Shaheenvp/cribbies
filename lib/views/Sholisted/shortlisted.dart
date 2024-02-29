import 'package:Potrack/views/Sholisted/shortlisted_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Shortlisted extends StatelessWidget {
  const Shortlisted({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ShortListedViewModel>.nonReactive(
      onViewModelReady: (model) {},
      onDispose: (model) {},
      builder: (context, viewModel, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back)),
              actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
            ),
            body: SizedBox(
                height: double.infinity,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        elevation: 1,
                        child: Container(
                          height: 180,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(17)),
                                      color: Colors.red),
                                  //child:
                                  // Image.network(
                                  //   imageUrl,
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15)),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text('qty',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        )),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text('ctc',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        )),
                                    Text('dis',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ),
        );
      },
      viewModelBuilder: () {
        return ShortListedViewModel();
      },
    );
  }
}
