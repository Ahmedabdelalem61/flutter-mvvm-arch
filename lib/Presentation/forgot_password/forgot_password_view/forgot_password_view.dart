
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_app/App/dependency_injection.dart';
import 'package:flutter_mvvm_app/Presentation/common/state_rendrer/state_renderer_imp.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../forgot_password_view_model/forgot_password_view_model.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>_ForgotPasswordView();
}

class _ForgotPasswordView extends State<ForgotPasswordView> {
  final ForgotPasswordViewModel _viewModel = dIinstance<ForgotPasswordViewModel>();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.stateOutput,
        builder: (context, snapshot) =>
            snapshot.data
                ?.getScreenWidget(context, _getContentWidget(), () {}) ??
            _getContentWidget(),
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      color: ColorManager.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Center(
                  child: Image(image: AssetImage(ImageAssets.splashLogo))),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                    stream: _viewModel.OutputIsEmailValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                            hintText: AppStrings.enterYourEmail.tr(),
                            labelText: AppStrings.email.tr(),
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.emailError.tr()),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                    stream: _viewModel.OutputIsEmailValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    _viewModel.forgotPassword();
                                  }
                                : null,
                            child: const Text(AppStrings.forgotPassword).tr()),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

