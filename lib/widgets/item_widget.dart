import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final String name, ctc, qty, imageUrl, tag;
  const ItemWidget(
      {super.key,
      required this.name,
      required this.ctc,
      required this.qty,
      required this.imageUrl,
      required this.tag});

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
              Text(qty,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  )),
              SizedBox(
                height: 6,
              ),
              Text(ctc,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  )),
            ],
          ),
        ),
        SizedBox(
          width: w * .09,
        ),
        const Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Shabeer KV',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 11),
            ))
      ],
    );
  }
}
