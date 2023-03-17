import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'clientList.dart';
import 'customAppBar.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int index = 0;
  Set<Marker> _markers = {};
  Set<Marker> _selectedMarkers = {};
  Marker? _selectedMarker;

  void _onMarkerTapped(Marker marker) {
    setState(() {
      _selectedMarkers.add(marker);
    });
  }

  @override
  void initState() {
    super.initState();

    // Add your markers to the Set here
    _markers.add(Marker(
      markerId: const MarkerId('marker1'),
      position: const LatLng(37.7749, -122.4194),
      infoWindow: const InfoWindow(
        title: 'Marker 1',
        snippet: 'Address',
      ),
      onTap: () => _onMarkerTapped(_markers.elementAt(0)),
    ));
    _markers.add(Marker(
      markerId: const MarkerId('marker2'),
      position: const LatLng(37.7856, -122.4182),
      infoWindow: const InfoWindow(
        title: 'Marker 2',
        snippet: 'Address',
      ),
      onTap: () => _onMarkerTapped(_markers.elementAt(1)),
    ));
    // Add any other markers you want here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Bin Hunt"),
      body: Column(
        children: [
          // Expanded(
          //   flex: 1,
          //   child: ListView.builder(
          //     itemCount: _markers.length,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text(_markers.elementAt(index).infoWindow.title!),
          //         subtitle: Text(_markers.elementAt(index).infoWindow.snippet!),
          //         onTap: () => _onMarkerTapped(_markers.elementAt(index)),
          //       );
          //     },
          //   ),
          // ),
          Expanded(
            flex: 1,
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.7749, -122.4194),
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

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Selected Routes: '
              '${_selectedMarkers.length}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            // Use the selectedmarkers to view the selected marker's info
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(width: 0.5),
                    // borderRadius: BorderRadius.circular(10),
                  ),
                  minVerticalPadding: 5,
                  title:
                      Text(_selectedMarkers.elementAt(index).infoWindow.title!),
                  subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(_selectedMarkers
                            .elementAt(index)
                            .infoWindow
                            .snippet!),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _selectedMarkers.remove(
                                      _selectedMarkers.elementAt(index));
                                });
                              },
                              child: const Text('Remove'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _selectedMarkers.remove(
                                      _selectedMarkers.elementAt(index));
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
                );
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
          // screens[index],
        ],
      ),
    );
  }
}
