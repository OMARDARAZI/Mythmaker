import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class shimmerContainer extends StatelessWidget {
  shimmerContainer({
    super.key,
    this.height,
    this.width,
  });

  double? width = 200.w;
  double? height = 100.h;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: Colors.grey[500], borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
