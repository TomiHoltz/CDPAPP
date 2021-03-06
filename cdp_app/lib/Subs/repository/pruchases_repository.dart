import 'package:cdp_app/Subs/repository/revenue_cat_api.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchasesRepository {
  final RevenueCatApi _revenueCatApi = RevenueCatApi();

  Future<void> setUp() async => _revenueCatApi.setUp();

  Future<void> makingSubPurchase(
          Package packageToPurchase, BuildContext context) async =>
      _revenueCatApi.makingSubPurchase(packageToPurchase, context);

  Future<void> checkSubStatus(BuildContext context) async =>
      _revenueCatApi.checkSubStatus(context);
}
