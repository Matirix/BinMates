import 'package:binmatesapp/databaseinterface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'clientList.dart';
import 'customAppBar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final user = FirebaseAuth.instance.currentUser;
  List bins = [];
  final Set<Marker> _markers = {};
  final Set<Marker> _selectedMarkers = {};
  Marker? _selectedMarker;

  void _onMarkerTapped(Marker marker) {
    setState(() {
      _selectedMarkers.add(marker);
    });
  }

  void loadMarkers() {
    DBInterface().getBins().then((value) {
      setState(() {
        bins = value.map((bin) => bin.getMarker()).toList();
        bins.asMap().forEach((index, marker) {
          _markers.add(marker);
          _selectedMarkers.add(marker);
          // marker.onTap = () => _onMarkerTapped(marker);
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadMarkers();

    // Add your markers to the Set here
    // _markers.add(Marker(
    //   markerId: const MarkerId('marker1'),
    //   position: const LatLng(49.3255, -123.133568),
    //   infoWindow: const InfoWindow(
    //     title: 'Marker 1',
    //     snippet: 'Address',
    //   ),
    //   onTap: () => _onMarkerTapped(_markers.elementAt(0)),
    // ));
    // _markers.add(Marker(
    //   markerId: const MarkerId('marker2'),
    //   position: const LatLng(49.4455, -123.133568),
    //   infoWindow: const InfoWindow(
    //     title: 'Marker 2',
    //     snippet: 'Address',
    //   ),
    //   onTap: () => _onMarkerTapped(_markers.elementAt(1)),
    // ));
    // _markers.add(Marker(
    //   markerId: const MarkerId('marker3'),
    //   position: const LatLng(49.4255, -123.133568),
    //   infoWindow: const InfoWindow(
    //     title: 'Marker 3',
    //     snippet: 'Address',
    //   ),
    //   onTap: () => _onMarkerTapped(_markers.elementAt(2)),
    // ));
    // _markers.add(Marker(
    //   markerId: const MarkerId('marker4'),
    //   position: const LatLng(49.4355, -123.133568),
    //   infoWindow: const InfoWindow(
    //     title: 'Marker 4',
    //     snippet: 'Address',
    //   ),
    //   onTap: () => _onMarkerTapped(_markers.elementAt(3)),
    // ));
    // Add any other markers you want here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Bin Hunt"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            // padding: const EdgeInsets.all(12.0),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                user?.displayName ?? 'No user',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(10),
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
          SizedBox(
            height: 60,
            // padding: const EdgeInsets.all(12.0),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Selected Routes: '
                '${_selectedMarkers.length}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            // Use the selectedmarkers to view the selected marker's info when someone presses the marker
            child: ListView.builder(
              itemBuilder: (context, index) {
                return binCard(index);
              },
              itemCount: _selectedMarkers.length,
            ),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  height: 35,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // TODO: Add the selected markers to user's Route
                        _selectedMarkers.clear();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF00AD00),
                    ),
                    child: Text('Add to Routes (${_selectedMarkers.length})'),
                  ))),
        ],
      ),
    );
  }

  Padding binCard(int index) {
    /**
     * A card for each bin!
     */
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
            child: Text(_selectedMarkers.elementAt(index).infoWindow.title!)),
        subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(_selectedMarkers.elementAt(index).infoWindow.snippet!),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedMarkers
                            .remove(_selectedMarkers.elementAt(index));
                      });
                    },
                    child: const Text('Remove'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedMarkers
                            .remove(_selectedMarkers.elementAt(index));
                      });
                    },
                    child: const Text('Details'),
                  ),
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
