import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dulichquangninh/common/injector/get_it.dart';
import 'package:dulichquangninh/presentation/journey/widgets/loader/loader_widget.dart';
import 'package:dulichquangninh/presentation/journey/widgets/space_widgets/vertical_space_widget.dart';
import 'package:dulichquangninh/presentation/theme/theme_text.dart';
import 'package:dulichquangninh/providers/data_sources/remote/dac_san_remote_provider.dart';
import 'package:dulichquangninh/providers/models/dac_san_model.dart';
import 'package:dulichquangninh/providers/models/phi_vat_the_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dulichquangninh/common/constants/firebase_constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:photo_view/photo_view.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class PhiVatTheDetailScreen extends StatefulWidget {
  final PhiVatTheModel item;

  PhiVatTheDetailScreen(this.item);

  @override
  _PhiVatTheDetailScreenState createState() => _PhiVatTheDetailScreenState();
}

class _PhiVatTheDetailScreenState extends State<PhiVatTheDetailScreen> {

  final _refHtmlStorage =
      FirebaseStorage.instance.ref().child(FirebaseConstants.htmlStorage);

  String htmlData = '';
  bool _isLoading = true;
  final _dacSanSource = locator.get<DacSanSource>();

  YoutubePlayerController? _ytbController;

  @override
  void initState() {
    super.initState();
    if (widget.item.video != null) {
      _ytbController = YoutubePlayerController.fromVideoId(
        videoId: YoutubePlayerController.convertUrlToId(
                widget.item.video ?? '') ??
            '',
        autoPlay: true,
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          showVideoAnnotations: true,
          enableCaption: true,
          origin: 'https://www.youtube-nocookie.com',
          mute: false,
          loop: false,
          userAgent:
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36',
        ),
      );
    }

    _getData();
  }

  void _getData() async {
    print('>> type: ${widget.item.type}');
    print('>> tag: ${widget.item.tag}');
    final path =
        '${_refHtmlStorage.fullPath}/${widget.item.type}/${widget.item.tag}.html';

    print('>> path: $path');
    final data = await _refHtmlStorage
        .child(widget.item.type!)
        .child(widget.item.tag!)
        .child('${widget.item.tag}.html')
        .getData();
    setState(() {
      _isLoading = false;
      htmlData = utf8.decode(data!);
      // print(htmlData);
    });
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    if (_ytbController != null) _ytbController!.pauseVideo();
    super.deactivate();
  }

  @override
  void dispose() {
    if (_ytbController != null) _ytbController!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.name ?? ''),
      ),
      body: SafeArea(
        child: _isLoading
            ? LoaderWidget()
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _headerWidget(),
                    _htmlWidget(),
                    // CommentComponent(
                    //   idPost: widget.dacSanModel.id,
                    //   streamComments: _dacSanSource
                    //       .streamCommentsWithID(widget.dacSanModel.id),
                    //   handleComment: (String content) {
                    //     _dacSanSource.addNewCommentToDB(
                    //         widget.dacSanModel.id,
                    //         Comment(
                    //             uid: _authCubit.user.profile.id,
                    //             fullName: _authCubit.user.profile.fullName,
                    //             content: content));
                    //   },
                    // )
                  ],
                ),
              ),
      ),
    );
  }

  Widget _youtubePlayer() {
    return YoutubePlayerControllerProvider(
      controller: _ytbController!,
      child: Builder(
        builder: (context) => YoutubePlayer(
          controller: _ytbController!,
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
  Widget _imageSmall() {
    final images = widget.item.images;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '*Một số hình ảnh về ${widget.item.name}:',
                style: ThemeText.getDefaultTextTheme()
                    .bodyText1!
                    .copyWith(fontSize: 22.sp),
              )),
          VerticalSpace.init4(),
          SizedBox(
            height: 60.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List<Widget>.generate(
                  images?.length ?? 0,
                  (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 200.w,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: _aImage(
                              images![index],
                              widget.item.tag ??
                                  '' + "img" + index.toString())))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _aImage(String url, String tagImage) {
    // print("tag: ${tagImage}");
    return Hero(
      tag: tagImage,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HeroPhotoViewRouteWrapper(
                imageProvider: NetworkImage(url),
                tag: tagImage,
              ),
            ),
          );
        },
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _youtubeAndImagesWidget() {
    return Column(
      children: [
        _youtubePlayer(),
        _imageSmall(),
      ],
    );
  }

  Widget _headerWidget() {
    Widget child;

    if (widget.item.video != null) {
      if (widget.item.images!.isNotEmpty) {
        child = _youtubeAndImagesWidget();
      } else {
        child = _youtubePlayer();
      }
    } else {
      final len = widget.item.images!.length;
      if (len == 0) {
        child = SizedBox();
      } else if (len == 1) {
        child = _aImage(
            widget.item.images![0], '${widget.item.tag}img1');
      } else {
        child = _imageSmall();
      }
    }

    return child;
  }

  Widget _htmlWidget() {
    final bodyStyle = Style(fontSize: FontSize(26.sp));
    final bodyBoldStyle =
        Style(fontSize: FontSize(26.sp), fontWeight: FontWeight.bold);
    return Card(
      child: Html(
        data: htmlData ?? '',
        style: {
          "sup": Style(fontSize: FontSize(16.sp)),
          'p': bodyStyle,
          'strong': bodyBoldStyle,
        },
      ),
    );
  }
}

class HeroPhotoViewRouteWrapper extends StatelessWidget {
  const HeroPhotoViewRouteWrapper({
    required this.imageProvider,
    this.backgroundDecoration,
    this.minScale,
    required this.tag,
    this.maxScale,
  });

  final ImageProvider imageProvider;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          children: [
            PhotoView(
              imageProvider: imageProvider,
              backgroundDecoration: backgroundDecoration,
              minScale: minScale,
              maxScale: maxScale,
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
