import 'package:app04/models/properties_model.dart';

UserStats likeMovie(UserStats userStats) {
  if (userStats.likeMovie == true) {
    userStats.likeMovie = false;
    userStats.likeMovieCount = userStats.likeMovieCount! - 1;
  } else if (userStats.dislikeMovie == true){
    userStats.likeMovie = true;
    userStats.dislikeMovie = false;
    userStats.likeMovieCount = userStats.likeMovieCount! + 1;
    userStats.dislikeMovieCount = userStats.dislikeMovieCount! - 1;
  } else {
    userStats.likeMovie = true;
    userStats.likeMovieCount = userStats.likeMovieCount! + 1;
  }
  return userStats;
}

UserStaffStats likeStaff(UserStaffStats userStaffStats) {
  if (userStaffStats.likeStaff == true) {
    userStaffStats.likeStaff = false;
    userStaffStats.likeStaffCount = userStaffStats.likeStaffCount! - 1;
  } else if (userStaffStats.dislikeStaff == true){
    userStaffStats.likeStaff = true;
    userStaffStats.dislikeStaff = false;
    userStaffStats.likeStaffCount = userStaffStats.likeStaffCount! + 1;
    userStaffStats.dislikeStaffCount = userStaffStats.dislikeStaffCount! - 1;
  } else {
    userStaffStats.likeStaff = true;
    userStaffStats.likeStaffCount = userStaffStats.likeStaffCount! + 1;
  }
  return userStaffStats;
}

CharacterStats likeCharacter(CharacterStats userStaffStats) {
  if (userStaffStats.likeCharacter == true) {
    userStaffStats.likeCharacter = false;
    userStaffStats.likeCharacterCount = userStaffStats.likeCharacterCount! - 1;
  } else if (userStaffStats.dislikeCharacter == true){
    userStaffStats.likeCharacter = true;
    userStaffStats.dislikeCharacter = false;
    userStaffStats.likeCharacterCount = userStaffStats.likeCharacterCount! + 1;
    userStaffStats.dislikeCharacterCount = userStaffStats.dislikeCharacterCount! - 1;
  } else {
    userStaffStats.likeCharacter = true;
    userStaffStats.likeCharacterCount = userStaffStats.likeCharacterCount! + 1;
  }
  return userStaffStats;
}


UserStats disLikeMovie(UserStats userStats) {
  if (userStats.dislikeMovie == true) {
    userStats.dislikeMovie = false;
    userStats.dislikeMovieCount = userStats.dislikeMovieCount! - 1;
  } else if (userStats.likeMovie == true){
    userStats.dislikeMovie = true;
    userStats.likeMovie = false;
    userStats.dislikeMovieCount = userStats.dislikeMovieCount! + 1;
    userStats.likeMovieCount = userStats.likeMovieCount! - 1;
  } else {
    userStats.dislikeMovie = true;
    userStats.dislikeMovieCount = userStats.dislikeMovieCount! + 1;
  }
  return userStats;
}

UserStaffStats disLikeStaff(UserStaffStats userStaffStats) {
  if (userStaffStats.dislikeStaff == true) {
    userStaffStats.dislikeStaff = false;
    userStaffStats.dislikeStaffCount = userStaffStats.dislikeStaffCount! - 1;
  } else if (userStaffStats.likeStaff == true){
    userStaffStats.dislikeStaff = true;
    userStaffStats.likeStaff = false;
    userStaffStats.dislikeStaffCount = userStaffStats.dislikeStaffCount! + 1;
    userStaffStats.likeStaffCount = userStaffStats.likeStaffCount! - 1;
  } else {
    userStaffStats.dislikeStaff = true;
    userStaffStats.dislikeStaffCount = userStaffStats.dislikeStaffCount! + 1;
  }
  return userStaffStats;
}


CharacterStats disLikeCharacter(CharacterStats userStaffStats) {
  if (userStaffStats.dislikeCharacter == true) {
    userStaffStats.dislikeCharacter = false;
    userStaffStats.dislikeCharacterCount = userStaffStats.dislikeCharacterCount! - 1;
  } else if (userStaffStats.likeCharacter == true){
    userStaffStats.dislikeCharacter = true;
    userStaffStats.likeCharacter = false;
    userStaffStats.dislikeCharacterCount = userStaffStats.dislikeCharacterCount! + 1;
    userStaffStats.likeCharacterCount = userStaffStats.likeCharacterCount! - 1;
  } else {
    userStaffStats.dislikeCharacter = true;
    userStaffStats.dislikeCharacterCount = userStaffStats.dislikeCharacterCount! + 1;
  }
  return userStaffStats;
}

List<Object?> copyLike(bool? like, bool? disLike, int likeCount, int disLikeCount) {
  return [like, disLike, likeCount, disLikeCount];
}

UserStats setLike(UserStats stat, bool? like, bool? disLike, int likeCount, int disLikeCount) {
  stat.likeMovie = like;
  stat.dislikeMovie = disLike;
  stat.likeMovieCount = likeCount;
  stat.dislikeMovieCount = disLikeCount;
  return stat;
}
