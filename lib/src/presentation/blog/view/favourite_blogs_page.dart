import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sub_space_blog/src/bloc/bloc.dart';
import 'package:sub_space_blog/src/domain/domain.dart';
import 'package:sub_space_blog/src/presentation/blog/widgets/toggle_favourite_button_widget.dart';
import 'package:sub_space_blog/src/presentation/widgets/widgets.dart';

class FavouriteBlogsPage extends StatelessWidget {
  const FavouriteBlogsPage({
    super.key,
  });

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
            leading: IconWidget.svgAsset(
              assetName: 'assets/icons/subspace.svg',
            ),
            title: const Text('Favourites'),
            centerTitle: true,
          ),
          BlocBuilder<BlogBloc, BlogState>(
            builder: (context, state) {
              if (state.favourites.isNotEmpty) {
                return SliverAnimatedGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    mainAxisExtent: 300,
                  ),
                  initialItemCount: state.favourites.length,
                  itemBuilder: (context, index, animation) {
                    final blog = state.favourites.elementAt(index);

                    return GestureDetector(
                      child: _BlogListItemWidget(
                        key: Key('blog_feed_${blog.id}'),
                        item: blog,
                        isLiked: true,
                      ),
                    );
                  },
                );
              } else {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text('You have no favourites'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _BlogListItemWidget extends StatelessWidget {
  const _BlogListItemWidget({
    super.key,
    required this.item,
    this.isLiked = false,
  });

  final BlogListItem item;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              maxHeight: 400,
              maxWidth: 400,
              item.imageUrl,
            ),
            fit: BoxFit.cover,
            opacity: 0.7,
            filterQuality: FilterQuality.low,
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: ToggleFavouriteButtonWidget(
                    isLiked: isLiked,
                    onPressed: () => context.read<BlogBloc>().add(
                          BlogFavourited(blog: item),
                        ),
                  ),
                ),
                const Spacer(),
                Text(
                  item.title,
                  style: typography.headlineMedium!.copyWith(
                    fontFamily: 'Lora-Bold',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )),
      ),
    );
  }
}
