import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sub_space_blog/src/domain/domain.dart';
import 'package:sub_space_blog/src/presentation/widgets/widgets.dart';

class BlogDetailsPage extends StatelessWidget {
  const BlogDetailsPage({
    super.key,
    required this.blog,
  });

  final BlogListItem blog;

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            toolbarHeight: kToolbarHeight * 1.2,
            pinned: true,
            leadingWidth: MediaQuery.sizeOf(context).width * 0.4,
            titleTextStyle: typography.headlineSmall!.copyWith(
              fontFamily: 'Lora-Bold',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: blog.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            leading: IconWidget.svgAsset(
              assetName: 'assets/icons/subspace.svg',
            ),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.title,
                    style: typography.headlineLarge!.copyWith(
                      color: Colors.white,
                      fontFamily: 'Lora-Bold',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
