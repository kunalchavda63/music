import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/bloc/animation/animation_cubit.dart';
import 'package:music/core/app_ui/app_ui.dart';

class SimpleAnimation extends StatefulWidget {
  const SimpleAnimation({super.key});

  @override
  State<SimpleAnimation> createState() => _SimpleAnimationState();
}

class _SimpleAnimationState extends State<SimpleAnimation>
    with SingleTickerProviderStateMixin {
  final List color = [
    AppColors.whiteSmoke,
    AppColors.redWine,
    AppColors.lavendarPink,
    AppColors.persianPink,
    AppColors.eggBlue,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.customAppBar(
        title: CustomWidgets.customText(
          data: 'Simple Animation',
          style: BaseStyle.s14w500.c(AppColors.redWine),
        ),
      ),
      body: BlocBuilder<AnimationCubit, AnimatedState>(
        builder: (context, state) {
          return Column(
            children: [
              Row(children: []),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                width: 100 + (state.value * 100),
                height: 100,
                decoration: BoxDecoration(
                  color: state.color,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: AppColors.redWine),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomWidgets.customCircleIcon(
                    onTap: () {
                      context.read<AnimationCubit>().reset();
                    },
                    iconData: Icons.restart_alt_outlined,
                  ),
                  CustomWidgets.customCircleIcon(
                    onTap: () {
                      context.read<AnimationCubit>().updateValue(2);
                    },
                    iconData: Icons.start,
                  ),
                ],
              ),
              SizedBox(
                height: 60.r,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: color.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CustomWidgets.customContainer(
                      onTap: (){
                        context.read<AnimationCubit>().updateColor(color[index]);
                      },
                      h: 60.r,
                      w: 60.r,
                      color: color[index],
                      boxShape: BoxShape.circle
                    ).padH(10.r).padV(10.r);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
