import 'dart:async';
import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_mvvm_app/Domain/models/models.dart';
import 'package:flutter_mvvm_app/Presentation/base/baseviewmodel.dart';
import 'package:rxdart/subjects.dart';

import '../../../Domain/usecase/store_details_usecase.dart';
import '../../common/state_rendrer/state_renderer_imp.dart';
import '../../common/state_rendrer/state_rendrer.dart';
import '../../resources/strings_manager.dart';

class StoreDetailsViewModel extends BaseViewModel
    with InputStoreDetailsViewModel, OutputStoreDetailsViewModel {
  final StreamController _storeDetailsViewModel =
      BehaviorSubject<StoreDetails>();
  StoreDetailsUSeCase _storeDetailsUSeCase;

  StoreDetailsViewModel(this._storeDetailsUSeCase);

  @override
  void start() {
    getStoreDetails();
  }
  @override
  void dispose() {
    _storeDetailsViewModel.close();
    super.dispose();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsViewModel.sink;

  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsViewModel.stream.map((storeDetails) => storeDetails);

  @override
  getStoreDetails() async {
    stateInput.add(LoadingState(
        stateType: RendrerStateType.fullErrorState,
        message: AppStrings.loadingMessage.tr(),
        title: AppStrings.loading.tr()));

    (await _storeDetailsUSeCase.execute(Void)).fold((failure) {
      stateInput.add(ErrorState(
        stateRendererType: RendrerStateType.fullErrorState,
        message: failure.message,
      ));
    }, // to dismiss the dialogs I have used content state as the extension dismiss before building the content
        (storeDetailsObject) {
      inputStoreDetails.add(StoreDetails(
          about: storeDetailsObject.about,
          title: storeDetailsObject.title,
          services: storeDetailsObject.services,
          image: storeDetailsObject.image,
          details: storeDetailsObject.details));
      stateInput.add(ContentState());
    });
  }
}

abstract class InputStoreDetailsViewModel {
  Sink get inputStoreDetails;
  getStoreDetails();
}

abstract class OutputStoreDetailsViewModel {
  Stream<StoreDetails> get outputStoreDetails;
}
