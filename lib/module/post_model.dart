import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String? postId;
  final DocumentReference serviceProviderCollection;
  final String? image;

  PostModel({
    this.postId,
    required this.serviceProviderCollection,
    this.image,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['serviceProviderId'],
      serviceProviderCollection: json['serviceType'],
      image: json['image'],
    );
  }
  toJson() {
    return {
      "postId": postId,
      "serviceProviderCollection": serviceProviderCollection,
      "image": image,
    };
  }
}
