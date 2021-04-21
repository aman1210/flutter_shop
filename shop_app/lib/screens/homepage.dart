import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/productProvider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isLoading = false;
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<ProductProvider>(context).getProducts().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: _isLoading ? CircularProgressIndicator() : Text('Welcome'),
      ),
    );
  }
}
