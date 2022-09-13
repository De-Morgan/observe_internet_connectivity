import 'dart:math';

import 'package:flutter/material.dart';
import 'package:observe_internet_connectivity/observe_internet_connectivity.dart';

import 'internet_connectivity_listener_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const ShowInternetConnectionToast(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Observe Internet Connectivity Example '),
      ),
      body: Center(
        child: Container(
            color: Colors.orange,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Scaffold(
                          body: Center(
                            child: InternetConnectivityListener(
                              connectivityListener:
                                  (context, hasInternetAccess) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Internet access is$hasInternetAccess')));
                              },
                              child: Text(' I dont knwowe'),
                            ),
                          ),
                        );
                      }));
                    },
                    child: Text(getRandomString(15)))
              ],
            )),
      ),
    );
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
