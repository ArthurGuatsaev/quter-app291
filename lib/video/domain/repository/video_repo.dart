import 'dart:async';

import 'package:quotex291/loading/domain/model/loading_model.dart';

import '../../data/video_api.dart';
import '../models/video_model.dart';

class VideoRepository {
  List<VideoModel>? videos;
  Future<List<VideoModel>> getVideo(
      {StreamController<VLoading>? controller}) async {
    videos = await ApiClentVideo.getVideo();
    controller?.add(VLoading.video);
    return videos ?? [];
  }
}
