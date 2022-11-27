import 'package:fragrance_for_you/common/widgets/loader.dart';
import 'package:fragrance_for_you/constants/global_variables.dart';
import 'package:fragrance_for_you/features/account/widgets/single_product.dart';
import 'package:fragrance_for_you/features/admin/services/admin_services.dart';
import 'package:fragrance_for_you/features/order_details/screens/order_details.dart';
import 'package:fragrance_for_you/models/order.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int cout = 1;
    return orders == null
        ? const Loader()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: orders!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final orderData = orders![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      OrderDetailScreen.routeName,
                      arguments: orderData,
                    );
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: GlobalVariables.selectednavBarColor,
                        child: Text(
                          '${cout++}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 140,
                        width: 100,
                        child: SingleProduct(
                          image: orderData.products[0].images[0],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
