import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linko/src/appcore/widgets/loading.bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage(
      {super.key, required this.uri, this.placeHolderUri, this.title});
  final Uri uri;
  final Uri? placeHolderUri;
  final String? title;
  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController controller;
  bool isLoading = true;
  int progress = 0;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
          child: Stack(
        alignment: Alignment.center,
        children: [
          WebViewWidget(
            controller: controller,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: LoadingBar(
              show: isLoading,
            ),
          ),
        ],
      )),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: null,
      backgroundColor: Theme.of(context).cardColor,
      automaticallyImplyLeading: false,
      title: widget.title == null
          ? null
          : Text(
              widget.title!,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.close,
            ))
      ],
    );
  }

  void initialize() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            progress = progress;
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(widget.uri);
  }
}
