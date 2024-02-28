import 'package:Potrack/views/Sholisted/shortlisted.dart';
import 'package:Potrack/views/SignIn/login.dart';
import 'package:Potrack/views/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key});

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
                  Navigator.pushReplacement(context,
                      CupertinoPageRoute(builder: (context) => Home()));
                },
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text('HOME'),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
               InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Shortlisted()));
                },
                child: ListTile(
                  leading: Icon(Icons.save),
                  title: Text('Shortlisted'),
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
                            'Are you sure you want to delete all data!',
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
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Icon(
                      Icons.logout,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: TextButton(
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
                                                builder: (context) => Home()));
                                      },
                                      child: Text('No')),
                                  TextButton(
                                      onPressed: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        await prefs.setBool(
                                            'isLoggedIn', false);

                                        Navigator.pushReplacement(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    SignIn()));
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
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
