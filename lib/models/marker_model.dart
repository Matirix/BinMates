import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerModel {
  String binAddress;
  double Lat;
  double Lng;
  String binName;
  String binMate;
  String notes;
  String status;
  Marker? marker;

  MarkerModel(
      {required this.binAddress,
      required this.Lat,
      required this.Lng,
      required this.binName,
      required this.binMate,
      required this.notes,
      required this.status,
      this.marker});

  factory MarkerModel.fromJson(Map<String, dynamic> json) {
    /**
     * This function converts the JSON object from the database into a MarkerModel object
     */
    return MarkerModel(
      binAddress: json['binAddress'],
      Lat: json['Lat'],
      Lng: json['Lng'],
      binName: json['binName'],
      binMate: json['binMate'],
      notes: json['notes'],
      status: json['status'],
    );
  }

  toJson() {
    /**
     * This function converts the MarkerModel object into a JSON object to parse into the database
     */
    return {
      "binAddress": binAddress,
      "Lat": Lat,
      "Lng": Lng,
      "binName": binName,
      "binMate": binMate,
      "notes": notes,
      "status": status,
    };
  }
}
