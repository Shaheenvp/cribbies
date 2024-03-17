import 'dart:io';

import 'package:Potrack/models/productModel.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';

Future<void> generatePDF(List<ProductModel> products) async {
  final pdf = PdfDocument();
  int serialNumber = 1; // Initialize serial number
  int productsPerPage = 5; // Number of products to display per page

  for (int i = 0; i < products.length; i += productsPerPage) {
    final page = pdf.pages.add();
    double yPos = 60;
    int productsCount = 0; // Counter for products on the current page

    for (var j = i; j < products.length && j < i + productsPerPage; j++) {
      var product = products[j];

      // Draw serial number
      page.graphics.drawString(
        serialNumber.toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: Rect.fromLTWH(10, yPos, 30, 20),
      );

      // Load and draw network image
      final imageBytes =
      await NetworkAssetBundle(Uri.parse(product.imageUrl)).load('');
      final Uint8List imageUint8List = imageBytes.buffer.asUint8List();
      final image = PdfBitmap(imageUint8List);
      page.graphics.drawImage(image, Rect.fromLTWH(50, yPos, 100, 100));

      // Draw product information
      page.graphics.drawString(
        'Product: ${product.productName}',
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: Rect.fromLTWH(160, yPos, 200, 20),
      );
      page.graphics.drawString(
        'CTC: ${product.ctc.toStringAsFixed(2)}',
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: Rect.fromLTWH(160, yPos + 25, 100, 20),
      );
      page.graphics.drawString(
        'Quantity: ${product.quantity}',
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: Rect.fromLTWH(300, yPos + 25, 100, 20),
      );
      page.graphics.drawString(
        'User: ${product.userName}',
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: Rect.fromLTWH(160, yPos + 50, 200, 20),
      );

      yPos += 150; // Increase yPos for next product
      serialNumber++; // Increment serial number
      productsCount++; // Increment product count on the current page
    }

    // Add page number
    page.graphics.drawString(
      'Page ${pdf.pages.count}',
      PdfStandardFont(PdfFontFamily.helvetica, 16),
      bounds: Rect.fromLTWH(
        0,
        page.getClientSize().height - 40,
        page.getClientSize().width,
        20,
      ),
      format: PdfStringFormat(alignment: PdfTextAlignment.center),
    );
  }

  // Save the PDF to a file
  final output = await getTemporaryDirectory();
  final file = File('${output.path}/product_list.pdf');
  await file.writeAsBytes(await pdf.save());

  // Share the PDF file
  Share.shareFiles([file.path], text: 'ProductListPDF');
}