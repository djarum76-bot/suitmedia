import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:suitmedia/bloc/user_bloc.dart';
import 'package:suitmedia/component/app_button.dart';
import 'package:suitmedia/cubit/palindrome_cubit.dart';
import 'package:suitmedia/util/app_theme.dart';
import 'package:suitmedia/util/routes.dart';
import 'package:suitmedia/util/screen_argument.dart';

class FirstScreen extends StatefulWidget{
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late TextEditingController _name;
  late TextEditingController _palindrome;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _name = TextEditingController();
    _palindrome = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _name.dispose();
    _palindrome.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<PalindromeCubit>(context)..isPalindrome(""),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _firstBody(context),
      ),
    );
  }

  Widget _firstBody(BuildContext context){
    return MultiBlocListener(
      listeners: [
        BlocListener<PalindromeCubit, bool?>(
          listener: (context, state){
            if(state == null){
              EasyLoading.dismiss();
            }else{
              if(state){
                EasyLoading.showSuccess("It's a palindrome");
              }else{
                EasyLoading.showSuccess("It's not a palindrome");
              }
            }
          },
        ),
        BlocListener<UserBloc, UserState>(
          listener: (context, state){
            if(state.status == UserStatus.reset){
              Navigator.pushNamed(
                  context,
                  Routes.secondScreen,
                  arguments: ScreenArgument<String>(_name.text)
              );
            }
          },
        )
      ],
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              _firstBodyBottomSection(),
              _firstBodyTopSection(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstBodyBottomSection(){
    return Image.asset(
      "asset/first.jpg",
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    ).blurred(
      colorOpacity: 0.1,
      blur: 25,
    );
  }

  Widget _firstBodyTopSection(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _firstBodyTopLogo(),
              SizedBox(height: 4.h,),
              _firstBodyTopForm(controller: _name, hint: "Name", onChanged: null),
              SizedBox(height: 1.5.h,),
              _firstBodyTopForm(
                  controller: _palindrome,
                  hint: "Palindrome",
                  onChanged: (val){
                    if(val == ""){
                      BlocProvider.of<PalindromeCubit>(context).isPalindrome(val);
                    }
                  }
              ),
              SizedBox(height: 3.h,),
              AppButton(
                  onPressed: (){
                    if(_palindrome.text.isEmpty){
                      EasyLoading.showError("Palindrome form cannot be empty");
                    }else{
                      BlocProvider.of<PalindromeCubit>(context).isPalindrome(_palindrome.text.toLowerCase());
                    }
                  },
                  text: "CHECK"
              ),
              SizedBox(height: 1.5.h,),
              AppButton(
                  onPressed: (){
                    if(_name.text.isEmpty){
                      EasyLoading.showError("Name form cannot be empty");
                    }else{
                      BlocProvider.of<UserBloc>(context).add(UserReset());
                    }
                  },
                  text: "NEXT"
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstBodyTopLogo(){
    return Container(
      width: 75.w,
      height: 12.h,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("asset/logo.png"),
          fit: BoxFit.contain
        )
      ),
    );
  }

  Widget _firstBodyTopForm({required void Function(String)? onChanged, required TextEditingController controller, required String hint}){
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: AppTheme.inputDecoration(hint),
      textCapitalization: TextCapitalization.sentences,
    );
  }
}