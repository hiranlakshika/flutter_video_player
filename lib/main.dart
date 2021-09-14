import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video/video_app.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('GO'),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VideoApp())),
        ),
      ),
    );
  }
}

class ChewieVideo extends StatefulWidget {
  ChewieVideo({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ChewieVideoState createState() => _ChewieVideoState();
}

class _ChewieVideoState extends State<ChewieVideo> {
  late final VideoPlayerController videoPlayerController;
  late final bool looping;
  late final bool autoplay;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network('https://bravecsdev.blob.core.windows.net/joulius/video/joulius_introduction.mp4');
    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoInitialize: true,
      autoPlay: true,
      fullScreenByDefault: true,
      looping: false,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Chewie(
          controller: _chewieController,
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Future<bool> _onWillPop() async {
    _chewieController.pause();
    return true;
  }
}
