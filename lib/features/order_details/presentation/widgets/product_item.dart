import 'package:flutter/material.dart';
import 'package:getin_driver/features/home/domain/model/order_list_model/item.dart';
import 'package:getin_driver/shared/widgets/default_image_widget.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final OrderItem product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 8, left: 8, right: 15, bottom: 8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Row(
        children: [
          const DefaultImageWidget(
            'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg',
            width: 50,
            height: 50,
            radius: 25,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 3,
            children: [
              Text(
                product.productName!,
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.20),
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '\$${product.totalPrice!}',
                style: const TextStyle(
                  color: Color(0xFF34A853),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.black,
            child: Center(
              child: Text(
                '${product.quantity ?? 0}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
