import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/core/utils/utils.dart';
import 'package:ics321/modules/home/presentation/provider/providers.dart';
import 'package:ics321/modules/home/presentation/widget/profile_text_field.dart';
import 'package:ics321/shared/custom_button.dart';
import 'package:ics321/shared/custom_text.dart';

class ProfileCard extends ConsumerWidget{
  static GlobalKey<FormState> formKey_=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final homeState= ref.watch(homeControllerProvider);
    final sizes=MediaQuery.of(context).size;
    return  Form(
      key: formKey_,
      child: Card(
        child: SizedBox(
          width: sizes.width*0.85,
            height: 300,
          child:  Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ProfileTextField(type: Type.email),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ProfileTextField(type: Type.name),
              ),
              const Spacer(),
              Builder(
                builder: (context) {
                  {
                          if (homeState is HomeLoading){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const CircularProgressIndicator(),
                            );
                          }
                          
                        }
                  return SizedBox(
                    width: sizes.width*0.4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:CustomButton(child: CustomText("update".tr()), onPressed: (){
                       
                            if(formKey_.currentState!.validate()){
                              ref.read(homeControllerProvider.notifier).updateUserInfo(
                                email: ref.read(homeControllerProvider.notifier).inputEmail,
                                name:ref.read(homeControllerProvider.notifier).inputName);
                            }
                          }),


                      ),
                    
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }

}