import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDetailsViewModelProvider = ChangeNotifierProvider((ref) {
  return MovieDetailsViewModel();
});

class MovieDetailsViewModel extends ChangeNotifier {}
