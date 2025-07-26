import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music/bloc/image_validator_bloc/image_validator_bloc.dart';
import 'package:music/core/utilities/src/helper_method.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/app_ui/app_ui.dart';

class TriangleBorderImage extends StatefulWidget {
  const TriangleBorderImage({super.key});

  @override
  State<TriangleBorderImage> createState() => _TriangleBorderImageState();
}

class _TriangleBorderImageState extends State<TriangleBorderImage> {
  late Size size;
  final TextEditingController urlController = TextEditingController();
  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackOlive,
      appBar: CustomWidgets.customAppBar(
        autoImplyLeading: false,
        leading: CustomWidgets.customCircleBackButton(
          color: AppColors.whiteSmoke,
        ).padH(15.r),
        bgColor: AppColors.blackOlive,
        title: CustomWidgets.customText(
          data: 'Upload And Image Download',
          style: BaseStyle.s17w400.c(AppColors.hexF5f5),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomWidgets.customContainer(
              padding: EdgeInsets.all(5),
              border: Border.all(color: AppColors.black),
              borderRadius: BorderRadius.circular(20),
              child: BlocBuilder<ImageValidatorBloc, ImageValidatorState>(
                builder: (context, state) {
                  if (state is ImageValidatorLoading) {
                    return CircularProgressIndicator();
                  } else if (state is ImageValidatorSuccess) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CustomWidgets.customImageView(
                            height: size.height / 2,
                            width: size.width / 1,
                            path: state.imageUrl,
                            sourceType: ImageType.network,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: CustomWidgets.customCircleIcon(
                            onTap: () {
    final url = urlController.text.trim();
    if (url.isNotEmpty) {

    } else {
    Fluttertoast.showToast(msg: "Enter a valid URL");
                              }
                            },

                            border: Border.all(color: AppColors.hex7777),
                            bgColor: AppColors.white,
                            iconData: Icons.download,
                            iconColor: AppColors.blackOlive,
                            iconSize: 30,
                          ),
                        ),
                      ],
                    );
                  } else if (state is ImageValidatorFailure) {
                    return CustomWidgets.customText(
                      data: state.message,
                      style: BaseStyle.s14w500,
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ).padH(10.r),
            CustomWidgets.customTextField(
              controller: urlController,
              style: BaseStyle.s11w700,
              label: 'Paste URL',
              labelStyle: BaseStyle.s14w500,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.hex3E3f),
              ),
              filled: true,
              fillColor: AppColors.hexF5f5,
            ).padH(20.r).padV(10.r),
            CustomWidgets.customButton(
              label: 'Search ',
              onTap: () {
                context.read<ImageValidatorBloc>().add(
                  ValidatorImageEvent(urlController.text.trim()),
                );
              },
            ).padH(20.r),
          ],
        ).padBottom(
          MediaQuery.of(context).viewInsets.bottom +
              MediaQuery.of(context).viewPadding.bottom +
              36.r,
        ),
      ),
    );
  }
}
