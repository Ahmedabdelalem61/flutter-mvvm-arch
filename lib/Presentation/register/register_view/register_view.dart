import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_app/App/dependency_injection.dart';
import 'package:flutter_mvvm_app/Presentation/common/state_rendrer/state_renderer_imp.dart';
import 'package:flutter_mvvm_app/Presentation/register/register_viewmodel/register_viewmodel.dart';
import 'package:flutter_mvvm_app/Presentation/resources/color_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final RegisterViewModel _viewModel = RegisterViewModel(dIinstance());
  //todo : make dependebcy injection for register view model
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _bind() {
    userNameController.addListener(() {
      _viewModel.setUserName(userNameController.text);
    });

    emailController.addListener(() {
      _viewModel.setEmail(emailController.text);
    });

    phoneController.addListener(() {
      _viewModel.setEmail(phoneController.text);
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorManager.primary),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.stateOutput,
        builder: (context,snapshot){
          return snapshot.data?.getScreenWidget(context,getContentWidget(context),(){_viewModel.register();})
           ?? getContentWidget(context);
        },
      ),
    );
  }

  Widget getContentWidget(BuildContext context){
    return Container();
  }

}
