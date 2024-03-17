import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemWidget extends StatelessWidget {
  final String name, ctc, qty, imageUrl, tag, userName, description;
  const ItemWidget(
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
    const double imageWidth = 120.0; // Fixed width for the image
    final double textWidth = MediaQuery.of(context).size.width - imageWidth - 24;
    final w = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
          left: 8,
          top: 10,
          bottom: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            child: Container(
              width: imageWidth,
              child: Hero(
                tag: tag,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: imageUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Transform.scale(
                        scale: .4,
                        child: CircularProgressIndicator(
                            strokeWidth: 1,
                            color: Colors.black,
                            value: downloadProgress.progress),
                      ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
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
                  SizedBox(width: textWidth * .07),
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
                width: textWidth,
                child: Text(
                  'Dis : $description\n\n',
                  maxLines: 3,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                ),
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
      ],
    );
  }
}
