import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/core/utils/utils.dart';
import 'package:ics321/modules/auth/presentation/provider/providers.dart';
import 'package:ics321/modules/auth/presentation/widgets/login_icon.dart';
import 'package:ics321/modules/auth/presentation/widgets/phone_form.dart';
import 'package:ics321/shared/custom_button.dart';
import 'package:ics321/shared/custom_text.dart';

class LoginContainer extends ConsumerWidget {
  const LoginContainer({super.key});
  static GlobalKey<FormState> formKey_=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStates= ref.watch(authStateProvider);
    final sizes = MediaQuery.of(context).size;
    
    return Container(
      width: double.infinity,

      margin: const EdgeInsets.all(8),
      
      child: Form(
        key: formKey_,
        child: SingleChildScrollView(
          child: Column(
          
            children: [
              const SizedBox(
                height: 100,
              ),
              LoginIcon(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomText(
                      "enterPhone".tr(),
                      fontsize: sizes.width*0.045,
                      color: Theme.of(context).colorScheme.primary,
                      weight: FontWeight.w500,),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: PhoneForm(),
              ),
          
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: sizes.width*0.6,
                  height: 50,
                  child: Builder(
                    builder: (context){
                      if (authStates is AuthLoading){
                        return const Center(
                          child: const CircularProgressIndicator(),
                        );
                      }
                      else {
                        return CustomButton(child: LayoutBuilder(
                      builder:(context,constrains)=> CustomText(
                        "submit".tr(),
                        fontsize: constrains.maxWidth*0.12,
                      )), onPressed: ()async {
          
                        if(formKey_.currentState!.validate()){
                          await ref.read(authStateProvider.notifier).sendOtp();
                        }
          
          
                      });
                      }
                    },
          
                  )),
              )
          
            ],
          ),
        ),
      ),
    );
  }
}
