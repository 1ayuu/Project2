import 'package:fragrance_for_you/common/widgets/loader.dart';
import 'package:fragrance_for_you/features/home/services/home_services.dart';
import 'package:fragrance_for_you/features/product_details/screens/product_details_screen.dart';
import 'package:fragrance_for_you/models/product.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  List<Product>? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen(int index) {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product![index],
    );
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.isEmpty
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding:
                        const EdgeInsets.only(left: 10, top: 15, bottom: 10),
                    child: const Text(
                      'New Arrivals',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    navigateToDetailScreen(index);
                                  },
                                  //   child: Image.network(
                                  //     product![index].images[0],
                                  //     height: 235,
                                  //     fit: BoxFit.fitHeight,
                                  //   ),
                                  // ),
                                  // Text(product![index].name),
                                  // Text(product![index].price.toString()),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Container(
                                      height: 300,
                                      width: 214,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF5BFDC)
                                            .withOpacity(0.35),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(children: <Widget>[
                                          Image.network(
                                            product![index].images[0],
                                            height: 200,
                                            fit: BoxFit.fitHeight,
                                          ),
                                          const SizedBox(
                                            height: 17,
                                          ),
                                          Text(
                                            product![index].name,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Rs${product![index].price.toString()}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'All Products',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  navigateToDetailScreen(index);
                                },
                                //   child: Image.network(
                                //     product![index].images[0],
                                //     height: 235,
                                //     fit: BoxFit.fitHeight,
                                //   ),
                                // ),
                                // Text(product![index].name),
                                // Text(product![index].price.toString()),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        height: 76,
                                        width: 83,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF5BFDC)
                                              .withOpacity(0.24),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Image.network(
                                          product![index].images[0],
                                          height: 200,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      Text(
                                        product![index].name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        'Rs${product![index].price.toString()}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  // Image.network(
                  //   product!.images[0],
                  //   height: 235,
                  //   fit: BoxFit.fitHeight,
                  // ),
                  // Container(
                  //   padding: const EdgeInsets.only(left: 15),
                  //   alignment: Alignment.topLeft,
                  //   child: const Text(
                  //     '\$100',
                  //     style: TextStyle(fontSize: 18),
                  //   ),
                  // ),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: product!.images
                  //         .map(
                  //           (e) => Image.network(
                  //             e,
                  //             fit: BoxFit.fitWidth,
                  //             width: 100,
                  //             height: 100,
                  //           ),
                  //         )
                  //         .toList(),
                  //   ),
                  // ),
                ],
              );
  }
}
