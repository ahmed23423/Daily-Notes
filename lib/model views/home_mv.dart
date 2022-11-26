import 'package:get/get.dart';

class HomeScreenViewModel extends GetxController {
  Rx<bool> searchIsActive = false.obs;
  RxList<dynamic> rightCroup = [].obs;
  RxList<dynamic> liftCroup = [].obs;


  void hideOrShowSearch() {
    searchIsActive.value = searchIsActive.value ? false : true;
    searchIsActive.refresh();
  }
}
