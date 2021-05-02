import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/order.dart';
import 'package:shop_app/provider/cartProvider.dart';
import 'package:shop_app/widgets/order_page_item.dart';

class MyOrderPage extends StatefulWidget {
  static const routeName = "/my-order-page";

  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  bool Loading = false;

  @override
  void initState() {
    setState(() {
      Loading = true;
    });
    Provider.of<Cart>(context, listen: false).getOrder().then((value) {
      setState(() {
        Loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Order> order = Provider.of<Cart>(context).orders;
    return Scaffold(
      appBar: AppBar(),
      body: Loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return OrderPageItem(order[index].pIds, order[index].q,
                      order[index].dateTime, order[index].id);
                },
                itemCount: order.length,
              ),
            ),
    );
  }
}
