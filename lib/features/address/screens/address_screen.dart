import 'package:fragrance_for_you/constants/utils.dart';
import 'package:fragrance_for_you/features/address/services/address_services.dart';
import 'package:fragrance_for_you/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
// import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:fragrance_for_you/common/widgets/custom_textfield.dart';
import 'package:fragrance_for_you/constants/global_variables.dart';
import 'package:fragrance_for_you/providers/user_provider.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../../../common/widgets/bottom_bar.dart';
import '../../cart/widgets/cart_subtotal.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";
  String contactToBeUsed = "";
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  late final config;

  @override
  void initState() {
    super.initState();
    config = PaymentConfig(
      amount:
          100 * (int.parse(widget.totalAmount)), // Amount should be in paisa
      productIdentity: 'dell-g5-g5510-2021',
      productName: 'Dell G5 G5510 2021',
      productUrl: 'https://www.khalti.com/#/bazaar',
      additionalData: {
        // Not mandatory; can be used for reporting purpose
        'vendor': 'Khalti Bazaar',
      },
      mobile:
          '9800000001', // Not mandatory; can be used to fill mobile number field
      mobileReadOnly:
          true, // Not mandatory; makes the mobile field not editable
    );

    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    addressController.dispose();
    contactController.dispose();
    // flatBuildingController.dispose();
    // areaController.dispose();
    // pincodeController.dispose();
    // cityController.dispose();
  }

  // void onApplePayResult(res) {
  //   if (Provider.of<UserProvider>(context, listen: false)
  //       .user
  //       .address

  //       .isEmpty) {
  //     addressServices.saveUserAddress(
  //         context: context, address: addressToBeUsed);
  //   }
  //   addressServices.placeOrder(
  //     context: context,
  //     address: addressToBeUsed,
  //     totalSum: double.parse(widget.totalAmount),
  //   );
  // }

  // void onGooglePayResult(res) {
  //   if (Provider.of<UserProvider>(context, listen: false)
  //       .user
  //       .address
  //       .isEmpty) {
  //     addressServices.saveUserAddress(
  //         context: context, address: addressToBeUsed);
  //   }
  //   addressServices.placeOrder(
  //     context: context,
  //     address: addressToBeUsed,
  //     totalSum: double.parse(widget.totalAmount),
  //   );
  // }

  // void payPressed(String addressFromProvider) {
  //   addressToBeUsed = "";

  //   bool isForm = addressController.text.isNotEmpty || contactController.text.isNotEmpty

  //   if (isForm) {
  //     if (_addressFormKey.currentState!.validate()) {
  //       addressToBeUsed =
  //           '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
  //     } else {
  //       throw Exception('Please enter all the values!');
  //     }
  //   } else if (addressFromProvider.isNotEmpty) {
  //     addressToBeUsed = addressFromProvider;
  //   } else {
  //     showSnackBar(context, 'ERROR');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    // final routerDelegate = HomeScreen();
    return KhaltiScope(
        publicKey: "test_public_key_2e5b9557e080405bbd8a7091ba5d616d",
        builder: (context, navigatorKey) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // routerDelegate: routerDelegate,
            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],

            // KhaltiScope(
            // publicKey: "test_public_key_2e5b9557e080405bbd8a7091ba5d616d",
            // builder: (context, navigatorKey) {
            //   return MaterialApp(
            //     navigatorKey: navigatorKey,
            //     supportedLocales: const [
            //       Locale('en', 'US'),
            //       Locale('ne', 'NP'),
            //     ],
            //     localizationsDelegates: const [
            //       KhaltiLocalizations.delegate,

            //   ],

            home: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: AppBar(
                  title: Text("Checkout"),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.black,
                  ),
                  backgroundColor: GlobalVariables.selectednavBarColor,
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if (address.isNotEmpty)
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: GlobalVariables.secondaryColor,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  address,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'OR',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      Form(
                        key: _addressFormKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: addressController,
                              hintText: 'Enter the Address',
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: contactController,
                              hintText: 'Contact Number',
                            ),
                            const SizedBox(height: 10),
                            const CartSubtotal(),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 15,
                              ),
                              child: SizedBox(
                                height: 50,
                                width: 200,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          GlobalVariables.selectednavBarColor,
                                    ),
                                    onPressed: () {
                                      if (_addressFormKey.currentState!
                                          .validate()) {
                                        addressServices.placeOrder(
                                          context: context,
                                          address: addressController.text,
                                          totalSum:
                                              double.parse(widget.totalAmount),
                                          contact: contactController.text,
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'Cash on Delivery',
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),

                      KhaltiButton(
                        config: config,
                        preferences: const [
                          PaymentPreference.khalti,
                          PaymentPreference.eBanking,
                        ],
                        onSuccess: (PaymentSuccessModel) {
                          // AddressServices().placeOrder(context: context, address: 'pokhara', totalSum: 20);
                        },
                        onFailure: (PaymentFailureModel) {},
                      ),

                      // const SizedBox(height: 10),

                      // const SizedBox(
                      //   height: 10,
                      // )
                      // GooglePayButton(
                      //   onPressed: () => payPressed(address),
                      //   paymentConfigurationAsset: 'gpay.json',
                      //   onPaymentResult: onGooglePayResult,
                      //   paymentItems: paymentItems,
                      //   height: 50,
                      //   style: GooglePayButtonStyle.black,
                      //   type: GooglePayButtonType.buy,
                      //   margin: const EdgeInsets.only(top: 15),
                      //   loadingIndicator: const Center(
                      //     child: CircularProgressIndicator(),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
