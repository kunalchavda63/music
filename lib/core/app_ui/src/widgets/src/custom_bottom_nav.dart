import 'package:music/core/app_ui/app_ui.dart';

class CustomBottomNav extends StatelessWidget {
  final List<BottomNavModel> bottomNavList;
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const CustomBottomNav({
    super.key,
    required this.bottomNavList,
    this.currentIndex = 0,
    this.onTap,
  });

  // too addsome parameter
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: AppColors.hex1212,
      iconSize: 20,
      showSelectedLabels: true,
      unselectedLabelStyle: BaseStyle.s8w700.c(AppColors.hexF2c9),
      selectedLabelStyle: BaseStyle.s10w700.c(AppColors.hexF2c9),
      selectedItemColor: AppColors.hexF2c9,
      unselectedItemColor: AppColors.hex7777,
      selectedFontSize: 0,
      showUnselectedLabels: false,

      currentIndex: currentIndex,
      onTap: onTap,
      items:
          bottomNavList.map((item) {
            return BottomNavigationBarItem(
              icon: Icon(item.icon),
              activeIcon: Icon(item.icon,color: AppColors.hexF2c9,),
              label: item.label,



            );
          }).toList(),
    );
  }
}
