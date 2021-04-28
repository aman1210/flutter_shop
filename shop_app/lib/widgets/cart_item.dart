import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shop_app/models/cart.dart';
import 'package:shop_app/widgets/cart_item_button.dart';
import 'package:shop_app/widgets/quantity_control.dart';

class GenCartItem extends StatelessWidget {
  final CartItem cartItem;

  GenCartItem(this.cartItem);

  @override
  Widget build(BuildContext context) {
    Widget image = Container(
      padding: const EdgeInsets.all(8),
      height: 120,
      child: Center(
        child: CachedNetworkImage(
          imageUrl: cartItem.image,
        ),
      ),
    );
    Widget totalPricrPerItem = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "₹ ${cartItem.price * cartItem.quantity}",
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
    Widget itemTitle = Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Center(
        child: Text(
          cartItem.title,
          style: GoogleFonts.poppins(),
          textAlign: TextAlign.start,
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: Container(
          // padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              generateRow(itemTitle, image, 3, 2),
              generateRow(
                  totalPricrPerItem, QuantityControl(cartItem: cartItem), 3, 2),
              generateRow(
                CartItemButton(title: 'Save for later', function: () {}),
                CartItemButton(title: 'Remove', function: () {}),
                1,
                1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row generateRow(Widget item1, Widget item2, int? flex1, int? flex2) {
    return Row(
      children: [
        Flexible(
          child: item1,
          flex: flex1!,
          fit: FlexFit.tight,
        ),
        Flexible(
          child: item2,
          flex: flex2!,
        )
      ],
    );
  }
}
