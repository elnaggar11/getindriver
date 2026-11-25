import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getin_driver/core/generated/images2.dart';
import 'package:getin_driver/shared/widgets/default_image_widget.dart';
import '../../domain/model/report_model.dart';

class ReviewItemWidget extends StatelessWidget {
  const ReviewItemWidget({super.key, required this.review});

  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const DefaultImageWidget(
                "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=880&q=80",
                width: 40,
                sourceMediaType: MediaType.image,
                height: 40,
                fit: BoxFit.cover,
                radius: 250,
                isCircle: true,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.userName ?? LocalizationHelper.tr.placeholder_text,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        (review.rating ?? 0).toString(),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xffFFBE33),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 5),
                      SvgPicture.asset(
                        SvgMang.star,
                        width: 12,
                        colorFilter: const ColorFilter.mode(
                          Color(0xffFFBE33),
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Text(
                review.createdAt ?? LocalizationHelper.tr.unspecified_phrase,
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF737373),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            review.comment ?? LocalizationHelper.tr.unspecified_phrase,
            style: const TextStyle(
              color: Color(0xFF737373),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
