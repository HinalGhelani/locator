import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  InAppWebViewController? inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    List data = ModalRoute.of(context)!.settings.arguments as List;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: Image.asset(data[3]).image,
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[2],
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "CEO",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                "Company Deatils",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      data[4],
                      height: 80,
                      width: 80,
                    ),
                  ),
                  Text(
                    data[1],
                    style: const TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Company Description",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                data[5],
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    "Company Location",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () async{
                        PermissionStatus status =
                            await Permission.location.request();
                            Navigator.of(context).pushNamed('address',
                                arguments: [inAppWebViewController, data[8]]);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("$status"),
                                backgroundColor: Colors.indigo,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            if (status == PermissionStatus.granted) {
                              print("Granted..");
                            } else {
                              print("denied..");
                            }
                      },
                      icon: const Icon(
                        Icons.location_on,
                        color: Color(0xffC92427),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
