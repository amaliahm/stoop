// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/pages.dart';
import '../../components/onboarding/center_next_button.dart';
import '../../components/onboarding/travel_easy.dart';
import '../../components/onboarding/choose_what_helps_you.dart';
import '../../components/onboarding/search_anytime.dart';
import '../../components/onboarding/splash_view.dart';
import '../../components/onboarding/top_back_skip_view.dart';
import '../../components/onboarding/welcome_view.dart';
import '../../components/onboarding/contact_the_driver.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 12));
    _animationController?.forward();

  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ClipRect(
        child: Stack(
          children: [
            SplashView(
              animationController: _animationController!
            ),
            TravelEasy(
              animationController: _animationController!
            ),
            ContactTheDriver(
              animationController: _animationController!
            ),
            SearchAnytime(
              animationController: _animationController!
            ),
            ChooseWhatHelpsYou(
              animationController: _animationController!
            ),
            WelcomeView(
              animationController: _animationController!
            ),
            TopBackSkipView(
              onBackClick: _onBackClick,
              onSkipClick: _onSkipClick,
              animationController: _animationController!,
            ),
            CenterNextButton(
              animationController: _animationController!,
              onNextClick: _onNextClick,
            ),
          ],
        ),
      ),
    );
  }

  void _onSkipClick() {
    _animationController?.animateTo(1.0,
        duration: const Duration(milliseconds: 1400));
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.8 &&
        _animationController!.value <= 1.0) {
      _animationController?.animateTo(0.8);
    } else if (_animationController!.value > 1.0 &&
        _animationController!.value <= 1.2) {
      _animationController?.animateTo(1.0);
    }
  }

  void _onNextClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.8);
    }  else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _animationController?.animateTo(1.0);
    } else if (_animationController!.value > 0.8 &&
        _animationController!.value <= 1.0) {
      Get.toNamed(Routes.SIGNUP);
    }
  }
}
