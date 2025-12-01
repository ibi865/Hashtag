import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zakat/helper/shared_preferences.dart';
import 'package:zakat/utils/app_constants.dart';
import 'package:zakat/utils/color_resources.dart';
import 'package:zakat/widgets/custom_button.dart';
import 'package:zakat/widgets/custom_text.dart';

import '../utils/constant_imports.dart';

customErrorDialog(
    BuildContext context,
    String content, {
      Function()? onTapped,
      bool? barrierDismissible,
    }) {
  if(content == AppConstants.networkServerError){
    Navigator.of(context, rootNavigator: true).popUntil((route) {
      return route is! PopupRoute;
    });
  }
  return showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? true,
      builder: (ctx) => AlertDialog(
        title:  Icon(Icons.error, color: Colors.red.shade900, size: 50),
        content: Text(content, textAlign: TextAlign.center),
        actions: <Widget>[
          CustomButton(text: 'OK', buttonColor: Colors.transparent, textColor: Colors.black,fontSize: 14.sp,
            onTap: onTapped ??
                    () async {
                  if (content
                      .toString()
                      .contains('Session has been expired.') || content
                      .toString()
                      .contains('Unauthorized') ||
                      content.toString().contains(
                          'The provided token belongs to a user that no longer exists in our system.')) {
                    await MySharedPrefrences.clearAll();
                    // Navigator.of(ctx).pushNamedAndRemoveUntil(
                    //     LoginScreen.route, (route) => false);
                  } else {
                    Navigator.of(ctx).pop();
                  }
                },
          ),
        ],
      ));
}
customLoaderDialog(
  BuildContext context,
) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Center(
                child: CircularProgressIndicator(
              color: Colors.red.shade800,
            )),
            content: const Text('Please wait...'),
          ));
}

customSuccessDialog(
  BuildContext context,
  String content, {
  Function()? onTapped,
  bool? barrierDismissible,
}) {
  return showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? true,
      builder: (ctx) => AlertDialog(
            title: const Icon(Icons.verified_rounded,
                color: Colors.green, size: 50),
            content: Text(content, textAlign: TextAlign.center),
            actions: <Widget>[

              CustomButton(
                onTap: onTapped ??
                    () {
                      Navigator.of(ctx).pop();
                    },
                    text: 'OK',
                buttonColor: Colors.transparent,
                textColor: Colors.black,
                 fontSize: 14.sp,
              ),
            ],
          ));
}

void customWarningDialog(
    BuildContext context, String content, Function()? onTapped,
    {Function()? onCancel, String? save, String? cancel, Widget? image}) {
  bool isButtonEnabled = false;
  int countdown = 5;
  Timer? timer;
  showDialog(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          void startTimer() {
            timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
              print(countdown);
              if (countdown == 0) {
                setState(() {
                  isButtonEnabled = true;
                });
                t.cancel();
              } else if (countdown > 0) {
                setState(() {
                  countdown--;
                });
              }
            });
          }

          // Start the timer when the dialog is shown
          if (!isButtonEnabled) {
            startTimer();
          }

          return AlertDialog(
            title:
                image ?? const Icon(Icons.error, color: Colors.red, size: 50),
            content: Text(content, textAlign: TextAlign.center,),
            actions: <Widget>[
              CustomButton(
                onTap:
                        () {
                      Navigator.of(ctx).pop();
                    },
                text: 'Cancel',
                textColor: Colors.black,
                 fontSize: 14.sp,
              ),
              SizedBox(height: 5.h,),
              CustomButton(
                onTap: isButtonEnabled ? onTapped : null,
                text: isButtonEnabled ? 'Yes' : '$countdown',
                textColor: Colors.white ,
                buttonColor:  Colors.red.shade900, fontSize: 14.sp,
              ),


            ],
          );
        },
      );
    },
  );
}

void customWarningDialogTwo(
    BuildContext context, String content, Function()? onTapped,
    {Function()? onCancel, String? save, String? cancel}) {
  showDialog(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Icon(Icons.error, color: Colors.red, size: 50),
            content: Text(content, textAlign: TextAlign.center,),
            actions: <Widget>[
              CustomButton(
                onTap:
                        () {
                      Navigator.of(ctx).pop();
                    },
                text: 'Cancel',
                textColor: Colors.black,
               fontSize: 14.sp,
              ),
              SizedBox(height: 5.h,),
              CustomButton(
                onTap: onTapped ,
                text: 'Yes' ,
                textColor: Colors.white ,
                buttonColor:  Colors.red.shade900, fontSize: 14.sp,
              ),
            ],
          );
        },
      );
    },
  );
}

void deleteCustomScheduleDialog(BuildContext context, String content,
    {Function()? onDeleteTapped, Function()? onFollowing, Function()? onAll}) {
  showDialog(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Icon(Icons.error, color: Colors.red, size: 50),
            content: Text(content, textAlign: TextAlign.center,),
            actions: <Widget>[
              if (onDeleteTapped != null)
          CustomButton(
            onTap: onDeleteTapped ,
            text: 'Delete',
            textColor: Colors.black,
             fontSize: 14.sp,
          ),
              SizedBox(height:6.h ,),
              if (onFollowing != null)
                CustomButton(
                  onTap: onFollowing ,
                  text: 'Delete This And Following',
                  textColor: Colors.black,
                   fontSize: 14.sp,
                ),

              // if (onAll != null)
              //   CupertinoDialogAction(
              //     isDefaultAction: false,
              //     onPressed: onAll,
              //     child: CustomText(
              //       text: 'Delete All',
              //       color: Colors.black,
              //       fontSize: 14.sp,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              SizedBox(height:6.h ,),
          CustomButton(
          onTap:() {
              Navigator.of(ctx).pop();
            },
          text: 'Cancel',
          textColor: Colors.white,
          buttonColor: Colors.red.shade900, fontSize: 14.sp,
          ),
            ],
          );
        },
      );
    },
  );
}

void editCustomScheduleDialog(BuildContext context, String content,
    {Function()? onDeleteTapped, Function()? onFollowing, Function()? onAll}) {
  showDialog(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Icon(Icons.error, color: Colors.red, size: 50),
            content: Text(content, textAlign: TextAlign.center,),
            actions: <Widget>[
              if (onDeleteTapped != null)
                CustomButton(
                  onTap: onDeleteTapped ,
                  text: 'Edit',
                  textColor: Colors.black,
                   fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              SizedBox(height:6.h ,),
              if (onFollowing != null)
                CustomButton(
                  onTap: onFollowing ,
                  text: 'Edit This And Following',
                  textColor: Colors.black,
            fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),

              // if (onAll != null)
              //   CupertinoDialogAction(
              //     isDefaultAction: false,
              //     onPressed: onAll,
              //     child: CustomText(
              //       text: 'Edit All',
              //       color: Colors.black,
              //       fontSize: 14.sp,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              SizedBox(height: 6.h,),
              CustomButton(
                onTap:() {
                  Navigator.of(ctx).pop();
                },
                text: 'Cancel',
                textColor: Colors.white,
                buttonColor: Colors.red.shade900, fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ],
          );
        },
      );
    },
  );
}

customMediaDialog({
  required String url,
  required bool isVideo,
  required BuildContext context,
  String? createdAt
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allows the modal to adjust for the keyboard
    backgroundColor:
        Colors.transparent, // Optional: Transparent background for styling
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            toolbarHeight: 100.h,
            title:  const SizedBox(),
            actions: [
              IconButton(
                icon:  Icon(Icons.close, color: Colors.red.shade900),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          body: Center(
              child:  InteractiveViewer(
                minScale: 0.1,
                maxScale: 4.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: url,
                    filterQuality: FilterQuality.high,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                    const Center(
                        child: CircularProgressIndicator(
                          color: Colors.orange,
                        )),
                    errorWidget: (context, url, dynamic error) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellow,
                      ),
                      child: Center(
                        child: Text(
                          'UK',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
        ),
      );
    },
  );
}
