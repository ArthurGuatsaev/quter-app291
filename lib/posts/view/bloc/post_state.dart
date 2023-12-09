// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_bloc.dart';

class PostState {
  final List<VPost> posts;
  final List<VNotesIssar> notes;
  final VPost currentPost;
  final int currentId;
  final Uint8List? postImage;
  PostState({
    this.currentPost = const VPost.initial(),
    this.posts = const [],
    this.notes = const [],
    this.currentId = 0,
    this.postImage,
  });

  PostState copyWith({
    List<VPost>? posts,
    List<VNotesIssar>? notes,
    Uint8List? postImage,
    int? currentId,
    VPost? currentPost,
  }) {
    return PostState(
      currentPost: currentPost ?? this.currentPost,
      posts: posts ?? this.posts,
      postImage: postImage,
      notes: notes ?? this.notes,
      currentId: currentId ?? this.currentId,
    );
  }

  List<VNotesIssar> get currentNotes {
    if (notes.isEmpty) {
      return [];
    }
    return notes.where((element) => element.iD == currentId).toList();
  }
}
