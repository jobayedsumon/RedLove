import 'package:redlove/helpers/functions.dart';

import '../includes/CustomNavigationBar.dart';
import 'all_requests_screen.dart';
import 'my_requests_screen.dart';
import 'place_request_screen.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  final int initialIndex;

  const InitialScreen({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  int _selectedIndex = 0;

  void onScreenChange(int index) {
    if (index == 3) {
      logout(context);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  createScreenForIndex(int index) {
    switch (index) {
      case 0:
        return AllRequestsScreen();
      case 1:
        return PlaceRequestScreen();
      case 2:
        return MyRequestsScreen();
      default:
        return AllRequestsScreen();
    }
  }

  @override
  void initState() {
    setState(() {
      _selectedIndex = widget.initialIndex;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: createScreenForIndex(_selectedIndex),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onScreenChange: onScreenChange,
      ),
    );
  }
}
