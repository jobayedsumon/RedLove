import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:redlove/helpers/alerts.dart';
import 'package:redlove/helpers/functions.dart';
import '../components/UserAvatar.dart';
import '../includes/CustomAppBar.dart';

final db = FirebaseFirestore.instance;

final bloodGroups = [
  'A+',
  'A-',
  'B+',
  'B-',
  'AB+',
  'AB-',
  'O+',
  'O-',
];

class PlaceRequestScreen extends StatefulWidget {
  final profileData;
  final getProfileData;

  const PlaceRequestScreen({super.key, this.profileData, this.getProfileData});

  @override
  State<PlaceRequestScreen> createState() => _PlaceRequestScreenState();
}

class _PlaceRequestScreenState extends State<PlaceRequestScreen> {
  var user = {};
  String selectedBloodGroup = '';

  var nameController = new TextEditingController();
  var phoneController = new TextEditingController();
  var reasonController = new TextEditingController();
  var locationController = new TextEditingController();
  var bloodGroupController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getUser().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  void placeBloodRequest() async {
    try {
      var data = {
        'contactName': nameController.text,
        'contactPhone': phoneController.text,
        'reason': reasonController.text,
        'location': locationController.text,
        'bloodGroup': selectedBloodGroup,
        'userId': user['id'],
        'createdAt': DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now()),
      };

      await db.collection('bloodRequests').add(data);
      showSuccess(context, 'Request Placed Successfully');

      nameController.clear();
      phoneController.clear();
      reasonController.clear();
      locationController.clear();
      bloodGroupController.clear();
    } catch (e) {
      showError(context, 'Request Failed');
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    reasonController.dispose();
    locationController.dispose();
    bloodGroupController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    child: Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            UserAvatar(
                              image: user['image'],
                              name: user['name'],
                            ),
                            Text(
                              "${user['name'] ?? ''}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Card(
                  elevation: 5.0,
                  child: Container(
                    width: double.infinity,
                    // height: MediaQuery.of(context).size.height * 0.4,
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 30),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            DropdownMenu<String>(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.8,
                              onSelected: (value) {
                                setState(() {
                                  selectedBloodGroup = value!;
                                });
                              },
                              hintText: 'Which blood group do you need?',
                              controller: bloodGroupController,
                              dropdownMenuEntries: bloodGroups
                                  .map(
                                    (bloodGroup) =>
                                    DropdownMenuEntry<String>(
                                      label: bloodGroup,
                                      value: bloodGroup,
                                    ),
                              )
                                  .toList(),
                            ),
                            SizedBox(height: 15.0),
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: 'Contact Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                // isDense: true,
                                isDense: true,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            TextField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                labelText: 'Contact Phone',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                isDense: true,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            TextField(
                              controller: reasonController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: 'Reason for Blood (Patient Details)',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                isDense: false,
                                //disable
                              ),
                            ),
                            SizedBox(height: 15.0),
                            TextField(
                              controller: locationController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: 'Location to Donate',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                isDense: false,
                                //disable
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    elevation: 5.0,
                  ),
                  onPressed: () {
                    placeBloodRequest();
                  },
                  child: Text('Request', style: TextStyle(fontSize: 20.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
