import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/core/utils/utils.dart';
import 'package:ics321/modules/auth/presentation/provider/providers.dart';
import 'package:ics321/modules/auth/presentation/widgets/row_of_sms.dart';
import 'package:ics321/modules/auth/presentation/widgets/sms_icon.dart';
import 'package:ics321/shared/custom_button.dart';
import 'package:ics321/shared/custom_text.dart';

class VerifySmSContainer extends ConsumerWidget{
  static GlobalKey<FormState> formKey_=GlobalKey<FormState>();

  const VerifySmSContainer({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final sizes =MediaQuery.of(context).size;
    final authStates =ref.watch(authStateProvider);
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
              const SmSIcon(),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Utils.appOnAr?Alignment.centerRight:Alignment.centerLeft,
                  child: CustomText(
                    "enterSMS".tr(),
                    fontsize: sizes.width*0.045,
                    color: Theme.of(context).colorScheme.primary,
                    weight: FontWeight.w500,),
                ),
              ),
              const RowOfSmS(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: sizes.width*0.6,
                  height: 50,
                  child: Builder(
                    builder: (context){
                      if (authStates is AuthLoading){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      else {
                        return CustomButton(child: LayoutBuilder(
                      builder:(context,constrains)=> CustomText(
                        "submit".tr(),
                        fontsize: constrains.maxWidth*0.12,
                      )), onPressed: ()async {
          
                        if(formKey_.currentState!.validate()) {
                        await ref.read(authStateProvider.notifier).confirmSmS();
                        if (Utils.userId.isEmpty){
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("error")));

                        }

                        }
          
          
                      });
                      }
                    },
          
                  )),
              )
            ],
          ),
        )),
    );
  }

}