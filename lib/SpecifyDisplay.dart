import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SpecifyDisplay extends StatefulWidget {
  const SpecifyDisplay({super.key});

  @override
  State<SpecifyDisplay> createState() => _SpecifyDisplayState();
}

class _SpecifyDisplayState extends State<SpecifyDisplay> {
  final Stream<QuerySnapshot> _productsStre =
      FirebaseFirestore.instance.collection('products').where('costPrice', isGreaterThan: 20000).snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _productsStre,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['productName']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Product Code: ${data['productCode']}'),
                      Text('Cost Price: ${data['costPrice']}'),
                      Text('Sale Price: ${data['salePrice']}'),
                    ],
                  ),
                );
              }).toList(),
            );
          
        },
      ),

    );
  }
}
