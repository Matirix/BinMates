import 'package:binmatesapp/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BinDetails extends StatefulWidget {
  const BinDetails({super.key});

  @override
  State<BinDetails> createState() => _BinDetailsState();
}

/// This is a list to display the status of the bin.
const List<String> statusList = <String>[
  'To-do',
  'In-progress',
  'Uploaded',
  'Completed'
];

/// This is where we will load the specific bin information.
class _BinDetailsState extends State<BinDetails> {
  Map clientData = {};

  @override
  Widget build(BuildContext context) {
    // GETS THE CLIENT DATA FROM CLIENTLIST.DART WHEN USER PRESSES ON LISTITEM
    clientData = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
        appBar: const CustomAppBar(title: "Details"),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(width: 20.0),
                  Text(
                    "${clientData['name']}",
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                //  BASIC CLIENT INFO
                children: <Widget>[
                  const SizedBox(width: 20.0),
                  Text(
                    "Name: ${clientData['name']}",
                    style: const TextStyle(
                      fontSize: 20.0,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Notes: ${clientData['notes']}",
                    style: const TextStyle(
                      fontSize: 20.0,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Assigned to: ${clientData['binmate']}",
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Divider(
                    thickness: 2.0,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // // GARBAGE AVAILABILITY
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        const Text(
                          'Status: ',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Text(
                          "${clientData['status']}",
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ]),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    height: 350,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            clientData['latitude'], clientData['longitude']),
                        zoom: 11.0,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId('client'),
                          position: LatLng(
                              clientData['latitude'], clientData['longitude']),
                        ),
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
