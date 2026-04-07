import 'package:flutter/material.dart';
import '../utils/constants.dart';

class OrderCard extends StatelessWidget {
  final String customerName;
  final IconData customerIcon;
  final Color customerColor;
  final List<String> orders;
  final List<String> selectedItems;

  const OrderCard({
    super.key,
    required this.customerName,
    required this.customerIcon,
    required this.customerColor,
    required this.orders,
    required this.selectedItems,
  });

  IconData getIconForItem(String itemName) {
    final item = Constants.menu.firstWhere(
      (element) => element["name"] == itemName,
    );
    return item["icon"];
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> selectedCount = {};
    for (var item in selectedItems) {
      selectedCount[item] = (selectedCount[item] ?? 0) + 1;
    }

    Map<String, int> tempCount = {};

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.pink, width: 2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.pinkAccent,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(customerIcon, size: 40, color: customerColor),
              const SizedBox(width: 10),
              Text(
                customerName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Text(
            "Order:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.pink,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: orders.map((item) {
              tempCount[item] = (tempCount[item] ?? 0) + 1;
              bool isSelected = (selectedCount[item] ?? 0) >= tempCount[item]!;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.pink : Colors.pink.shade100,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: isSelected ? Colors.pink.shade50 : Colors.pink.shade50,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0x66FF4081),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  children: [
                    Icon(getIconForItem(item), color: Colors.pink),
                    const SizedBox(width: 10),
                    Text(item, style: const TextStyle(fontSize: 16)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
