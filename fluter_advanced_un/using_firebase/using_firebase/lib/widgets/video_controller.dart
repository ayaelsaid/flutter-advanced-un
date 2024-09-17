import 'package:flutter/material.dart';
import 'package:video_box/video_box.dart';

// class VideoBoxWidget extends StatefulWidget {
//   final String url;
//   const VideoBoxWidget({required this.url, super.key});

//   @override
//   State<VideoBoxWidget> createState() => _VideoBoxWidgetState();
// }

// class _VideoBoxWidgetState extends State<VideoBoxWidget> {
//   late VideoController vc;

//   @override
//   void initState() {
//     vc = VideoController(
//         source: VideoPlayerController.networkUrl(Uri.parse(widget.url)))
//       ..addInitializeErrorListenner((e) {
//         print('[video box init] error: ' + e.message);
//       })
//       ..initialize().then((e) {
//         if (e != null) {
//           print('[video box init] error: ' + e.message);
//         } else {
//           print('[video box init] success');
//         }
//       });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     vc.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 16 / 9,
//       child: VideoBox(controller: vc),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// Ensure you are importing the correct package

class VideoBoxWidget extends StatefulWidget {
  final String url;
  const VideoBoxWidget({required this.url, super.key});

  @override
  _VideoBoxWidgetState createState() => _VideoBoxWidgetState();
}

class _VideoBoxWidgetState extends State<VideoBoxWidget> {
  late VideoController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoController(
        source: VideoPlayerController.networkUrl(Uri.parse(widget.url)))
      ..addInitializeErrorListenner((e) {
        print('[video box init] error: ' + e.message);
      });

    _controller.initialize().then((_) {
      setState(() {}); // Ensure the widget rebuilds to show the video
    }).catchError((e) {
      print('[video box init] error: ' + e.toString());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller
            .value.isPlaying // Replace with an appropriate property or method
        ? Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9, // Default aspect ratio or a fixed ratio
                child: VideoBox(controller: _controller),
              ),
              IconButton(
                icon: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                ),
                onPressed: () {
                  setState(() {
                    _isPlaying = !_isPlaying;
                    if (_isPlaying) {
                      _controller.play();
                    } else {
                      _controller.pause();
                    }
                  });
                },
              ),
            ],
          )
        : const Center(child: CircularProgressIndicator());
  }
}
