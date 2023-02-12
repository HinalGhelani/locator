import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  double lat = 0;
  double long = 0;

  Placemark? placemark;

  load() async {

  }

  @override
  void initState() {
    super.initState();
    // load();
  }

  @override
  Widget build(BuildContext context) {
    List address = ModalRoute.of(context)!.settings.arguments as List;


    return Scaffold(
        appBar: AppBar(
          title: const Text("Address"),
          centerTitle: true,
          backgroundColor: Colors.indigo,
          actions: [
            IconButton(
                onPressed: () async {
                  List<Placemark> placemarks =
                      await placemarkFromCoordinates(address[0], address[1]);

                  setState(() {
                    placemark = placemarks[0];
                  });
                },
                icon: const Icon(Icons.download))
          ],
        ),
        body: Column(
          children: [
            // StreamBuilder(
            //   stream: Geolocator.getPositionStream(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError) {
            //       return Center(
            //         child: Text("Error : ${snapshot.error}"),
            //       );
            //     } else if (snapshot.hasData) {
            //       Position? data = snapshot.data;
            //
            //       address[0] = data!.latitude;
            //       address[1] = data!.longitude;
            //
            //       lat = address[0];
            //       long = address[1];
            //
            //       return (data != null)
            //           ? Text("${data.latitude}, ${data.longitude}")
            //           : const Text("No Data....");
            //     }
            //     return const Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   },
            // ),
            Text(
              "${placemark}",
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            )
          ],
        ));
  }
}
