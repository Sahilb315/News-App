import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/features/home/model/news_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeBannerView extends StatefulWidget {
  final List<NewsModel> topStories;
  const HomeBannerView({
    super.key,
    required this.topStories,
  });

  @override
  State<HomeBannerView> createState() => _HomeBannerViewState();
}

class _HomeBannerViewState extends State<HomeBannerView> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(
      const Duration(seconds: 3),
      (Timer timer) {
        if (pageController.hasClients && currentIndex < 5) {
          currentIndex++;
          pageController.animateToPage(
            currentIndex,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
        }
        currentIndex = -1;
      },
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 1,
          height: MediaQuery.sizeOf(context).height * 0.24,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            onPageChanged: (index) {
              currentIndex = index;
            },
            controller: pageController,
            itemCount: widget.topStories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.topStories[index].urlToImage.toString(),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        height: 50,
                        width: MediaQuery.sizeOf(context).width * 0.95,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child: Text(
                          widget.topStories[index].title.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Align(
          alignment: Alignment.center,
          child: SmoothPageIndicator(
            effect: WormEffect(
              dotColor: Colors.grey.shade400,
              activeDotColor: Colors.blue,
              dotHeight: 8,
              dotWidth: 8,
            ),
            controller: pageController,
            count: 5,
          ),
        ),
      ],
    );
  }
}
