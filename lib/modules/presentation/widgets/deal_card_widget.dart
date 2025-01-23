import 'package:cached_network_image/cached_network_image.dart';
import 'package:deals/modules/domain/entities/deal_entity.dart';
import 'package:deals/utils/extensions.dart';
import 'package:flutter/material.dart';

class DealCardWidget extends StatelessWidget {
  const DealCardWidget({
    super.key,
    required this.deal,
  });

  final DealEntity deal;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              bottom: 10,
              top: 10,
            ),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: deal.imageMedium ?? '',
                  width: 80,
                  height: 80,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) {
                    return Icon(
                      Icons.warning,
                      color: Theme.of(context).colorScheme.error,
                    );
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                Text(deal.store?.name ?? 'NA'),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.comment_sharp),
                SizedBox(width: 5),
                Text('${deal.commentsCount}'),
                SizedBox(width: 15),
                Icon(Icons.watch_later_outlined),
                SizedBox(width: 5),
                Text(
                  '${deal.createdAt?.day} ${deal.createdAt?.toMonthName()} ${deal.createdAt?.year}',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
