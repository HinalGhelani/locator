import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Modal_class.dart';
import 'address_page.dart';
import 'detail_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const MyApp(),
      'detail': (context) => const DetailPage(),
      'address': (context) => const AddressPage(),
    },
  ));
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
          backgroundColor: Colors.indigo,
        ),
        body:
            // FutureBuilder(
            //   future: loadjson(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError) {
            //       return Center(
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text("Error: ${snapshot.error}"),
            //         ),
            //       );
            //     } else if (snapshot.hasData) {
            //       List<Mnc>? data = snapshot.data as List<Mnc>?;
            //
            //       return (data != null)
            //           ?
            ListView.builder(
                itemCount: finalresult.length,
                itemBuilder: (context, i) {
                  return Card(
                    elevation: 3,
                    child: ListTile(
                        onTap: () {
                          setState(() {
                            Navigator.of(context)
                                .pushNamed('detail', arguments: [
                              finalresult[i]['id'],
                              finalresult[i]['comname'],
                              finalresult[i]['ceoname'],
                              finalresult[i]['image'],
                              finalresult[i]['logo'],
                              finalresult[i]['dec'],
                              finalresult[i]['lat'],
                              finalresult[i]['long'],
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
                                  image: Image.asset(finalresult[i]['logo'])
                                      .image)),
                        )
                        // subtitle: Text("${data[i].ceoName}"),
                        ),
                  );
                })
        // : const Center(
        //     child: Text("No Data"),
        //   );
        //   }
        //   return const Center(
        //     child: CircularProgressIndicator(),
        //   );
        // },
        // ),
        );
  }
}
