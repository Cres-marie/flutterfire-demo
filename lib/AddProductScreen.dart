import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController _prodCodecontroller = TextEditingController();
  TextEditingController _prodNamecontroller = TextEditingController();
  TextEditingController _costPricecontroller = TextEditingController();
  TextEditingController _salePricecontroller = TextEditingController();

  late String _prodCode = '';
  late String _prodName = '';
  late int _costPrice = 0;
  late int _salePrice = 0;

  @override
  Widget build(BuildContext context) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');

    Future<void> addProduct() {
      // Call the user's CollectionReference to add a new product
      return products.add({
        'productCode': _prodCode,
        'productName': _prodName,
        'costPrice': _costPrice,
        'salePrice': _salePrice
      }).then((value) {
        // Clear the form data
        setState(() {
          _prodCodecontroller.clear();
          _prodNamecontroller.clear();
          _costPricecontroller.clear();
          _salePricecontroller.clear();
          // _prodCode = '';
          // _prodName = '';
          // _costPrice = 0;
          // _salePrice = 0;
        });

        print("Product Added");
      }).catchError((error) => print("Failed to add product: $error"));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Product Code',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _prodCodecontroller,
                decoration: InputDecoration(
                  labelText: 'Enter code',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _prodCode = value;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Product Name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _prodNamecontroller,
                decoration: InputDecoration(
                  labelText: 'Enter name of product',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _prodName = value;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Cost Price',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _costPricecontroller,
                decoration: InputDecoration(
                  labelText: 'Enter cost price',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _costPrice = int.parse(value);
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Sales Price',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _salePricecontroller,
                decoration: InputDecoration(
                  labelText: 'Enter sales price',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _salePrice = int.parse(value);
                  });
                },
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      addProduct();
                    },
                    child: Text('Save')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
