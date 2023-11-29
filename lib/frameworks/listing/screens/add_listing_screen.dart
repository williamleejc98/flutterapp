import 'package:flutter/material.dart';
import 'package:inspireui/utils/encode.dart';
import 'package:provider/provider.dart';

import '../../../models/index.dart';
import '../../../services/service_config.dart';
import '../../../widgets/common/webview_inapp.dart';

class AddListingScreen extends StatefulWidget {
  @override
  State<AddListingScreen> createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  @override
  Widget build(BuildContext context) {
    var cookie = Provider.of<UserModel>(context, listen: false).user!.cookie;
    var base64Str = EncodeUtils.encodeCookie(cookie!);
    final addListingUrl = ServerConfig().addListingUrl ??
        '${ServerConfig().url}/add-listing?cookie=$base64Str';

    return WebViewInApp(url: addListingUrl);
  }
}
