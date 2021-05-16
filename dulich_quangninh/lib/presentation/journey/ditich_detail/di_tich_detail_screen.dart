import 'dart:io';

import 'package:dulichquangninh/common/utils/map_util.dart';
import 'package:dulichquangninh/providers/models/di_tich_model.dart';
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
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
        floatingActionButton: Visibility(
          visible: widget.diTichModel.location != null,
          child: RawMaterialButton(
            onPressed: () {
              MapUtil.openMap(widget.diTichModel.location.lat,
                  widget.diTichModel.location.long);
            },
            elevation: 2.0,
            fillColor: Colors.orange,
            child: Icon(
              Icons.directions,
              color: Colors.white,
              size: 35.0,
            ),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
