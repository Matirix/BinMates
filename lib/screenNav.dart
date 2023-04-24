import 'package:binmatesapp/binDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'binList.dart';
import 'binMap.dart';

/// Bottom Navigation bar. Used to switch between screens
class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

/// Bottom navigation bar, to add more screens, add them to screens and add a
/// NavigationDestination to desitinatons.
class _NavBarState extends State<NavBar> {
  int index = 0;
  final screens = [const MapScreen(), const BinList(), const BinDetails()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.green[400],
        ),
        child: NavigationBar(
            selectedIndex: index,
            onDestinationSelected: (index) => setState(() {
                  this.index = index;
                  // print(index);
                }),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.add_location_alt_outlined),
                label: "Bin Hunt",
                selectedIcon: Icon(Icons.add_location_alt),
              ),
              NavigationDestination(
                icon: Icon(Icons.arrow_forward_ios),
                label: "My Bins",
                selectedIcon: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ]),
      ),
    );
  }
}
