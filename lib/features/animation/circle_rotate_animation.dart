import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/animation/animation_rotate_cubit.dart';



class CircleRotateAnimation extends StatefulWidget {
  const CircleRotateAnimation({super.key});

  @override
  State<CircleRotateAnimation> createState() => _CircleRotateAnimationState();
}

class _CircleRotateAnimationState extends State<CircleRotateAnimation>
    with SingleTickerProviderStateMixin {
  double _rotation = 0;
  double _velocity = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _controller.addListener(() {
      _rotation += _animation.value;
      context.read<AnimationRotateCubit>().update(_rotation);
    });

    super.initState();
  }

  void _startInertia(double velocity) {
    _controller.stop();
    _animation = Tween<double>(
      begin: velocity * 0.01, // control speed
      end: 0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Offset? _lastPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Smooth Rotating Circle")),
      body: Center(
        child: GestureDetector(
          onPanStart: (details) {
            _controller.stop();
            _lastPoint = details.localPosition;
          },
          onPanUpdate: (details) {
            final dx = details.delta.dx;
            final dy = details.delta.dy;

            final direction = dx + dy;
            _rotation += direction * 0.01;
            _velocity = direction;

            context.read<AnimationRotateCubit>().update(_rotation);
          },
          onPanEnd: (_) {
            _startInertia(_velocity);
          },
          child: BlocBuilder<AnimationRotateCubit, double>(
            builder: (context, angle) {
              return Transform.rotate(
                angle: angle,
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: Stack(
                    children: List.generate(12, (index) {
                      final theta = (2 * pi / 12) * index;
                      final radius = 100.0;
                      return Positioned(
                        left: 125 + radius * cos(theta) - 15,
                        top: 125 + radius * sin(theta) - 15,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.blue[200],
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
