import 'dart:async';
import 'dart:io';

import 'package:dulichquangninh/providers/models/di_tich_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DiTichDetailScreen extends StatefulWidget {
  final DiTichModel diTichModel;

  DiTichDetailScreen(this.diTichModel);

  @override
  _DiTichDetailScreenState createState() => _DiTichDetailScreenState();
}

class _DiTichDetailScreenState extends State<DiTichDetailScreen> {
  WebViewController _controller;
  YoutubePlayerController _ytbController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    if (widget.diTichModel.video != null)
      _ytbController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.diTichModel.video),
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: true,
        ),
      );
  }

  void listener() {
    if (mounted && !_ytbController.value.isFullScreen) {}
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    if (_ytbController != null) _ytbController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    if (_ytbController != null) _ytbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.diTichModel.tag,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.diTichModel.name),
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
//            Container(
//              height: 300,
//              color: Colors.red,
//            ),
              widget.diTichModel.video != null
                  ? Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: YoutubePlayer(
                        controller: _ytbController,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.amber,
                        progressColors: ProgressBarColors(
                          playedColor: Colors.amber,
                          handleColor: Colors.amberAccent,
                        ),
                        onReady: () {
                          _ytbController.addListener(listener);
                        },
                      ),
                    )
                  : widget.diTichModel.images.isNotEmpty
                      ? Image.network(
                          widget.diTichModel.images[0],
                          fit: BoxFit.cover,
                        )
                      : SizedBox(),
              Expanded(
                child: WebView(
                  initialUrl: widget.diTichModel.html ?? 'https://flutter.dev',
                  javascriptMode: JavascriptMode.disabled,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller = webViewController;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
