import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'loading_widget.dart';


Widget imageFromServer({required String imageUrl,fit = BoxFit.fill}){


  return CachedNetworkImage(
    cacheKey: imageUrl,
    // cacheManager: Cashe,
    imageUrl: imageUrl,

    imageBuilder: (context, imageProvider) => Container(

      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: fit,
        ),
      ),
    ),
    placeholder: (context, url) => LoadingWidget(),
    errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
  );
}

ImageProvider imageProviderFromServer({required String imageUrl,fit = BoxFit.fill}){


  return CachedNetworkImageProvider(
    imageUrl,
    cacheKey: imageUrl,
    // cacheManager: Cashe,

  );
}