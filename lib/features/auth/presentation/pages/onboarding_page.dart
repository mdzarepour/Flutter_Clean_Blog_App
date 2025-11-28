import 'package:animate_do/animate_do.dart';
import 'package:blog/core/common/constants/app_colors.dart';
import 'package:blog/core/common/constants/app_strings.dart';
import 'package:blog/core/router/router_names.dart';
import 'package:blog/features/auth/presentation/widgets/onboarding_button.dart';
import 'package:blog/features/auth/presentation/widgets/onboarding_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with AutomaticKeepAliveClientMixin {
  final pageController = PageController();
  int page = 0;

  final onboardingWidgets = [
    OnboardingWidget(
      title: OnboardingStrings.firstPageTitle,
      description: OnboardingStrings.firstPageDescription,
    ),
    OnboardingWidget(
      title: OnboardingStrings.secondPageTitle,
      description: OnboardingStrings.secondPageDescription,
    ),
    OnboardingWidget(
      title: OnboardingStrings.thirdPageTitle,
      description: OnboardingStrings.secondPageTitle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            children: onboardingWidgets,
            onPageChanged: (value) {
              setState(() {
                page = value;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _pageIndicator(),
                SizedBox(height: 30),
                _controllerButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _controllerButtons() {
    if (page != onboardingWidgets.length - 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          OnboardingButton(
            onPressed: () {
              pageController.animateToPage(
                onboardingWidgets.length - 1,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
              );
            },
            title: OnboardingStrings.skip,
          ),
          OnboardingButton(
            onPressed: () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
              );
            },
            title: OnboardingStrings.next,
          ),
        ],
      );
    } else {
      return FadeInUp(
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 600),
        from: 10,
        child: Row(
          children: [
            OnboardingButton(
              onPressed: () => context.go(RouterNames.signinPage),
              title: OnboardingStrings.start,
            ),
          ],
        ),
      );
    }
  }

  Widget _pageIndicator() {
    return SmoothPageIndicator(
      controller: pageController,
      count: onboardingWidgets.length,
      effect: ExpandingDotsEffect(
        dotColor: AppColors.materialThirdBlue,
        activeDotColor: AppColors.materialGrey,
        dotHeight: 8,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
