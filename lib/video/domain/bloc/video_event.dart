// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'video_bloc.dart';

abstract class VideoEvent {
  const VideoEvent();
}

class GetVideoEvent extends VideoEvent {}

class ChangeIndexEvent extends VideoEvent {
  final int index;
  const ChangeIndexEvent({
    required this.index,
  });
}
