
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mvvm_app/App/app_prefs.dart';
import 'dart:io';
import 'package:flutter_mvvm_app/App/dependency_injection.dart';
import 'package:flutter_mvvm_app/Presentation/common/state_rendrer/state_renderer_imp.dart';
import 'package:flutter_mvvm_app/Presentation/register/register_viewmodel/register_viewmodel.dart';
import 'package:flutter_mvvm_app/Presentation/resources/color_manager.dart';
import 'package:flutter_mvvm_app/Presentation/resources/routes_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../../App/constants.dart';
import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = RegisterViewModel(dIinstance());
  final _imagePicker = dIinstance<ImagePicker>();
  //todo : make dependebcy injection for register view model
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AppPreferences _appPreferences = dIinstance<AppPreferences>();
  void _bind() {
    _viewModel.isUserRegisteredStreamController.stream.listen((isRegistered) {
      if(isRegistered){
        _appPreferences.userLoggedIn();
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });
    userNameController.addListener(() {
      _viewModel.setUserName(userNameController.text);
    });

    emailController.addListener(() {
      _viewModel.setEmail(emailController.text);
    });

    phoneController.addListener(() {
      _viewModel.setMobileNumber(phoneController.text);
    });

    passwordController.addListener(() {
      _viewModel.setPassword(passwordController.text);
    });
  }

  @override
  void initState() {
    _bind();
    _viewModel.start();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorManager.primary),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.stateOutput,
        builder: (context, snapshot) {
          return snapshot.data
                  ?.getScreenWidget(context, getContentWidget(context), () {
                _viewModel.register();
              }) ??
              getContentWidget(context);
        },
      ),
    );
  }

  Widget getContentWidget(BuildContext context) {
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
                child: StreamBuilder<String?>(
                    stream: _viewModel.outputUserNameErrorStreamController,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: userNameController,
                        decoration: InputDecoration(
                            hintText: AppStrings.username.tr(),
                            labelText: AppStrings.username.tr(),
                            errorText: snapshot.data),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.s18,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outPutEmailErrorStreamController,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: AppStrings.email.tr(),
                            labelText: AppStrings.email.tr(),
                            errorText: snapshot.data),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.s18,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outputPasswordErrorStreamController,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        decoration: InputDecoration(
                            hintText: AppStrings.password.tr(),
                            labelText: AppStrings.password.tr(),
                            errorText: snapshot.data),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.s18,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: Row(children: [
                  Expanded(
                    child: CountryCodePicker(
                      onChanged: (country) {
                        // update view model with code
                        _viewModel
                            .setCountryCode(country.dialCode ?? Constants.token);
                      },
                      initialSelection: '+20',
                      favorite: const ['+20','+39', 'FR','AS','CA', "+966",'EN'],
                      // optional. Shows only country name and flag
                      showCountryOnly: true,
                      hideMainText: true,
                      // optional. Shows only country name and flag when popup is closed.
                      showOnlyCountryWhenClosed: true,
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: StreamBuilder<String?>(
                        stream: _viewModel
                            .outputPhoneNumberErrorStreamController,
                        builder: (context, snapshot) {
                          return TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: phoneController,
                            decoration: InputDecoration(
                                hintText: AppStrings.phoneNumber.tr(),
                                labelText: AppStrings.phoneNumber.tr(),
                                errorText: snapshot.data),
                          );
                        }),
                    flex: 4,
                  ),
                ]),
              ),
              const SizedBox(
                height: AppSize.s18,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorManager.grey),
                      borderRadius: BorderRadius.circular(AppPadding.p8)),
                      child: GestureDetector(child: _getMediaWidget(context) ,
                      onTap: (){
                        _showImgPicker(context);
                      },),
                ),
              ),
              const SizedBox(
                height: AppSize.s40,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outputAreAllInputsValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                            onPressed: snapshot.data ??false
                                ? () {
                                    _viewModel.register();
                                  }
                                : null,
                            child: const Text(AppStrings.register).tr()),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p28,
                    right: AppPadding.p28),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(AppStrings.alreadyHaveAnAccount,
                      style: Theme.of(context).textTheme.titleSmall).tr(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getMediaWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p8,right: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //text
          Flexible(child: const Text(AppStrings.profilePicture).tr()),
          //selected img
          Flexible(
            child: StreamBuilder<XFile>(
                stream: _viewModel.outputprofilePictureStreamController,
                builder: (context, snapshot) {
                return  _getSelectdImg(snapshot.data);
              }),
          ),
          //img icon
          Flexible(child: SvgPicture.asset(ImageAssets.cameraIcon))
        ],
      ),
    );
  }

 _getSelectdImg(XFile? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(File(image.path));
    } else {
      return Container();
    }
  }

  void _showImgPicker(BuildContext context) {
    showModalBottomSheet(context: context, builder: (BuildContext context){
      return Wrap(
        children: [
          ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.camera),
              title:const Text(AppStrings.picFromCamera).tr(),
              onTap: (){
                _pickFromCamera();
                Navigator.of(context).pop();
              },
            
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera_alt_outlined),
                title:const Text(AppStrings.picFromGallery).tr(),
              onTap: (){
                _pickFromGallery();
                Navigator.of(context).pop();
              },
          ),
        ],
      );
    });
  }

  void _pickFromCamera() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
    if(image !=null) {
      _viewModel.setProfilePicture(image);
    }else{
      print('no thing picked from camera');
    }
  }

  void _pickFromGallery() async{
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if(image !=null) {
      _viewModel.setProfilePicture(image);
    }else{
      print('no thing picked from gallery');
    }
  }
}
