class ReelModel {
  final String videoUrl;
  final String userName;
  final int likeCount;
  final bool isLiked;
  final String musicName;
  final String reelDescription;
  final String profileUrl;
  final List<ReelCommentModel> commentList;

  ReelModel(
    this.videoUrl,
    this.userName, {
    this.likeCount = 0,
    this.isLiked = false,
    this.musicName = '',
    this.reelDescription = '',
    this.profileUrl = '',
    this.commentList = const [],
  });
}

class ReelCommentModel {
  final String comment;
  final String? userProfilePic;
  final String userName;
  final DateTime commentTime;

  ReelCommentModel({
    this.userProfilePic,
    required this.comment,
    required this.userName,
    required this.commentTime,
  });
}
