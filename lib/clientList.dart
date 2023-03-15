import 'package:flutter/material.dart';
import 'client.dart';

class ClientList extends StatefulWidget {
  const ClientList({super.key});

  @override
  State<ClientList> createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  // static const IconData circle_sharp =
  //     IconData(0xe861, fontFamily: 'MaterialIcons');

  List<Client> clients = [
    Client(
        id: 1,
        name: 'John',
        email: 'john@email.com',
        phone: '1234567890',
        address: '123 Main St',
        longitude: 0.0,
        latitude: 0.0,
        garbage: "Unavailable"),
    Client(
        id: 2,
        name: 'Jane',
        email: 'Jane@emai.com',
        phone: '1234567890',
        address: '123 Main St',
        longitude: 0.0,
        latitude: 0.0,
        garbage: "Available "),
    Client(
        id: 3,
        name: 'Joe',
        email: 'Joe@email.com',
        phone: '1234567890',
        address: '123 Main St',
        longitude: 0.0,
        latitude: 0.0,
        garbage: "Finished by"),
  ];

  Widget clientCardTemplate(client) {
    return CardTemplate(client: client);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Clients'),
          centerTitle: true,
          backgroundColor: Colors.greenAccent[700],
        ),
        body: ListView.builder(
          itemCount: clients.length,
          itemBuilder: (context, index) {
            return CardTemplate(client: clients[index]);
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
  final Client client;

  const CardTemplate({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // This could be an image over here
          children: const <Widget>[Icon(Icons.person)],
        ),
        title: Text(client.name),
        subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Text(client.address), Text(client.garbage)]),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.pushNamed(context, '/clientDetails', arguments: {
            'id': client.id,
            'name': client.name,
            'email': client.email,
            'phone': client.phone,
            'address': client.address,
            'longitude': client.longitude,
            'latitude': client.latitude,
            'garbage': client.garbage,
          });
        },
      ),
    );
  }
}