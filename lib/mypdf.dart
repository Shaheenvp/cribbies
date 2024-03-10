// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:printing/printing.dart';
// import 'package:sow/models/invoice_model.dart';
// import 'package:sow/screens/invoices/image_builder.dart';
// import '../../models/products_model.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
//
// class InvoiceManagment extends StatelessWidget {
//   List<ProductsModel> invoice_product_list;
//   InvoiceManagment({
//     Key? key,
//     required this.invoice_product_list,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // InvoiceModel invoicemodel = InvoiceModel();
//
//     InvoiceModel invoice_product = invoice_data();
//
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: SizedBox(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             child: Stack(
//               children: [
//                 const Positioned(
//                   top: 0,
//                   left: 75,
//                   child: ImageBuilder(
//                     imagePath: "assets/images/integra_logo_v3.png",
//                     imgWidth: 200,
//                     imgheight: 80,
//                   ),
//                 ),
//
//                 for (int x = 0; x < invoice_product_list.length; x++)
//                   Positioned(
//                     top: 120 + (x * 25),
//                     left: 10,
//                     child: Container(
//                       color: x % 2 != 0
//                           ? const Color.fromARGB(255, 236, 236, 236)
//                           : const Color.fromARGB(255, 255, 251, 251),
//                       child: Row(
//                         children: [
//                           SizedBox(
//                             width: 75,
//                             child: Text(
//                               invoice_product_list[x].pCode.toString().trim(),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 180,
//                             child: Text(
//                               invoice_product_list[x].pName.toString().trim(),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 55,
//                             child: Text(
//                               invoice_product_list[x].pSales.toString(),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 55,
//                             child: Text(
//                               invoice_product_list[x].pGreturn.toString(),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                 //  InvoiceBuilder(),
//
//                 Positioned(
//                   top: MediaQuery.of(context).size.height - 80,
//                   left: 75,
//                   child: SizedBox(
//                     width: 200,
//                     height: 50,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         onPrimary: Colors.indigo,
//                         primary: Colors.indigo,
//                         minimumSize: const Size(double.infinity, 56),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                       // onPressed: () {},
//                       onPressed: () => printDoc(),
//                       child: const Text(
//                         "Save as PDF",
//                         style: TextStyle(color: Colors.white, fontSize: 20.00),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Future<void> printDoc() async {
//   //   final image = await imageFromAssetBundle(
//   //     "assets/images/integra_logo_v3.png",
//   //   );
//   //   final doc = pw.Document();
//   //   doc.addPage(pw.Page(
//   //       pageFormat: PdfPageFormat.a4,
//   //       build: (pw.Context context) {
//   //         return buildPrintableData(
//   //             invoice_log: image, Invoiceproducts: invoice_product_list);
//   //       }));
//   //   await Printing.layoutPdf(
//   //       onLayout: (PdfPageFormat format) async => doc.save());
//   // }
//
//   Future<void> printDoc() async {
//     InvoiceModel invinfo = invoice_data();
//     // final image = await imageFromAssetBundle(
//     //   "assets/images/integra_logo_v3.png",
//     // );
//
//     final doc = pw.Document();
//     doc.addPage(
//       pw.MultiPage(
//         build: (pw.Context context) => [
//           // buildInvoiceHeaderImage(image),
//           // pw.Divider(),
//           buildInvoiceHeader(invinfo),
//           buildInvoiceTitle(invinfo),
//           buildInvoiceProducts(invinfo),
//           pw.Divider(),
//           buildFootterBalances(invinfo),
//         ],
//         footer: (context) => buildFooterNotes(invinfo),
//       ),
//     );
//     await Printing.layoutPdf(
//         onLayout: (PdfPageFormat format) async => doc.save());
//   }
//
//   buildInvoiceTitle(InvoiceModel invinfo) {
//     return pw.Column(
//         crossAxisAlignment: pw.CrossAxisAlignment.start,
//         children: [
//           pw.Text("Invoice",
//               style: pw.TextStyle(
//                   fontBold: pw.Font.helvetica(),
//                   fontWeight: pw.FontWeight.bold)),
//           pw.Text("Invoice No.:${invinfo.invoiceheadder!.invoicenumber}"),
//           pw.Text("      Date :${invinfo.invoiceheadder!.invoicedate}"),
//           pw.Text("  Due Date :${invinfo.invoiceheadder!.invoicedue}"),
//           pw.Text("     Tearm :${invinfo.invoiceheadder!.invoiceptearm}"),
//         ]);
//   }
//
//   buildInvoiceProducts(InvoiceModel invinfo) {
//     final headers = ['Description', 'Sales', 'Promo', 'FOC', 'G. Rtn', 'B Rtn'];
//     final data = invoice_product_list.map((item) {
//       return [
//         "${item.pName}",
//         // Utils.formatDate(invinfo.invoiceheadder!.invoicedate),
//         double.parse(item.pSales.toString()) / 24,
//         double.parse(item.pPromo.toString()) / 24,
//         double.parse(item.pFoc.toString()) / 24,
//         double.parse(item.pGreturn.toString()) / 24,
//         double.parse(item.pBreturn.toString()) / 24,
//       ];
//     }).toList();
//
//     return pw.TableHelper.fromTextArray(
//         headers: headers,
//         data: data,
//         border: null,
//         headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//         headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
//         // cellHeight: 15,
//         cellAlignments: {
//           0: pw.Alignment.centerLeft,
//           1: pw.Alignment.centerRight,
//           2: pw.Alignment.centerRight,
//           3: pw.Alignment.centerRight,
//           4: pw.Alignment.centerRight,
//           5: pw.Alignment.centerRight,
//         });
//   }
//
//   buildFootterBalances(InvoiceModel invinfo) {
//     double tot_sales = 0;
//     final data = invoice_product_list.map((item) {
//       tot_sales = tot_sales + double.parse(item.pSales.toString());
//     });
//     return pw.Container(
//       alignment: pw.Alignment.centerRight,
//       child: pw.Row(
//         children: [
//           pw.Spacer(flex: 6),
//           pw.Expanded(
//             flex: 4,
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.end,
//               children: [
//                 buildFootterText(
//                   title: "Sub Total",
//                   // value: formatPrice(100.00),
//                   value: "1500.00",
//                   unite: true,
//                 ),
//                 pw.Divider(),
//                 buildFootterText(
//                   title: "Total",
//                   // value: formatPrice(100.00),
//                   value: "150.00",
//                   unite: true,
//                 ),
//                 pw.Divider(),
//                 buildFootterText(
//                   title: "Total Amount Due",
//                   // value: formatPrice(100.00),
//                   value: "150.00",
//                   unite: true,
//                 ),
//                 pw.Container(
//                   height: 4,
//                   color: PdfColors.black,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   buildFootterText(
//       {required String title,
//         required String value,
//         double width = double.infinity,
//         TextStyle? titleStyle,
//         bool unite = false}) {
//     final style1 = titleStyle ?? pw.TextStyle(fontWeight: pw.FontWeight.bold);
//     return pw.Container(
//       width: width,
//       child: pw.Row(
//         children: [
//           pw.Expanded(
//             child: pw.Text(
//               title,
//               // style: style1,
//             ),
//           ),
//           pw.Text(
//             value,
//             // style: unit ? style : null,
//           ),
//         ],
//       ),
//     );
//   }
//
//   buildFooterNotes(InvoiceModel invinfo) => pw.Column(
//     crossAxisAlignment: pw.CrossAxisAlignment.center,
//     children: [
//       pw.Divider(),
//       pw.Text(invinfo.invoicefootter!.invoicetearms.toString()),
//       pw.Text(invinfo.invoicefootter!.invoicewebsite.toString()),
//     ],
//   );
//
//   buildInvoiceHeader(InvoiceModel invinfo) => pw.Column(
//     crossAxisAlignment: pw.CrossAxisAlignment.end,
//     children: [
//       pw.Row(
//         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//         children: [
//           pw.Text(invinfo.invoiceheadder!.invoicenumber.toString()),
//           pw.Container(
//             width: 50,
//             height: 50,
//             child: pw.BarcodeWidget(
//                 barcode: pw.Barcode.qrCode(),
//                 data: invinfo.invoiceheadder!.invoicenumber.toString()),
//           ),
//         ],
//       ),
//     ],
//   );
//
//   buildInvoiceHeaderImage(pw.ImageProvider invoice_log) {
//     pw.Column(
//       children: [
//         pw.Align(
//           alignment: pw.Alignment.topCenter,
//           child: pw.Image(
//             invoice_log,
//             width: 250,
//             height: 250,
//           ),
//         ),
//         pw.Divider(),
//       ],
//     );
//   }
// }
//
// InvoiceModel invoice_data() {
//   Invoiceheadder invoiceheadder = Invoiceheadder(
//       invoicedate: "100-100-100",
//       invoicedue: "15-05-2024",
//       invoicenumber: "100-100-100",
//       invoiceptearm: "Credit");
//
//   Invoicefootter invoicefootter = Invoicefootter(
//       invoicesupplier: "Integra CODE Inc. FMCG Division",
//       invoicetearms: "can not be return, damages can be replace within 3 days",
//       invoicewebsite: "http://www.integra-code.com/support");
//
//   Invoicebillto invoicebillto = Invoicebillto(
//       customercode: "C001", customername: "C001", customeraddres: "C001");
//
//   Invoiceshipto invoiceshipto = Invoiceshipto(
//       customercode: "C001", customername: "C001", customeraddres: "C001");
//
//   List<Invoiceproducts> invoice_product = [];
//   invoice_product.add(Invoiceproducts(
//       productcode: "P001",
//       productdescription: "Pepsi 350Mlx24",
//       price: 25,
//       discountedPrice: 23,
//       discountPercentage: 2));
//
//   invoice_product.add(Invoiceproducts(
//       productcode: "P002",
//       productdescription: "7Up 350Mlx24",
//       price: 25,
//       discountedPrice: 23,
//       discountPercentage: 2));
//
//   invoice_product.add(Invoiceproducts(
//       productcode: "P003",
//       productdescription: "Miranda 350Mlx24",
//       price: 25,
//       discountedPrice: 23,
//       discountPercentage: 2));
//
//   invoice_product.add(Invoiceproducts(
//       productcode: "P004",
//       productdescription: "Tropicana 350Mlx24",
//       price: 25,
//       discountedPrice: 23,
//       discountPercentage: 2));
//
//   invoice_product.add(Invoiceproducts(
//       productcode: "P005",
//       productdescription: "Aquafina 350Mlx24",
//       price: 25,
//       discountedPrice: 23,
//       discountPercentage: 2));
//
//   Invoicedetails invoicedetails =
//   Invoicedetails(invoiceproducts: invoice_product);
//
//   InvoiceModel invoicemodel = InvoiceModel(
//       invoiceheadder: invoiceheadder,
//       invoicefootter: invoicefootter,
//       invoicebillto: invoicebillto,
//       invoiceshipto: invoiceshipto,
//       invoicedetails: invoicedetails);
//   return invoicemodel;
// }