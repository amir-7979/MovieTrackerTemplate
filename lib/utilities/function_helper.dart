void like(bool? like, bool? disLike, int likeCount, int disLikeCount) {
    if (like == true) {
      like = false;
      likeCount--;
    } else if (disLike == false){
      like = true;
      disLike = false;
      likeCount++;
      disLikeCount--;
    } else {
      like = true;
      likeCount++;
    }

}
