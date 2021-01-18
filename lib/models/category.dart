import 'package:flutter/material.dart';

//just an old dart class which i can instantiate
class Category {
  final String id;
  final String title;
  final Color color;

  const Category({
    @required this.id,
    @required this.title,
    this.color = Colors.orange,
  });
}
