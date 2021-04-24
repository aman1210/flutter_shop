//@dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/productProvider.dart';

import '../models/product.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = "/add-product";

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _form = GlobalKey();
  File _image;
  final picker = ImagePicker();
  String selected = "Grocery";
  var isLoading = false;
  Map<String, String> product = {
    'name': '',
    'price': '',
    'description': '',
    'category': '',
    'path': '',
  };

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  submit() async {
    if (!_form.currentState.validate()) return;
    _form.currentState.save();
    setState(() {
      isLoading = true;
    });

    await Provider.of<ProductProvider>(context, listen: false)
        .addProduct(product);
  }

  openDialog(String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('An Error Occured!'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Okay!"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Form(
        key: _form,
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 800),
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        icon: Icon(Icons.shopping_basket_outlined),
                        labelText: 'Name',
                      ),
                      validator: (value) =>
                          value.isEmpty ? "Field is required!" : null,
                      onSaved: (newValue) {
                        product['name'] = newValue;
                      },
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        icon: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            '₹',
                            style: TextStyle(
                                fontSize: 28, color: Colors.grey.shade600),
                          ),
                        ),
                        labelText: 'Price',
                      ),
                      validator: (value) =>
                          value.isEmpty ? "Field is required!" : null,
                      onSaved: (newValue) => product['price'] = newValue,
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        icon: Icon(Icons.note_outlined),
                        labelText: 'Description',
                      ),
                      validator: (value) =>
                          value.isEmpty ? "Field is required!" : null,
                      onSaved: (newValue) => product['description'] = newValue,
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: DropdownButtonFormField(
                      items: [
                        DropdownMenuItem(
                          child: Text('Grocery'),
                          value: 'Grocery',
                        ),
                        DropdownMenuItem(
                          child: Text('Mobile'),
                          value: 'Mobile',
                        ),
                        DropdownMenuItem(
                          child: Text('Fashion'),
                          value: 'Fashion',
                        ),
                        DropdownMenuItem(
                          child: Text('Electronics'),
                          value: 'Electronics',
                        ),
                        DropdownMenuItem(
                          child: Text('Home'),
                          value: 'Home',
                        ),
                        DropdownMenuItem(
                          child: Text('Appliance'),
                          value: 'Appliance',
                        ),
                        DropdownMenuItem(
                          child: Text('Beauty, Toy & More'),
                          value: 'Beauty, Toy & More',
                        ),
                      ],
                      value: selected,
                      onChanged: (value) {
                        setState(() {
                          selected = value.toString();
                        });
                      },
                      onSaved: (newValue) => product['category'] = newValue,
                      decoration: InputDecoration(
                        icon: Icon(Icons.category_outlined),
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          child: _image == null
                              ? Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.grey,
                                  size: 50,
                                )
                              : Image.file(
                                  _image,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: getImage,
                              child: Text('Add Image'),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                            Text('Max size: 2MB')
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_image == null) {
                          openDialog('Image not Selected!');
                        }
                        product['path'] = _image.path;
                        submit();
                      },
                      child: Text('Submit'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).accentColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}