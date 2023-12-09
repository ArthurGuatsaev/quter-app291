// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'video_bloc.dart';

class VideoState {
  final List<VideoModel> videos;
  final int index;
  const VideoState({this.videos = const [], this.index = 0});

  VideoState copyWith({
    List<VideoModel>? videos,
    int? index,
  }) {
    return VideoState(
      videos: videos ?? this.videos,
      index: index ?? this.index,
    );
  }
}
