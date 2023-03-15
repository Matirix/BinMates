import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientDetails extends StatefulWidget {
  const ClientDetails({super.key});

  @override
  State<ClientDetails> createState() => _ClientDetailsState();
}

const List<String> statusList = <String>[
  'Unavailable',
  'Available',
  'In-progress',
  'Completed'
];

class _ClientDetailsState extends State<ClientDetails> {
  Map clientData = {};

  String dropdownValue = statusList.first;

  @override
  Widget build(BuildContext context) {
    // GETS THE CLIENT DATA FROM CLIENTLIST.DART WHEN USER PRESSES ON LISTITEM
    clientData = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Client Details'),
          centerTitle: true,
          backgroundColor: Colors.greenAccent[700],
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(width: 20.0),
                  Text(
                    "${clientData['address']}",
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
                    "Email: ${clientData['email']}",
                    style: const TextStyle(
                      fontSize: 20.0,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Phone: ${clientData['phone']}",
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
                  // GARBAGE AVAILABILITY
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        const Text(
                          'Garbage: ',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        // DROPDOWN OPTIONS
                        DropdownButton<String>(
                          borderRadius: BorderRadius.circular(15),
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward,
                              color: Colors.green),
                          style: const TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: Colors.grey,
                          ),
                          items: statusList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
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
