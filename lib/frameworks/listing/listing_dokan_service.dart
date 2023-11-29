import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../services/base_services.dart';
import '../vendor/vendor_listing_mixin.dart';

mixin ListingBaseMixin {
  Widget renderVendorOrderForDokan(
          BuildContext context, SettingItemStyle? cardStyle) =>
      const SizedBox();

  BaseServices? buildDokanService({
    required String domain,
    String? blogDomain,
    String? consumerSecret,
    String? consumerKey,
  }) =>
      null;
}

class ListingDokanService with ListingBaseMixin, VendorListingMixin {
  static final ListingDokanService _instance = ListingDokanService._internal();

  factory ListingDokanService() => _instance;

  ListingDokanService._internal();
}
