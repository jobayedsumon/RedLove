import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/SingleRequest.dart';
import '../includes/CustomAppBar.dart';

final db = FirebaseFirestore.instance;

class AllRequestsScreen extends StatefulWidget {
  const AllRequestsScreen({super.key});

  @override
  State<AllRequestsScreen> createState() => _AllRequestsScreenState();
}

class _AllRequestsScreenState extends State<AllRequestsScreen> {
  bool isLoading = true;
  List requests = [];

  @override
  void initState() {
    super.initState();
    getRequests();
  }

  Future getRequests() async {
    try {
      var query =
          await db.collection('bloodRequests').orderBy('createdAt').get();
      var data = query.docs.map((doc) => doc.data()).toList();
      setState(() {
        requests = data;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          await getRequests();
          return;
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        '${requests.length}',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Total Blood Requests',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 1.0,
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : requests.length > 0
                      ? Column(
                          children: requests
                              .map((request) => SingleRequest(request: request))
                              .toList(),
                        )
                      : Center(
                          child: Text('No Blood Request for now!'),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
