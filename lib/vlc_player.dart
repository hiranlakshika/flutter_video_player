import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class VLCPlayer extends StatefulWidget {
  const VLCPlayer({Key? key}) : super(key: key);

  @override
  _VLCPlayerState createState() => _VLCPlayerState();
}

class _VLCPlayerState extends State<VLCPlayer> {
  late VlcPlayerController _videoPlayerController;

  Future<void> initializePlayer() async {}

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VlcPlayerController.network(
      'https://bravecsdev.blob.core.windows.net/joulius/video/joulius_introduction.mp4',
      hwAcc: HwAcc.FULL,
      autoPlay: false,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
    await _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: VlcPlayer(
            controller: _videoPlayerController,
            aspectRatio: 16 / 9,
            placeholder: Center(child: CircularProgressIndicator()),
          ),
        ));
  }
}
