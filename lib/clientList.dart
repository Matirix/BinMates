import 'package:binmatesapp/customAppBar.dart';
import 'package:binmatesapp/databaseinterface.dart';
import 'package:flutter/material.dart';
import 'client.dart';
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
    DBInterface().getBinInfo().then((value) {
      setState(() {
        bins = value;
      });
    });
  }

  List<Client> clients = [
    Client(
        id: 1,
        name: 'John',
        email: 'john@email.com',
        phone: '1234567890',
        address: '123 Main St',
        longitude: -122.803,
        latitude: 49.3255,
        garbage: "Unavailable"),
    Client(
        id: 2,
        name: 'Jane',
        email: 'Jane@emai.com',
        phone: '1234567890',
        address: '123 Main St',
        longitude: 123.133568,
        latitude: 49.3255,
        garbage: "Available "),
    Client(
        id: 3,
        name: 'Joe',
        email: 'Joe@email.com',
        phone: '1234567890',
        address: '123 Main St',
        longitude: -123.116226,
        latitude: 49.346292,
        garbage: "Finished by"),
  ];

  Widget clientCardTemplate(client) {
    return CardTemplate(marker: client);
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

// Copy paste this into body for something different.
// Column(
// children: clients
//     .map((client) => CardTemplate(
//           client: client,
//         ))
//     .toList(),

class CardTemplate extends StatelessWidget {
  final MarkerModel marker;

  const CardTemplate({super.key, required this.marker});

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
          // Navigator.pushNamed(context, '/clientDetails', arguments: {
          //   'id': client.id,
          //   'name': client.name,
          //   'email': client.email,
          //   'phone': client.phone,
          //   'address': client.address,
          //   'longitude': client.longitude,
          //   'latitude': client.latitude,
          //   'garbage': client.garbage,
          // });
        },
      ),
    );
  }
}
