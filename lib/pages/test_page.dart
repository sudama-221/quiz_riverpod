import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PageController(initialPage: 0);
    // print(controller.page);
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageView'),
        actions: [
          IconButton(
            onPressed: () => controller.previousPage(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
            ),
            icon: const Icon(Icons.keyboard_arrow_left),
          ),
          IconButton(
            onPressed: () => controller.nextPage(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
            ),
            icon: const Icon(Icons.keyboard_arrow_right),
          ),
        ],
      ),
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          print('Page ${index + 1}');
        },
        children: [
          Container(
            color: Colors.purple,
            child: const Center(child: Text('Page1')),
          ),
          Container(
            color: Colors.pink,
            child: const Center(child: Text('Page2')),
          ),
          Container(
            color: Colors.green,
            child: const Center(child: Text('Page3')),
          ),
        ],
      ),
    );
  }
}
