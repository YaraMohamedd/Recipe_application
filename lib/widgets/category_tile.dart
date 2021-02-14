import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class CategoryTile extends StatelessWidget {
  final String imageUrl;
  final String title;

  const CategoryTile({ this.imageUrl, this.title}) ;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 140.0,
              height: 90.0,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: 140.0,
            height: 90.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.black54,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.75,
            ),
          )
        ],
      ),

    );
  }
}
