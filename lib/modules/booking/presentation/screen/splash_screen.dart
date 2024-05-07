
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ics321/constants/icons_path.dart';
import 'package:ics321/modules/auth/presentation/screens/login_screen.dart';
import 'package:ics321/modules/home/presentation/screen/home_screen.dart';
import 'package:ics321/shared/custom_text.dart';

class SuccessBookingScreen extends StatefulWidget {
  const SuccessBookingScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return SuccessBookingScreenState();
  }
}

class SuccessBookingScreenState extends State<SuccessBookingScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _iconAnimation;
  late CurvedAnimation _textAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1250));
    _iconAnimation = CurvedAnimation(
        parent: _controller, curve: Curves.fastEaseInToSlowEaseOut);
    _textAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.elasticInOut);
  }

  void startAnimation() async {
    await _controller.forward();
    await _controller.reverse();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context)=>const HomeScreen())
        );
  }
  @override
  void dispose(){
    super.dispose();
    _iconAnimation.dispose();
    _textAnimation.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizes=MediaQuery.of(context).size;
    startAnimation();
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Theme.of(context).colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _iconAnimation,
              child: SizedBox(
                  height: sizes.height*0.3,
                  width: sizes.width*0.8,
                  child: Image.asset(IconsPath.sucessIcon,fit: BoxFit.fill,)),
            ),
            const SizedBox(
              height: 100,
            ),
            ScaleTransition(
                scale: _textAnimation,
                child:  Center(
                  child: CustomText(
                    "orderSent",
                    color: Theme.of(context).colorScheme.primary,
                    fontsize: sizes.width*0.08,
                    
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
