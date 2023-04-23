import 'package:binmatesapp/customAppBar.dart';
import 'package:binmatesapp/databaseinterface.dart';
import 'package:flutter/material.dart';
import 'models/marker_model.dart';

// My routes class
class ClientList extends StatefulWidget {
  const ClientList({super.key});

  @override
  State<ClientList> createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  // static const IconData circle_sharp =
  //     IconData(0xe861, fontFamily: 'MaterialIcons');
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
        appBar: const CustomAppBar(title: "Routes"),
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
  final MarkerModel marker;

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
          Navigator.pushNamed(context, '/clientDetails', arguments: {
            'name': marker.binName,
            'address': marker.binAddress,
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
