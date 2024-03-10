import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
class PwItem extends StatelessWidget {
  final pdf = pw.Document();

  final String name, ctc, qty, imageUrl, tag, userName,description;
   PwItem(
      {super.key,
        required this.name,
        required this.ctc,
        required this.qty,
        required this.imageUrl,
        required this.tag,
        required this.userName,
        required this.description});

  @override
  Widget build(BuildContext context) {

    final w = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
          left: 8,
          top: 10,
          bottom: 10,
          child: Container(
            height: 120,
            width: 115,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(17)),
            ),
            child: Hero(
              tag: tag,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          left: 140,
          top: 10,
          bottom: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
              SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Text('QTY : $qty',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      )),
                  SizedBox(width: w*.07,),
                  Text('CTC : - $ctc',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      )),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Container(
                width: MediaQuery.of(context).size.width-188,

                child: Text('Dis : $description\n\n',
                    maxLines: 3,

                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    )),
              ),
              SizedBox(
                height: 6,
              ),

              Text(
                'ADDED BY -: $userName',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
              )
            ],
          ),
        ),
        SizedBox(
          width: w * .05,
        ),
      ],
    );
  }
}
