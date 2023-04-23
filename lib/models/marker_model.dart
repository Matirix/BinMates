import 'dart:convert';
import 'package:flutter/material.dart';
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

  getMarker() {
    /**
     * This function returns the marker object
     */
    return marker;
  }

  factory MarkerModel.fromJson(Map<String, dynamic> json) {
    /**
     * This function converts the JSON object from the database into a MarkerModel object
     */

    Marker? marker;
    Text details = Text(json['binMate'] +
        '\n' +
        json['notes'] +
        '\n' +
        json['status'].toString());

    marker = Marker(
      markerId: MarkerId(json['binAddress']),
      position: LatLng(json['Lat'], json['Lng']),
      infoWindow: InfoWindow(
        title: json['binName'],
        snippet: details.data,
      ),
    );

    return MarkerModel(
      binAddress: json['binAddress'],
      Lat: json['Lat'],
      Lng: json['Lng'],
      binName: json['binName'],
      binMate: json['binMate'],
      notes: json['notes'],
      status: json['status'],
      marker: marker,
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
