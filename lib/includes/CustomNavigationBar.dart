import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onScreenChange;

  const CustomNavigationBar(
      {Key? key, required this.selectedIndex, required this.onScreenChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.red[900],
      ),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.copy_all), label: "All Requests", tooltip: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.send), label: "Place Request", tooltip: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_history),
              label: "My Requests",
              tooltip: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.logout), label: "Logout", tooltip: "")
        ],
        currentIndex: selectedIndex,
        onTap: onScreenChange,
      ),
    );
  }
}
