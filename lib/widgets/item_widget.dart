import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final String name, ctc, qty, imageUrl, tag, userName;
  const ItemWidget(
      {super.key,
      required this.name,
      required this.ctc,
      required this.qty,
      required this.imageUrl,
      required this.tag,
      required this.userName});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            height: 98,
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
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
              SizedBox(
                height: 6,
              ),
              Text('QTY : $qty',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  )),
              SizedBox(
                height: 6,
              ),
              Text('CTC : - $ctc',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  )),
              Text(
                'ADDED BY -: $userName',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
              )
            ],
          ),
        ),
        SizedBox(
          width: w * .09,
        ),
      ],
    );
  }
}
