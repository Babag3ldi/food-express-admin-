import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'const/AppColors.dart';

class Products extends StatefulWidget {
  var doc;
  Products({this.doc});
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 247, 247),
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('buy-products')
            .doc("doc")
            .collection("items")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something is wrong"),
            );
          }

          return ListView.builder(
              itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];

                return Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                  child: Container(
                    height: 90.h,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Center(
                      child: ListTile(
                        leading: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Image.network(
                              "${doc['images'][1]}",
                              fit: BoxFit.cover,
                            )),
                        title: Text(doc['name'],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        subtitle: Text(
                          "${doc['price']} TMT",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        trailing: GestureDetector(
                          child: const CircleAvatar(
                            backgroundColor: AppColors.deep_orange,
                            child: Icon(
                              Icons.remove_circle,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection('buy-products')
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .collection("items")
                                .doc(doc.id)
                                .delete();
                          },
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      )),
    );
  }
}
