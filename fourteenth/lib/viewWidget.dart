// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';

class ViewWidget extends StatefulWidget {
  const ViewWidget({super.key});

  @override
  State<ViewWidget> createState() => _ViewWidgetState();
}

class _ViewWidgetState extends State<ViewWidget> {
  CrossFadeState crossFadeState = CrossFadeState.showFirst;
  int number = 9;
  double fontSize = 200;
  @override
  void initState() {
    super.initState();
    /*Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (mounted) {
          setState(
            () {
              crossFadeState = crossFadeState == CrossFadeState.showFirst
                  ? CrossFadeState.showSecond
                  : number == 0
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst;
              number = number == 0 ? 0 : number - 1;
              fontSize = number == 0 ? 0 : fontSize - 20;
            },
          );
        }
      },
    );*/
    for (int i = 9; i >= 0; i--) {
      Future.delayed(
        Duration(seconds: 10 - i),
        () {
          if (mounted) {
            setState(() {
              crossFadeState = crossFadeState == CrossFadeState.showFirst
                  ? CrossFadeState.showSecond
                  : number == 0
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst;
              number = number == 0 ? 0 : number - 1;
              fontSize = number == 0 ? 0 : fontSize - 20;
            });
          }
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedCrossFade(
          firstChild: Text(
            '$number',
            style: TextStyle(fontSize: fontSize),
          ),
          secondChild: number != 0
              ? Text(
                  '$number',
                  style: TextStyle(fontSize: fontSize),
                )
              : const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'Hellow World',
                      ),
                    ),
                  ),
                ),
          crossFadeState: crossFadeState,
          duration: const Duration(seconds: 1),
        ),
      ),
    );
  }
}
