import 'package:flutter/cupertino.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/widgets/components/category_item.dart';

class Categories {

  // Sabit olan kategorilerimize her classtan erişebilmek için yapmış olduğumuz class

  static List<Widget> getPersonalImageList() {
    var imgList = [
      Image.asset('assets/categories/dues.png'),
      Image.asset('assets/categories/shopping.png'),
      Image.asset('assets/categories/education.png'),
      Image.asset('assets/categories/entertainment.png'),
      Image.asset('assets/categories/hire.png'),
      Image.asset('assets/categories/selfcare.png'),
      Image.asset('assets/categories/bill.png'),
      Image.asset('assets/categories/health.png'),
      Image.asset('assets/categories/fix.png'),
      Image.asset('assets/categories/holiday.png'),
      Image.asset('assets/categories/food.png'),
      Image.asset('assets/categories/other.png'),
    ];
    return imgList;
  }

  static List<String> getPersonalCategoryListTitles(context) {
    var categoryList = [
      S.of(context).CategoryDues,
      S.of(context).CategoryShopping,
      S.of(context).CategoryEducation,
      S.of(context).CategoryEntertainment,
      S.of(context).CategoryRent,
      S.of(context).CategorySelfcare,
      S.of(context).CategoryPayment,
      S.of(context).CategoryHealth,
      S.of(context).CategoryRepair,
      S.of(context).CategoryVacation,
      S.of(context).CategoryEatDrink,
      S.of(context).CategoryOthers,
    ];
    return categoryList;
  }

  static List<CategoryItem> getPersonalCategories(context) {
    var categoryList = Categories.getPersonalCategoryListTitles(context);
    var imgList = Categories.getPersonalImageList();
    var categories = <CategoryItem>[
      CategoryItem(
          categoryImg: imgList[0], categoryName: categoryList[0], index: 0),
      CategoryItem(
          categoryImg: imgList[1], categoryName: categoryList[1], index: 1),
      CategoryItem(
          categoryImg: imgList[2], categoryName: categoryList[2], index: 2),
      CategoryItem(
          categoryImg: imgList[3], categoryName: categoryList[3], index: 3),
      CategoryItem(
          categoryImg: imgList[4], categoryName: categoryList[4], index: 4),
      CategoryItem(
          categoryImg: imgList[5], categoryName: categoryList[5], index: 5),
      CategoryItem(
          categoryImg: imgList[6], categoryName: categoryList[6], index: 6),
      CategoryItem(
          categoryImg: imgList[7], categoryName: categoryList[7], index: 7),
      CategoryItem(
          categoryImg: imgList[8], categoryName: categoryList[8], index: 8),
      CategoryItem(
          categoryImg: imgList[9], categoryName: categoryList[9], index: 9),
      CategoryItem(
          categoryImg: imgList[10], categoryName: categoryList[10], index: 10),
      CategoryItem(
          categoryImg: imgList[11], categoryName: categoryList[11], index: 11),
    ];
    return categories;
  }

  static List<Widget> getCorporateImageList() {
    var imgListCorporate = [
      Image.asset('assets/categories/rent.png'),
      Image.asset('assets/categories/cash.png'),
      Image.asset('assets/categories/tax (1).png'),
      Image.asset('assets/categories/medical-insurance.png'),
      Image.asset('assets/categories/bill.png'),
      Image.asset('assets/categories/fix.png'),
      Image.asset('assets/categories/food.png'),
      Image.asset('assets/categories/luggage.png'),
      Image.asset('assets/categories/dues.png'),
      Image.asset('assets/categories/gasoline.png'),
      Image.asset('assets/categories/agreement.png'),
      Image.asset('assets/categories/other.png'),
    ];
    return imgListCorporate;
  }

  static List<String> getCorporateCategoryListTitles(context) {
    var corporateCategoryList = [
      S.of(context).CategoryRent,
      S.of(context).CategorySalary,
      S.of(context).CategoryTax,
      S.of(context).CategoryInsurance,
      S.of(context).CategoryBill,
      S.of(context).CategoryEquipment,
      S.of(context).CategoryEatDrink,
      S.of(context).CategoryTravel,
      S.of(context).CategoryDues,
      S.of(context).CategoryGasoline,
      S.of(context).CategoryCorporate,
      S.of(context).CategoryOthers,
    ];
    return corporateCategoryList;
  }

  static List<CategoryItem> getCorporateCategories(context) {
    var categoryList = Categories.getCorporateCategoryListTitles(context);
    var imgList = Categories.getCorporateImageList();
    var categories = <CategoryItem>[
      CategoryItem(
          categoryImg: imgList[0], categoryName: categoryList[0], index: 0),
      CategoryItem(
          categoryImg: imgList[1], categoryName: categoryList[1], index: 1),
      CategoryItem(
          categoryImg: imgList[2], categoryName: categoryList[2], index: 2),
      CategoryItem(
          categoryImg: imgList[3], categoryName: categoryList[3], index: 3),
      CategoryItem(
          categoryImg: imgList[4], categoryName: categoryList[4], index: 4),
      CategoryItem(
          categoryImg: imgList[5], categoryName: categoryList[5], index: 5),
      CategoryItem(
          categoryImg: imgList[6], categoryName: categoryList[6], index: 6),
      CategoryItem(
          categoryImg: imgList[7], categoryName: categoryList[7], index: 7),
      CategoryItem(
          categoryImg: imgList[8], categoryName: categoryList[8], index: 8),
      CategoryItem(
          categoryImg: imgList[9], categoryName: categoryList[9], index: 9),
      CategoryItem(
          categoryImg: imgList[10], categoryName: categoryList[10], index: 10),
      CategoryItem(
          categoryImg: imgList[11], categoryName: categoryList[11], index: 11),
    ];
    return categories;
  }
}
