import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String label;

  const WebViewScreen({
    super.key,
    required this.url,
    required this.label,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  double _loadingProgress = 0;
  final GlobalKey _webViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _loadingProgress = 0;
            });
          },
          onProgress: (int progress) {
            setState(() {
              _loadingProgress = progress / 100;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _loadingProgress = 1;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  Future<void> _refreshWebView() async {
    _controller.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FutureBuilder(
          future: _controller.canGoBack(),
          builder: (context, snapshot) {
            if (snapshot.data == true) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  if (snapshot.hasData) {
                    _controller.goBack();
                  }
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
        title: Text(widget.label),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: _loadingProgress < 1.0
              ? LinearProgressIndicator(
                  value: _loadingProgress,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshWebView,
          child: WebViewWidget(
            key: _webViewKey,
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
