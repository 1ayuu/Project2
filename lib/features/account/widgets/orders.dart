import 'dart:convert';

import 'package:fragrance_for_you/common/widgets/loader.dart';
import 'package:fragrance_for_you/constants/global_variables.dart';
import 'package:fragrance_for_you/features/account/services/account_services.dart';
import 'package:fragrance_for_you/features/order_details/screens/order_details.dart';
import 'package:fragrance_for_you/models/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int count = 1;
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: const Text(
                      'Your Orders',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 15,
                    ),
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        color: GlobalVariables.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.black12.withOpacity(0.08),
                height: 1,
              ),
              // display orders

              ListView(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  children: [
                    Container(
                      height: 110.0 * (orders!.length + 1),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: orders!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                OrderDetailScreen.routeName,
                                arguments: orders![index],
                              );
                            },

                            // SingleProduct(
                            //   image: orders![index].products[0].images[0],
                            // ),

                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, left: 15.0, bottom: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Container(

                                  //   child: Image.network(
                                  //     orders![index].products[0].images[0],
                                  //     height: 200,
                                  //     fit: BoxFit.fitHeight,
                                  //   ),
                                  // ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15.0, bottom: 10),
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Color(0xFFF5BFDC)
                                              .withOpacity(0.24),
                                          child: Text(
                                            '${count++}',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 100,
                                        width: 83,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF5BFDC)
                                              .withOpacity(0.24),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Image.network(
                                          orders![index].products[0].images[0],
                                          height: 200,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(orders![index]
                                                .products[0]
                                                .name),
                                            Text(
                                                'Rs${orders![index].products[0].price}')
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
            ],
          );
  }
}
