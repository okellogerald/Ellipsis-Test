class Product {
  final String title, description, category, image;
  final Rating rating;
  final num price;
  final int id;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.price,
  });

  String get getPrice => "\$ $price";

  String get getRate => "${rating.rate} (${rating.count})";

  factory Product.fromMap(var map) {
    return Product(
      category: map['category'],
      description: map['description'],
      price: num.parse(map['price'].toString()),
      image: map['image'],
      rating: Rating.fromMap(map['rating']),
      id: map['id'],
      title: map['title'],
    );
  }
}

class Rating {
  final int count;
  final num rate;

  const Rating({
    required this.count,
    required this.rate,
  });

  factory Rating.fromMap(var map) {
    return Rating(
      count: map['count'],
      rate: num.parse(map['rate'].toString()),
    );
  }
}
