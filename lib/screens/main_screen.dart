import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:funfacts/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> facts = [];
  bool isLoading = false;

  Future<void> getData() async {
    try {
      Response response = await Dio().get(
          "https://raw.githubusercontent.com/ogunbor/flutter_dummy_api/main/facts.json");
      facts = jsonDecode(response.data); //To convert string to json
      isLoading = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      print(e);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fun facts"),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SettingsScreen();
                }));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.settings),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: isLoading
                  ? LinearProgressIndicator()
                  : PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: facts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            child: Center(
                                child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            facts[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 35),
                          ),
                        )));
                      }),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Swipe left for more'),
              ),
            )
          ],
        ));
  }
}
