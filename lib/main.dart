import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Modal_class.dart';
import 'address_page.dart';
import 'detail_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const MyApp(),
        'detail': (context) => const DetailPage(),
        'address': (context) => const AddressPage(),
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List finalresult = [];
  String jsonData = "";

  loadjson() async {
    jsonData = await rootBundle.loadString("assets/json/mnc_detail.json");

    List decodedData = jsonDecode(jsonData);

    setState(() {
      finalresult = decodedData;
    });
  }

  late Future<Mnc?> getData;

  @override
  void initState() {
    super.initState();
    loadjson();
    // getData = APIHelper.apiHelper.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "MNC CEO's",
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await openAppSettings();
              },
              icon: const Icon(Icons.settings),
            ),
          ],
          backgroundColor: Colors.indigo,
        ),
        body: ListView.builder(
            itemCount: finalresult.length,
            itemBuilder: (context, i) {
              return Card(
                elevation: 3,
                child: ListTile(
                    onTap: () {
                      setState(() {
                        Navigator.of(context).pushNamed('detail', arguments: [
                          finalresult[i]['id'],
                          finalresult[i]['comname'],
                          finalresult[i]['ceoname'],
                          finalresult[i]['image'],
                          finalresult[i]['logo'],
                          finalresult[i]['dec'],
                          finalresult[i]['lat'],
                          finalresult[i]['long'],
                          finalresult[i]['map'],
                        ]);
                      });
                    },
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          Image.asset(finalresult[i]['image']).image,
                    ),
                    title: Text(finalresult[i]['comname']),
                    subtitle: Text(finalresult[i]['ceoname']),
                    trailing: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  Image.asset(finalresult[i]['logo']).image)),
                    )
                    // subtitle: Text("${data[i].ceoName}"),
                    ),
              );
            }));
  }
}
