import 'package:flutter/material.dart';
import 'package:fourteenth/viewWidget.dart';

void main() {
  runApp(const TestWidget());
}

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TestAnimationWidget(),
    );
  }
}

class TestAnimationWidget extends StatelessWidget {
  const TestAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TestAnimationList(),
    );
  }
}

class TestAnimationList extends StatefulWidget {
  const TestAnimationList({super.key});

  @override
  State<TestAnimationList> createState() => _TestAnimationListState();
}

class _TestAnimationListState extends State<TestAnimationList> {
  final List<String> subTitles = [];
  final List<Color> color = [];
  final GlobalKey<AnimatedListState> key = GlobalKey();
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AnimatedList(
            controller: scrollController,
            key: key,
            itemBuilder: (context, index, animation) {
              return SizeTransition(
                sizeFactor: animation,
                axisAlignment: .1,
                child: index >= color.length
                    ? const TestItem()
                    : TestItem(
                        color: color[index],
                        subTitle: subTitles[index],
                        title: 'Color ${index + 1}',
                      ),
              );
            },
            initialItemCount: subTitles.length,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewWidget(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Next Page'),
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            TextButton(
              onPressed: () {
                if (subTitles.length < 10) {
                  subTitles.add(subTitles.length % 3 == 0
                      ? 'Red'
                      : subTitles.length % 3 == 1
                          ? 'Orange'
                          : 'Yellow');
                  color.add(color.length % 3 == 0
                      ? Colors.red
                      : color.length % 3 == 1
                          ? Colors.orange
                          : Colors.yellow);
                  key.currentState!.insertItem(subTitles.length - 1);
                } else {
                  key.currentState!.insertItem(subTitles.length);
                  Future.delayed(
                    const Duration(milliseconds: 500),
                    () {
                      scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.bounceIn,
                      );
                      Future.delayed(
                        const Duration(milliseconds: 500),
                        () {
                          subTitles.add(subTitles.length % 3 == 0
                              ? 'Red'
                              : subTitles.length % 3 == 1
                                  ? 'Orange'
                                  : 'Yellow');
                          color.add(color.length % 3 == 0
                              ? Colors.red
                              : color.length % 3 == 1
                                  ? Colors.orange
                                  : Colors.yellow);
                          key.currentState!.insertItem(subTitles.length - 1);
                          key.currentState!.removeItem(
                            subTitles.length,
                            (context, animation) {
                              return const TestItem();
                            },
                          );
                        },
                      );
                    },
                  );
                }
              },
              child: Container(
                color: Colors.black,
                height: 35,
                width: 120,
                child: const Center(
                  child: Text('Add Color'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TestItem extends StatelessWidget {
  const TestItem({
    super.key,
    this.color,
    this.title,
    this.subTitle,
  });
  final Color? color;
  final String? title;
  final String? subTitle;
  @override
  Widget build(BuildContext context) {
    return color == null
        ? const SizedBox(
            height: 80,
          )
        : Card(
            elevation: 10,
            child: ListTile(
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              title: Text(title!),
              subtitle: Text(subTitle!),
            ),
          );
  }
}
