import 'package:logger/logger.dart';
import 'package:mvvm_template/core/models/other/onboarding.dart';
import 'package:mvvm_template/core/others/base_view_model.dart';
import 'package:mvvm_template/core/services/local_storage_service.dart';
import 'package:mvvm_template/locator.dart';
import 'package:carousel_slider/carousel_controller.dart';

class OnboardingViewModel extends BaseViewModel {
  final Logger log = Logger();
  late int currentPageIndex;
  late List<Onboarding> onboardingList;
  final _localStorageService = locator<LocalStorageService>();
  late CarouselController controller = CarouselController();

  OnboardingViewModel(this.currentPageIndex, this.onboardingList);

  updatePage(index) {
    log.d('@updateOnboarding page with index: $index');
    currentPageIndex = index;
    _localStorageService.onBoardingPageCount = index;
    notifyListeners();
  }
}
