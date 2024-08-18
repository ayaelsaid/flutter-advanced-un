// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:using_firebase/models/category.dart';
// import 'package:using_firebase/models/instructor.dart';

// class Course {
//   String? id;
//   String? title;
//   String? image;
//   Category? category;
//   String? currency;
//   String? rank;
//   bool? has_certificate;
//   Instructor? instructor;
//   double? price;
//   double? rating;
//   int? total_hours;
//   DateTime? created_date;

//   Course.fromJson(Map<String, dynamic> data) {
//     id = data['id'];
//     title = data['title'];
//     image = data['image'];
//     category =
//         data['category'] != null ? Category.fromJson(data['category']) : null;
//     currency = data['currency'];
//     rank = data['rank'];
//     has_certificate = data['has_certificate'];
//     instructor = data['instructor'] != null
//         ? Instructor.fromJson(data['instructor'])
//         : null;
//     price = data['price'] is int
//         ? (data['price'] as int).toDouble()
//         : data['price'];
//     rating = data['rating'] is int
//         ? (data['rating'] as int).toDouble()
//         : data['rating'];
//     total_hours = data['total_hours'];
//     created_date = data['created_date'] != null
//         ? (data['created_date'] as Timestamp).toDate()
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['title'] = title;
//     data['image'] = image;
//     data['category'] = category?.toJson();
//     data['currency'] = currency;
//     data['rank'] = rank;
//     data['has_certificate'] = has_certificate;
//     data['instructor'] = instructor?.toJson();
//     data['price'] = price;
//     data['rating'] = rating;
//     data['total_hours'] = total_hours;
//     return data;
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:using_firebase/models/category.dart';
import 'package:using_firebase/models/instructor.dart';

class Course {
  String? id;
  String? title;
  String? image;
  Category? category;
  String? currency;
  String? rank;
  bool? has_certificate;
  Instructor? instructor;
  double? price;
  double? rating;
  int? total_hours;
  DateTime? created_date;

  Course.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    title = data['title'];
    image = data['image'];

    // Handle category reference
    if (data['category'] is DocumentReference) {
      final categoryRef = data['category'] as DocumentReference;
      categoryRef.get().then((categorySnapshot) {
        category =
            Category.fromJson(categorySnapshot.data() as Map<String, dynamic>);
      });
    } else {
      category =
          data['category'] != null ? Category.fromJson(data['category']) : null;
    }

    currency = data['currency'];
    rank = data['rank'];
    has_certificate = data['has_certificate'];

    // Handle instructor reference
    if (data['instructor'] is DocumentReference) {
      final instructorRef = data['instructor'] as DocumentReference;
      instructorRef.get().then((instructorSnapshot) {
        instructor = Instructor.fromJson(
            instructorSnapshot.data() as Map<String, dynamic>);
      });
    } else {
      instructor = data['instructor'] != null
          ? Instructor.fromJson(data['instructor'])
          : null;
    }

    price = data['price'] is int
        ? (data['price'] as int).toDouble()
        : data['price'];
    rating = data['rating'] is int
        ? (data['rating'] as int).toDouble()
        : data['rating'];
    total_hours = data['total_hours'];
    created_date = data['created_date'] != null
        ? (data['created_date'] as Timestamp).toDate()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['category'] = category?.toJson();
    data['currency'] = currency;
    data['rank'] = rank;
    data['has_certificate'] = has_certificate;
    data['instructor'] = instructor?.toJson();
    data['price'] = price;
    data['rating'] = rating;
    data['total_hours'] = total_hours;
    data['created_date'] =
        created_date != null ? Timestamp.fromDate(created_date!) : null;
    return data;
  }
}