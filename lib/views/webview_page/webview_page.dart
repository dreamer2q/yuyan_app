import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' hide WebView;
import 'package:get/get.dart';
import 'package:share_extend/share_extend.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yuyan_app/views/widget/drop_menu_item_widget.dart';

class EmbedWebviewPage extends StatefulWidget {
  final String url;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final bool lockUrl;
  final Function(String) onUrlChanged;
  final Widget header;

  const EmbedWebviewPage({
    Key key,
    this.url,
    this.header,
    this.lockUrl = true,
    this.margin = const EdgeInsets.all(8),
    this.padding = EdgeInsets.zero,
    this.onUrlChanged,
  }) : super(key: key);

  @override
  _EmbedWebviewPageState createState() => _EmbedWebviewPageState();
}

class _EmbedWebviewPageState extends State<EmbedWebviewPage> {
  @override
  Widget build(BuildContext context) {
    debugPrint('webview: ${widget.url}');
    var uri = Uri.tryParse(widget.url);
    var h = uri.queryParameters['height'];
    debugPrint('h ==> $h');
    var height = double.tryParse(h ?? '') ?? Get.width;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      margin: widget.margin,
      padding: widget.padding,
      child: Column(
        children: [
          if (widget.header != null) widget.header,
          SizedBox(
            height: height,
            child: InAppWebView(
              // initialUrl: widget.url,
              initialUrlRequest: URLRequest(
                url: Uri.tryParse(widget.url),
              ),
              onScrollChanged: (c, x, y) {
                debugPrint('onscroll: ($x,$y)');
              },
              onLoadStart: (c, url) {
                if (url.path != widget.url) {
                  if (widget.lockUrl) c.goBack();
                  widget.onUrlChanged?.call(url.path);
                }
                debugPrint('page load!: $url');
              },
              gestureRecognizers: {
                Factory(() => EagerGestureRecognizer()),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WebviewPage extends StatefulWidget {
  final String url;

  const WebviewPage({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  var _url = ''.obs;
  var _title = ''.obs;

  InAppWebViewController _controller;
  bool _forcePopup = false;

  @override
  void initState() {
    super.initState();
    _url.value = widget.url;
    _title.value = widget.url;
    debugPrint('webview: ${widget.url}');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_controller == null || _forcePopup) return true;
        if (await _controller.canGoBack()) {
          _controller.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _forcePopup = true;
              Get.back();
            },
          ),
          title: Obx(
            () => Text(_title.value),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                ShareExtend.share('${_url.value}', 'text');
              },
            ),
            PopupMenuButton(
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: () {
                    launch(_url.value);
                  },
                  child: MenuItemWidget(
                    iconData: Icons.open_in_browser,
                    title: '浏览器打开',
                  ),
                ),
                PopupMenuItem(
                  value: () {
                    _controller.reload();
                  },
                  child: MenuItemWidget(
                    iconData: Icons.refresh,
                    title: '刷新',
                  ),
                ),
              ],
              onSelected: (_) => _?.call(),
            ),
          ],
        ),
        body: Container(
          child: InAppWebView(
            // initialUrl: widget.url,
            initialUrlRequest: URLRequest(
              url: Uri.tryParse(widget.url),
            ),
            onTitleChanged: (c, title) {
              _title.value = title;
            },
            onLoadStart: (c, url) {
              _url.value = url.path;
            },
            onWebViewCreated: (c) {
              _controller = c;
            },
          ),
        ),
      ),
    );
  }
}
