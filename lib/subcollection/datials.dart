import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_admin/subcollection/provider.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<ProviderPage>(context, listen: false).uid;
    var stream = FirebaseFirestore.instance
        .collection('buy-products')
        .doc(uid)
        .collection('items');

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 247, 247),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 239, 247, 247),
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, 
          ),
          title: Text(
            'Sargytlar',
            style: TextStyle(color: Colors.black, fontSize: 24),
          )),
      body: StreamBuilder(
          stream: stream.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: Text("wait please"));
              default:
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.length == 0) {
                    return Center(child: Text('no found'));
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          String name = snapshot.data!.docs[index]['name'];
                          String images =
                              snapshot.data!.docs[index]['images'][0];
                          int price = snapshot.data!.docs[index]['price'];
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10, top: 10),
                            child: Container(
                              height: 90,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: Center(
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        10), // Image border
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(40),
                                      child: Image.network(
                                        "$images",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  title: Text('$name',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                  subtitle: Text(
                                    "$price TMT",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
                          );

                          // Card(child: Text('$name - $price'));
                        });
                  }
                } else {
                  return Center(child: Text('errrorrr'));
                }
            }
          }),
    );
  }
}





// StreamBuilder(
//                                 stream: FirebaseFirestore.instance.collection('buy-products').doc(id).collection('items').snapshots(),
//                                 builder: (BuildContext context,
//                                     AsyncSnapshot<QuerySnapshot> snap) {
//                                   switch (snap.connectionState) {
//                                     case ConnectionState.none:
//                                     case ConnectionState.waiting:
//                                       return center('wait pleas...');
//                                     default:
//                                       if (snap.hasData) {
//                                         if (snap.data!.docs.length == 0) {
//                                           return center('No found');
//                                         } else {
//                                           return ListView.builder(
//                                             shrinkWrap: true,
//                                               physics: ScrollPhysics(),
//                                               itemCount:
//                                                   snap.data!.docs.length,
//                                               itemBuilder:
//                                                   (BuildContext context,
//                                                       int index) {
//                                                 String id = snap
//                                                     .data!.docs[index].id;
//                                                 return GestureDetector(
//                                                     onTap: (() {
//                                                       onTAp.uidSetter(id);
//                                                       Navigator.push(
//                                                           context,
//                                                           MaterialPageRoute(
//                                                               builder: (_) =>
//                                                                   Details(
//                                                                       index)));
//                                                     }),
//                                                     child: Card(
//                                                         child: Text(
//                                                       '$id',
//                                                       style: TextStyle(
//                                                           fontSize: 30),
//                                                     )));
//                                               });
//                                         }
//                                       } else {
//                                         return center('errrorrr');
//                                       }
//                                   }
//                                 });