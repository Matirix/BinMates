import 'package:binmatesapp/databaseinterface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'binList.dart';
import 'customAppBar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final user = FirebaseAuth.instance.currentUser;
  int index = 0;
  // Bins specific
  List bins = [];
  // For Markers
  final Set<Marker> _markers = {};
  Marker? _selectedMarker;

  void loadBinsAndMarkers() {
    /**
     * This is where we will load the bins from the database
     */

    DBInterface().getBins().then((docs) {
      setState(() {
        // To get the markers from the bins list
        bins = docs.map((bin) => bin.getMarker()).toList();
        // converts the list of markers to a map to add to the _markers set.
        bins.asMap().forEach((index, marker) {
          _markers.add(marker);
        });
        //  To get the bins from the markers list
        bins = docs;
      });
    });
  }

  @override
  void initState() {
    /**
     * The bins and markers are initialized here. 
     */
    super.initState();
    loadBinsAndMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Bin Hunt"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            // padding: const EdgeInsets.all(12.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Available bins: ${bins.length}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      )),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "${user?.displayName ?? 'No User'}",
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(7),
              height: 250,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(49.3255, -123.133568),
                    zoom: 10,
                  ),
                  markers: _markers,
                  onTap: (_) {
                    setState(() {
                      _selectedMarker = null;
                    });
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            // List Builder
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return binCard(index);
              },
              itemCount: bins.length,
            ),
          ),
        ],
      ),
    );
  }

  Padding binCard(int index) {
    /**
     * A card for each bin!
     */

    final selectedMarker = bins.elementAt(index);

    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
      child: ListTile(
        // tileColor: Colors.green[100],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Color(0xB000AD00), width: 2)),
        minVerticalPadding: 5,
        title: Padding(
            padding: const EdgeInsetsDirectional.only(top: 10),
            child: Text(bins.elementAt(index).binName!)),

        subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Text(_markers.elementAt(index).infoWindow.snippet!),
              Text('BinMate: ${selectedMarker.binMate} '),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Bin Status: ${selectedMarker.status}'),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pushNamed(context, '/binDetails', arguments: {
                          'name': selectedMarker.binName,
                          'address': selectedMarker.binAddress,
                          'binmate': selectedMarker.binMate,
                          'longitude': selectedMarker.Lng,
                          'latitude': selectedMarker.Lat,
                          'status': selectedMarker.status,
                          'notes': selectedMarker.notes,
                        });
                      });
                    },
                    child: const Text('Details'),
                  ),
                  // TODO For the binmates side of the app, add this code to the My Bins page
                  // TextButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       _selectedMarkers.remove(
                  //           _selectedMarkers.elementAt(index));
                  //     });
                  //   },
                  //   child: const Text('Add to Route'),
                  // ),
                ],
              )
            ]),
        // onTap: () {
        //   setState(() {
        //     _selectedMarkers
        //         .remove(_selectedMarkers.elementAt(index));
        //   });
        // }
      ),
    );
  }
}
