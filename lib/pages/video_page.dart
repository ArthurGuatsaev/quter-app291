import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotex291/const/color.dart';
import 'package:quotex291/video/domain/bloc/video_bloc.dart';
import 'package:quotex291/video/view/video_item.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  void initState() {
    super.initState();
    context.read<VideoBloc>().add(GetVideoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          height: 150,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)),
            color: bgSecondColor,
          ),
          child: const Padding(
            padding: EdgeInsets.only(bottom: 10, left: 12),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Video',
                style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
            child: BlocBuilder<VideoBloc, VideoState>(
          buildWhen: (previous, current) =>
              previous.videos.length != current.videos.length,
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.videos.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: VideoItem(
                  video: state.videos[index],
                  index: index,
                ),
              ),
            );
          },
        ))
      ]),
    );
  }
}
