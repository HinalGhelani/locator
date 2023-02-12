import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () async {
                  PermissionStatus status = await Permission.location.request();

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$status"),
                    backgroundColor: Colors.indigo,
                    behavior: SnackBarBehavior.floating,
                  ),
                  );

                  if(status == PermissionStatus.granted){
                    Navigator.of(context).pushNamed('address',arguments: [
                      data[6],
                      data[7],
                    ]);
                  }
                  else{
                    print("denied..");
                  }
                },
                child: Text(
                  "http://www.google.com/Adsress/${data[1]}.com",
                  style: const TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
