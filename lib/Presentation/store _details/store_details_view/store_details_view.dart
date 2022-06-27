import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_app/Domain/models/models.dart';
import 'package:flutter_mvvm_app/Presentation/common/state_rendrer/state_renderer_imp.dart';
import 'package:flutter_mvvm_app/Presentation/resources/color_manager.dart';
import 'package:flutter_mvvm_app/Presentation/resources/strings_manager.dart';
import 'package:flutter_mvvm_app/Presentation/resources/values_manager.dart';
import 'package:flutter_mvvm_app/Presentation/store%20_details/store_details_viewmodel/store_details_viewmode;.dart';

import '../../../App/dependency_injection.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({Key? key}) : super(key: key);

  @override
  _StoreDetailsViewState createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _viewModel = dIinstance<StoreDetailsViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.details).tr(),
        ),
        backgroundColor: ColorManager.white,
        body: StreamBuilder<FlowState>(
          stream: _viewModel.stateOutput,
          builder: (context, snapshot) =>
              snapshot.data
                  ?.getScreenWidget(context, _getContentWidget(context), () {
                _viewModel.start();
              }) ??
              _getContentWidget(context),
        ));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Widget _getContentWidget(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: StreamBuilder<StoreDetails>(
            stream: _viewModel.outputStoreDetails,
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getImage(snapshot.data!.image),
                    _getSection(AppStrings.details.tr()),
                    _getBody(snapshot.data!.details),
                    _getSection(AppStrings.services.tr()),
                    _getBody(snapshot.data!.services),
                    _getSection(AppStrings.aboutStore.tr()),
                    _getBody(snapshot.data!.about),
                  ]);
              }
              return Container();
            }),
      ),
    );
  }

  Widget _getBody(String bodyText) {
    return Text(
      bodyText,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }

  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }

  _getImage(String image) {
    return SizedBox(
      width: double.infinity,
      child: Image(
        image: NetworkImage(image),
        fit: BoxFit.cover,
        height: AppSize.s140,
      ),
    );
  }
}
