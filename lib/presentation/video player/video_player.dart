import 'package:cowlar_task/presentation/video%20player/video_player_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerView extends ConsumerStatefulWidget {
  const VideoPlayerView({super.key, required this.movieId});
  final int movieId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VideoPlayerViewState();
}

class _VideoPlayerViewState extends ConsumerState<VideoPlayerView> {
  @override
  void initState() {
    super.initState();
    ref.read(videoPlayerViewModelProvider).init(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    VideoPlayerViewModel controller = ref.watch(videoPlayerViewModelProvider);
    return Scaffold(
      body: PopScope(
        canPop: !controller.youtubeController.value.isFullScreen,
        onPopInvoked: (didPop) {
          if (controller.youtubeController.value.isFullScreen) {
            controller.youtubeController.toggleFullScreenMode();
            context.pop();
          }
        },
        child: controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : YoutubePlayer(
                controller: controller.youtubeController,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
                progressColors: const ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
                onEnded: (metaData) {
                  if (controller.youtubeController.value.isFullScreen) {
                    controller.youtubeController.toggleFullScreenMode();
                  }
                  context.pop();
                },
              ),
      ),
    );
  }
}
