import 'package:cowlar_task/presentation/video%20player/video_player_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoPlayerView extends ConsumerWidget {
  const VideoPlayerView({super.key, required this.videoUrl});
  final String videoUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    VideoPlayerViewModel controller = ref.watch(videoPlayerViewModelProvider);
    return Container();
  }
}
