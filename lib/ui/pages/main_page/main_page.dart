import 'package:auto_route/auto_route.dart';
import 'package:connectinno_case/core/routing/routing.gr.dart';
import 'package:connectinno_case/ui/shared/styles/colors.dart';
import 'package:connectinno_case/ui/shared/styles/text_styles.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [HomeRoute(),SettingsRoute()],
      backgroundColor: AppColors.primaryWhiteColor,
      bottomNavigationBuilder: (context, tabsRouter) {
        final items = [
          {'icon': Icons.home, 'label': "Home"},
          {'icon': Icons.settings, 'label': "Settings"},
        ];
        return Container(
          color: AppColors.primaryWhiteColor,
          height: 80,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(items.length, (index) {
              final selected = tabsRouter.activeIndex == index;
              return GestureDetector(
                onTap: () => tabsRouter.setActiveIndex(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.inputFillColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.inputBorderColor),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        items[index]['icon'] as IconData,
                        color: selected ? AppColors.primaryBlackColor : AppColors.primaryBlackColor.withOpacity(0.5),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        items[index]['label'] as String,
                        style: AppTextStyles.p4Medium.copyWith(
                          color: selected ? AppColors.primaryBlackColor : AppColors.primaryBlackColor.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
