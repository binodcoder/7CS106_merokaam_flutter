import 'dart:async';
import '../../../core/models/model.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/strings_manager.dart';
import 'package:merokaam/layers/presentation/base/baseviewmodel.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  //stream controllers
  final StreamController<SliderViewObject> _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int currentIndex = 0;
  //inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    //send this slider data to our view
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = currentIndex++; //+1
    if (nextIndex >= _list.length) {
      currentIndex = 0; // infinite loop to go to first item inside the slider
    }
    return currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = currentIndex--; //-1
    if (previousIndex == -1) {
      currentIndex = _list.length - 1; // infinite loop to go to the length of slider list
    }

    return currentIndex;
  }

  @override
  void onPageChanged(int index) {
    currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

//outputs
  @override
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.asBroadcastStream().map((slideViewObject) => slideViewObject);

// private functions
  List<SliderObject> _getSliderData() => [
        SliderObject(
          title: AppStrings.onBoardingTItle1,
          subTitle: AppStrings.onBoardingSubTitle1,
          image: ImageAssets.onBoardingLogo1,
        ),
        SliderObject(
          title: AppStrings.onBoardingTItle2,
          subTitle: AppStrings.onBoardingSubTitle2,
          image: ImageAssets.onBoardingLogo2,
        ),
        SliderObject(
          title: AppStrings.onBoardingTItle3,
          subTitle: AppStrings.onBoardingSubTitle3,
          image: ImageAssets.onBoardingLogo3,
        ),
        SliderObject(
          title: AppStrings.onBoardingTItle4,
          subTitle: AppStrings.onBoardingSubTitle4,
          image: ImageAssets.onBoardingLogo4,
        ),
      ];

  _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(_list[currentIndex], _list.length, currentIndex));
  }
}

//inputs mean the orders that our view model will receive from our view
mixin OnBoardingViewModelInputs {
  void goNext(); //when user clicks on right arrow or swipe left.
  void goPrevious(); //when user clicks on left arrow or swipe right.
  void onPageChanged(int index);

  Sink get inputSliderViewObject; //this is the way to add data to the stream .. stream input
}

//outputs mean data or results that will be sent from our vie model to our view
mixin OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject? sliderObject;
  int? numOfSlides;
  int? currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
