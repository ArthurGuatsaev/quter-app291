class VideoModel {
  final int id;
  final String title;
  final String description;
  final String image;
  final String video;
  final int duration;
  VideoModel({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.image = '',
    this.video = '',
    this.duration = 0,
  });

  VideoModel copyWith({
    int? id,
    String? title,
    String? description,
    String? image,
    String? video,
    int? duration,
  }) {
    return VideoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      video: video ?? this.video,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'video': video,
      'duration': duration,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      video: map['video'] as String,
      duration: map['duration'] as int,
    );
  }
}
