import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/productProvider.dart';
import 'package:shop_app/screens/mainPage.dart';
import 'package:shop_app/widgets/product_grid.dart';

class HomePage extends StatefulWidget {
  final ScreenSize size;
  final Size screenSize;
  HomePage(this.size, this.screenSize);
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
    Provider.of<ProductProvider>(context, listen: false)
        .getProducts()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : ProductGrid(widget.size, widget.screenSize),
        ),
      ),
    );
  }
}
