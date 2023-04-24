import 'package:binmatesapp/customAppBar.dart';
import 'package:binmatesapp/databaseinterface.dart';
import 'package:flutter/material.dart';
import 'models/binModel.dart';

class BinList extends StatefulWidget {
  const BinList({super.key});

  @override
  State<BinList> createState() => _BinListState();
}

class _BinListState extends State<BinList> {
  List bins = [];
  @override
  initState() {
    super.initState();
    loadBins();
  }

  void loadBins() {
    /**
     * This is where we will load the bins from the database
     */
    DBInterface().getBins().then((value) {
      setState(() {
        bins = value;
      });
    });
  }

  Widget binCardTemplate(marker) {
    /**
     * This is where we will create the card template for the client
     */
    return CardTemplate(marker: marker);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: const CustomAppBar(title: "My Bins"),
        body: ListView.builder(
          itemCount: bins.length,
          itemBuilder: (context, index) {
            return CardTemplate(marker: bins[index]);
          },
        ));
  }
}

class CardTemplate extends StatelessWidget {
  const CardTemplate({super.key, required this.marker});
  final Bin marker;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // This could be an image over here
          children: const <Widget>[Icon(Icons.person)],
        ),
        title: Text(marker.binAddress),
        subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Text(marker.binName), Text(marker.status)]),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.pushNamed(context, '/binDetails', arguments: {
            'name': marker.binName,
            'address': marker.binAddress,
            'binmate': marker.binMate,
            'longitude': marker.Lng,
            'latitude': marker.Lat,
            'status': marker.status,
            'notes': marker.notes,
          });
        },
      ),
    );
  }
}
