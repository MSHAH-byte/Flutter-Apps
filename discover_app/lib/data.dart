class Article {
  final String title;
  final String image;
  final String location;
  final String author;
  final int likes;
  final int comments;
  final int shares;
  final double rating;
  bool isLiked;

  Article({
    required this.title,
    required this.image,
    required this.location,
    required this.author,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.rating,
    this.isLiked = false,
  });
}

List<Article> articles = [
  Article(
    title: "Japan's second largest metropolitan area",
    image: "assets/images/tokyo.jpg",
    location: "Osaka Japan",
    author: "Hussain Mustafa",
    likes: 32000,
    comments: 100,
    shares: 50,
    rating: 4.0,
    isLiked: true,
  ),
  Article(
    title: "Known as the sleepless town for obvious reasons",
    image: "assets/images/japan_nightlife.jpg",
    location: "Kabuikicho Japan",
    author: "Tim Salvatore",
    likes: 50000,
    comments: 300,
    shares: 1250,
    rating: 3.5,
    isLiked: true,
  ),
  Article(
    title: "Japan's second largest metropolitan area",
    image: "assets/images/japan_historic_places.jpg",
    location: "Tokyo Japan",
    author: "Ely Marya",
    likes: 10000,
    comments: 200,
    shares: 1000,
    rating: 5.0,
    isLiked: true,
  ),
];
