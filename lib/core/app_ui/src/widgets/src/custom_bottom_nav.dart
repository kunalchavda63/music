import 'package:music/core/app_ui/app_ui.dart';

class CustomBottomNav extends StatelessWidget {
  final List<BottomNavModel> bottomNavList;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final Color? bgColor;
  final double? iconSize;
  final double? unSelectedFontSize;
  final bool? showSelectedLabels;
  final TextStyle? unSelectedLabelStyle;
  final TextStyle? selectedLabelStyle;
  final Color? selectedItemColor;
  final Color? unSelectedItemColor;
  final double? selectedFontSize;
  final bool? showUnSelectedLabels;





  const CustomBottomNav({
    super.key,
    required this.bottomNavList,
    this.currentIndex = 0,
    this.onTap,
    this.bgColor,
    this.iconSize,
    this.unSelectedFontSize,
    this.showSelectedLabels,
    this.unSelectedLabelStyle,
    this.selectedLabelStyle,
    this.selectedItemColor,
    this.selectedFontSize,
    this.showUnSelectedLabels,
    this.unSelectedItemColor,
  });

  // too addsome parameter
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: unSelectedItemColor,
      backgroundColor:bgColor?? AppColors.hex1212,
      iconSize: iconSize??20,

      unselectedFontSize: unSelectedFontSize??20,
      showSelectedLabels: showSelectedLabels,
      unselectedLabelStyle:unSelectedLabelStyle ?? BaseStyle.s8w700.c(AppColors.hexF2c9),
      selectedLabelStyle:selectedLabelStyle?? BaseStyle.s10w700.c(AppColors.hexF2c9),
      selectedItemColor:selectedItemColor,
      selectedFontSize:selectedFontSize?? 0,
      showUnselectedLabels:showUnSelectedLabels?? false,

      currentIndex: currentIndex,
      onTap: onTap,
      items:
          bottomNavList.map((item) {
            return BottomNavigationBarItem(
              icon: Icon(item.icon,color: unSelectedItemColor,),
              activeIcon: Icon(item.icon,color: selectedItemColor,),
              label: item.label,



            );
          }).toList(),
    );
  }
}
