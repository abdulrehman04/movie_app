import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final videoPlayerViewModelProvider = ChangeNotifierProvider((ref) {
  return VideoPlayerViewModel();
});

class VideoPlayerViewModel extends ChangeNotifier {}
