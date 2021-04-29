import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/provider/cartProvider.dart';
import 'package:shop_app/widgets/cart_item.dart';
import 'package:shop_app/widgets/cart_total.dart';

class CartPage extends StatelessWidget {
  static const routeName = "/cart-page";
  @override
  Widget build(BuildContext context) {
    var list = Provider.of<Cart>(context).items;
    var cartItems = list.values.toList();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Container(
        constraints: BoxConstraints(maxWidth: 960),
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...cartItems.map((cartItem) => GenCartItem(cartItem)).toList(),
              if (cartItems.length > 0) GenTotalDetail(),
              if (cartItems.length == 0)
                Container(
                  height: size.height - 100,
                  width: size.width,
                  child: Center(
                    child: Text(
                      'Cart is Empty!',
                      style: GoogleFonts.poppins(fontSize: 28),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
      bottomNavigationBar: cartItems.length == 0
          ? null
          : ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart_outlined),
              label: Container(
                child: Center(
                  child: Text(
                    'Place Order!',
                    style: GoogleFonts.poppins(),
                  ),
                ),
                height: 60,
              ),
            ),
    );
  }
}
