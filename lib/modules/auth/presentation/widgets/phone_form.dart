import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/modules/auth/presentation/provider/providers.dart';

class PhoneForm extends ConsumerWidget{
  const PhoneForm({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final sizes= MediaQuery.of(context).size;
    
    return SizedBox(
      width: sizes.width*0.8,

      child: TextFormField(
        validator: (value){
          if (value == null ||
          value.isEmpty ||
          value.length!=10) {
          return "Please Enter Valid PhoneNumber".tr();
          }
          ref.read(authStateProvider.notifier).phoneNum="+966${value.substring(1)}";
          return null;
                                        },
        maxLength: 10,
        keyboardType: TextInputType.phone,
        onTapOutside: (evenet)=>FocusManager.instance.primaryFocus?.unfocus(),
        decoration: InputDecoration(
          
          hintText: "05********".tr(),
          counterText: "",
          focusedBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(30),
            borderSide:  BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2.0),
                                            ),
         border: OutlineInputBorder(                       
          borderRadius:
          BorderRadius.circular(30))
        ),
      ));
  }

}