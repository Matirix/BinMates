import 'package:binmatesapp/customAppBar.dart';
import 'package:binmatesapp/databaseinterface.dart';
import 'package:binmatesapp/main.dart';
import 'package:binmatesapp/models/marker_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Utils.dart';

class AddBinAdmin extends StatefulWidget {
  const AddBinAdmin({super.key});

  @override
  State<AddBinAdmin> createState() => _AddBinAdminState();
}

class _AddBinAdminState extends State<AddBinAdmin> {
  final formKey = GlobalKey<FormState>();
  final _binNameController = TextEditingController();
  final _binAddressController = TextEditingController();
  final _binMateController = TextEditingController();
  final _notesController = TextEditingController();

  Future<void> _addBin() async {
    // final isValid = formKey.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    LatLng? latLng = await DBInterface().geocodeAddress(
      _binAddressController.text,
    );

    Map<String, dynamic> binInfoMap = {
      "binName": _binNameController.text,
      "binAddress": _binAddressController.text,
      "Lat": latLng!.latitude,
      "Lng": latLng.longitude,
      "binMate": _binMateController.text,
      "notes": _notesController.text,
    };

    MarkerModel binInfo = MarkerModel(
      binName: _binNameController.text,
      binAddress: _binAddressController.text,
      Lat: latLng.latitude,
      Lng: latLng.longitude,
      binMate: _binMateController.text,
      notes: _notesController.text,
    );

    try {
      await DBInterface().addBinInfo(
        binInfo,
      );
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Add Bin'),
        body: Column(
          children: [
            Container(
                color: const Color(0xFFFFFEF7),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(height: 10.0),
                    const Text(
                      'Add Bin',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    TextFormField(
                      controller: _binNameController,
                      decoration: const InputDecoration(
                        labelText: 'Bin Name',
                      ),
                    ),
                    TextFormField(
                        controller: _binAddressController,
                        decoration: const InputDecoration(
                          labelText: 'Bin Address',
                        )),
                    TextFormField(
                        controller: _binMateController,
                        decoration: const InputDecoration(
                          labelText: 'Assign to a Bin Mate',
                        )),
                    TextFormField(
                        controller: _notesController,
                        decoration: const InputDecoration(
                          labelText: 'Notes: e.g. Bin, password',
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00AD00),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      onPressed: () async {
                        await _addBin();
                      },
                      child: const Text('Add Bin'),
                    ),
                  ],
                ))
          ],
        ));
  }
}
