import 'package:fragrance_for_you/common/widgets/loader.dart';
import 'package:fragrance_for_you/features/admin/models/sales.dart';
import 'package:fragrance_for_you/features/admin/services/admin_services.dart';

import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return totalSales == null
        ? const Loader()
        : Container(
            alignment: Alignment.center,
            child: Text(
              'Total Earning:\$$totalSales',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
