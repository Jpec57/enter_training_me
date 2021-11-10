import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

class InstaLikeSliverDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  InstaLikeSliverDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: CustomTheme.darkGrey, child: tabBar);
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
