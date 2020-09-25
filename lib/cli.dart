class Review {
  int id;
  int animatorId;
  String subject;
  String content;
}

class Animator {
  int id;
  String name;
  double costPerHour;
  List<Review> reviews;
}

