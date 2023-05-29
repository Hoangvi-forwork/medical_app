import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_app/model/news_model.dart';

class NewsRepository {
  final CollectionReference newsCollection =
      FirebaseFirestore.instance.collection('news');

  Future<List> fetchNews() async {
    final QuerySnapshot snapshot = await newsCollection.get();
    return snapshot.docs.map((doc) => NewsModel.fromJson(doc)).toList();
  }
}
