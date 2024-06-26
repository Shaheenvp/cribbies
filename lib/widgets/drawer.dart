import 'package:Potrack/utils/custom_snackBar.dart';
import 'package:Potrack/views/Sholisted/shortlisted.dart';
import 'package:Potrack/views/SignIn/login.dart';
import 'package:Potrack/views/home/home.dart';
import 'package:Potrack/views/purchaseOrder_page/purchaseOrder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key});

  Future<void> deleteAllProducts() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('purchaseOrders').get();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      print('All products deleted successfully');
    } catch (e) {
      print('Error deleting products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Drawer(
      width: 250,
      shadowColor: Colors.black,
      child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: h * .09,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => PurchaseOrder()));
                },
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Dummy'),
              ),
              const Divider(
                thickness: 1,
              ),
              InkWell(
                // onTap: () {
                //   Navigator.push(
                //       context, MaterialPageRoute(builder: (context) => help()));
                // },
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              InkWell(
                // onTap: () {
                //   Navigator.push(
                //       context, MaterialPageRoute(builder: (context) => help()));
                // },
                child: ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Help'),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Are you sure you want to delete all data including PURCHASE ORDER!',
                            style: TextStyle(fontSize: 16),
                          ),
                          actions: [
                            TextButton(onPressed: () {}, child: Text('No')),
                            TextButton(onPressed: () {}, child: Text('Yes')),
                          ],
                        );
                      });
                },
                child: ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirm Deletion"),
                          content: Text(
                            "Are you sure you want to delete all PURCHASE ORDERS ?",
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () async {
                                await deleteAllProducts();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Delete",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  leading: Icon(Icons.delete),
                  title: Text('Delete All'),
                ),
              ),
              SizedBox(
                height: h * 0.37,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.red,
                    size: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Are you sure you want to logout!',
                                  style: TextStyle(fontSize: 16)),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  PurchaseOrder()));
                                    },
                                    child: Text('No')),
                                TextButton(
                                    onPressed: () async {
                                      SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                      await prefs.setBool('isLoggedIn', false);

                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        CupertinoPageRoute(builder: (context) => SignIn()),
                                            (route) => false,
                                      );
                                    },
                                    child: Text('Yes')),
                              ],
                            );
                          });
                    },
                    child: Text(
                      'logout',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
