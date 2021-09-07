abstract class HomeStates {}

class HomeIntinalState extends HomeStates {}

class ChangeBottomNavigationBarState extends HomeStates {}

class AddPostNavigationBarState extends HomeStates {}

class GetUserDataLoadingState extends HomeStates {}

class GetUserDataSucessState extends HomeStates {}

class GetUserDataErrorState extends HomeStates {
  final String error;

  GetUserDataErrorState(this.error);
}

class GetAccountDataLoadingState extends HomeStates {}

class GetAccountDataSucessState extends HomeStates {}

class GetAccountDataErrorState extends HomeStates {
  final String error;

  GetAccountDataErrorState(this.error);
}

class GetUserProfileSucessState extends HomeStates {}

class GetUserProfileErrorState extends HomeStates {}

class GetUserCoverSucessState extends HomeStates {}

class GetUserCoverErrorState extends HomeStates {}

class UpdateUserDataLoadingState extends HomeStates {}

class UpdateUserDataErrorState extends HomeStates {}

class GetPostImageSucessState extends HomeStates {}

class GetPostImageErrorState extends HomeStates {}

class UserCreatePostLoadingState extends HomeStates {}

class UserCreatePostSucessState extends HomeStates {}

class UserCreatePostErrorState extends HomeStates {
  final String error;

  UserCreatePostErrorState(this.error);
}

class RemovePostImageState extends HomeStates {}

class GetPostsErrorState extends HomeStates {
  final String error;

  GetPostsErrorState(this.error);
}

class GetPostsSucessState extends HomeStates {}

class LikePostSucessState extends HomeStates {}
class AddFollowersSucessState extends HomeStates {}

class ChangeLikeIcon extends HomeStates {}

class LikePostErrorState extends HomeStates {
  final String error;

  LikePostErrorState(this.error);
}

class PostCommentSucessState extends HomeStates {}

class PostCommentErrorState extends HomeStates {
  final String error;

  PostCommentErrorState(this.error);
}

class GetUserCommentDataSucessState extends HomeStates {}

class GetUserCommentDataErrorState extends HomeStates {
  final String error;

  GetUserCommentDataErrorState(this.error);
}

class GetCommentSucessState extends HomeStates {}

class GetCommentErrorState extends HomeStates {
  final String error;

  GetCommentErrorState(this.error);
}

class GetAllUserDataSucessState extends HomeStates {}

class GetAllUserDataErrorState extends HomeStates {
  final String error;

  GetAllUserDataErrorState(this.error);
}

//chat

class SendMessageSucessState extends HomeStates {}

class SendMessageErrorState extends HomeStates {
  final String error;

  SendMessageErrorState(this.error);
}

class ReceiveMessageSucessState extends HomeStates {}

class GetSearchResultSucessState extends HomeStates {}

class GetSearchResultErrorState extends HomeStates {}

class ReceiveMessageErrorState extends HomeStates {
  final String error;

  ReceiveMessageErrorState(this.error);
}
