import 'package:flutter/cupertino.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/widgets/components/category_item.dart';

class Categories {

  // Sabit olan kategorilerimize her classtan erişebilmek için yapmış olduğumuz class

  static List<Widget> getPersonalImageList() {
    var imgList = [
      Image.asset('assets/categories/cash.png'),
      Image.asset('assets/categories/sales.png'),
      Image.asset('assets/categories/competition.png'),
      Image.asset('assets/categories/investment.png'),
      Image.asset('assets/categories/rent.png'),
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
      Image.asset('assets/categories/mining.png'),
      Image.asset('assets/categories/other.png'),
    ];
    return imgList;
  }
  // satış ,
  // mining , yatırım , yarışma
  static List<String> getPersonalCategoryListTitles(context) {
    var categoryList = [
      S.of(context).CategorySalary,
      S.of(context).CategorySales,
      S.of(context).CategoryCompetition,
      S.of(context).CategoryInvestment,
      S.of(context).CategoryRent,
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
      S.of(context).CategoryCrypto,
      S.of(context).CategoryOthers,
    ];
    return categoryList;
  }

  static List<Widget> getCorporateImageList() {
    var imgListCorporate = [
      Image.asset('assets/categories/cash.png'),
      Image.asset('assets/categories/sales.png'),
      Image.asset('assets/categories/investment.png'),
      Image.asset('assets/categories/rent.png'),
      Image.asset('assets/categories/tax (1).png'),
      Image.asset('assets/categories/medical-insurance.png'),
      Image.asset('assets/categories/bill.png'),
      Image.asset('assets/categories/fix.png'),
      Image.asset('assets/categories/food.png'),
      Image.asset('assets/categories/luggage.png'),
      Image.asset('assets/categories/dues.png'),
      Image.asset('assets/categories/gasoline.png'),
      Image.asset('assets/categories/agreement.png'),
      Image.asset('assets/categories/mining.png'),
      Image.asset('assets/categories/other.png'),
    ];
    return imgListCorporate;
  }

  static List<String> getCorporateCategoryListTitles(context) {
    var corporateCategoryList = [
      S.of(context).CategorySalary,
      S.of(context).CategorySales,
      S.of(context).CategoryInvestment,
      S.of(context).CategoryRent,
      S.of(context).CategoryTax,
      S.of(context).CategoryInsurance,
      S.of(context).CategoryBill,
      S.of(context).CategoryEquipment,
      S.of(context).CategoryEatDrink,
      S.of(context).CategoryTravel,
      S.of(context).CategoryDues,
      S.of(context).CategoryGasoline,
      S.of(context).CategoryCorporate,
      S.of(context).CategoryCrypto,
      S.of(context).CategoryOthers,
    ];
    return corporateCategoryList;
  }

  static List<CategoryItem> getCategories(context,bool isPersonal) {

    var categories = <CategoryItem>[];
    List categoryList;
    var imgList;

    if(isPersonal){
      categoryList = Categories.getPersonalCategoryListTitles(context);
      imgList = Categories.getPersonalImageList();
    }
    else{
      categoryList = Categories.getCorporateCategoryListTitles(context);
      imgList = Categories.getCorporateImageList();
    }
    for(int i = 0 ; i<categoryList.length ; i++){
      var item = CategoryItem(categoryImg: imgList[i], categoryName: categoryList[i], index: i);
      categories.add(item);
    }
    return categories;

  }
}