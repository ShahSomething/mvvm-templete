import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmersScreen extends StatelessWidget {
  /// itemCount: the amount of time the listview will generate the shimmer design by default it is 1.
  final int? itemCount;
  const ShimmersScreen({Key? key, this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListView.builder(
            itemCount: itemCount ?? 1,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => shimmerDesign(),
          ),
        )
        // shimmerDesign()
      ],
    );
  }

  /// --------------- ------------------------------------------------------------
  /// The design on shimmer is in the followin function
  /// If you want to change the design according to you need
  /// make changes in the following function
  /// ----------------------------------------------------------------------------
  Column shimmerDesign() {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 6.w),
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ShimmerContainer(width: 170.w),
                ShimmerContainer(width: 120.w),
                ShimmerContainer(width: 220.w),
              ],
            )
          ],
        ),
        SizedBox(height: 10.h),
        ShimmerContainer(
          width: 1.sw,
          height: 250.h,
          isBorderCircular: false,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 8.w),
                const ShimmerContainer(width: 15, horizontalPadding: 2),
                const ShimmerContainer(width: 20, horizontalPadding: 2),
                const ShimmerContainer(width: 25, horizontalPadding: 2),
                const ShimmerContainer(width: 55, horizontalPadding: 2),
              ],
            ),
            const ShimmerContainer(width: 100),
          ],
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}

/// ------------------------------------------------------------------------------------------------
///
/// All of the design of ShimmerDesign function is made of single container
/// ---- MAJOR PARAMETERS ----
///
/// -> double height: pass the desired height of the container
/// -> double width: pass the desired width of the container
/// -> double horizontalPadding: for the padding from left and right, default is 10
/// -> double verticalPadding: for the padding from top and bottom, default is 2
/// -> bool isBorderCircular: is true, the container will have circular border else not
///
/// ------------------------------------------------------------------------------------------------
class ShimmerContainer extends StatelessWidget {
  final double? height, width, horizontalPadding, verticalPadding;
  final bool? isBorderCircular;
  const ShimmerContainer({
    Key? key,
    this.height,
    this.width,
    this.horizontalPadding,
    this.verticalPadding,
    this.isBorderCircular,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 2, horizontal: horizontalPadding ?? 10),
      height: height ?? 15.h,
      width: width ?? 120.h,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: isBorderCircular ?? true
            ? BorderRadius.circular(8)
            : BorderRadius.circular(0),
      ),
    );
  }
}
