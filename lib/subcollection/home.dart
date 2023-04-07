import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_admin/subcollection/datials.dart';
import 'package:food_delivery_admin/subcollection/provider.dart';
import 'package:provider/provider.dart';

import '../const/AppColors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var stream =
        FirebaseFirestore.instance.collection('buy-products').snapshots();
    var onTAp = Provider.of<ProviderPage>(context, listen: false);
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 239, 247, 247),
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 239, 247, 247),
            centerTitle: true,
            elevation: 0,
            title: Text(
              'Food express Admin',
              style: TextStyle(color: Colors.black, fontSize: 24),
            )),
        body: StreamBuilder(
            stream: stream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return center('Please wait...');
                default:
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.length == 0) {
                      return center('No found');
                    } else {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          controller: _controller,
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            String id = snapshot.data!.docs[index].id;
                            DocumentSnapshot doc = snapshot.data!.docs[index];
                            // String address = snapshot.data!.docs[index]['address'];
                            // String number = snapshot.data!.docs[index]['number'];
                            return GestureDetector(
                              onTap: (() {
                                onTAp.uidSetter(id);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Details()));
                              }),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        "Address:  ${doc['address'] ?? ''} ",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      subtitle: Text(
                                          "Phone number: ${doc['number'] ?? ''}"),
                                      leading: CircleAvatar(
                                          radius: 20,
                                          backgroundColor:
                                              AppColors.deep_orange,
                                          child: Text(
                                            "${index + 1}",
                                            style: TextStyle(fontSize: 22),
                                          )),
                                      trailing: GestureDetector(
                                        child: const CircleAvatar(
                                          backgroundColor:
                                              AppColors.deep_orange,
                                          child: Icon(
                                            Icons.remove_circle,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection('buy-products')
                                              .doc(doc.id)
                                              // .collection("items")
                                              // .doc(doc.id)
                                              .delete();
                                        },
                                      ),
                                    )),
                              ),
                            );
                          });
                    }
                  } else {
                    return center('errrorrr');
                  }
              }
            }));
  }

  Container center(String text) {
    return Container(
      alignment: Alignment.center,
      child: Text(text),
    );
  }
}
