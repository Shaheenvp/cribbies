import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key});

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
            child: Image.asset('assets/img.png',
              fit: BoxFit.cover,),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name of Product',style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15
              )),
              SizedBox(height: 6,),
              Text('Descriptionaaaaaa',style: TextStyle(
                fontWeight: FontWeight.w300,

              )
              ),

            ],
          ),
        ),
        SizedBox(width: w*.09,),
        const Align(
            alignment: Alignment.bottomRight,
            child: Text('Shabeer KV',style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 11
            ),))
      ],
    );
  }
}
