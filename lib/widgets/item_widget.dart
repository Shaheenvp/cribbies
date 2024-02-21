import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              height: h*0.125,
              width: w*0.29,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(17)),
            ),
              child: Image.asset('assets/img.png',
                fit: BoxFit.cover,),
            ),
          ),
           Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name of Product',style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: w*0.04
                )),
                SizedBox(height: 6,),
                Text('Quantity',style: TextStyle(
                  fontWeight: FontWeight.w300,

                )
                ),
                SizedBox(height: 6,),
                Text('CTC',style: TextStyle(
                  fontWeight: FontWeight.w300,

                )
                ),

              ],
            ),
          ),
          SizedBox(width: w*.09,),
           Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text('Shabeer KV',style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: w*0.025
                ),),
              ))
        ],
      ),
    );
  }
}
