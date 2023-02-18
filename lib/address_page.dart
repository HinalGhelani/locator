import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  InAppWebViewController? inAppWebViewController;
  late PullToRefreshController pullToRefreshController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true
    )
  );

  @override
  void initState() {
    super.initState();
    // load();
    pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(
          color: Colors.indigo,
        ),
        onRefresh: () async {
          if (Platform.isAndroid) {
            await inAppWebViewController!.reload();
          } else if (Platform.isIOS) {
            await inAppWebViewController!.loadUrl(
              urlRequest: URLRequest(
                url: await inAppWebViewController!.getUrl(),
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
     List address = ModalRoute.of(context)!.settings.arguments as List;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Address"),
          centerTitle: true,
          backgroundColor: Colors.indigo,
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(address[1]),
          ),
          initialOptions: options,
          onWebViewCreated: (val) {
            inAppWebViewController = val;
          },
          pullToRefreshController: pullToRefreshController,
          onLoadStop: (controller, uri) async{
            await pullToRefreshController.endRefreshing();
          },
        )
    );
  }
}
