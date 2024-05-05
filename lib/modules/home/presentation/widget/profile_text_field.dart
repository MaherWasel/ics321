import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/core/utils/utils.dart';
import 'package:ics321/modules/home/presentation/provider/providers.dart';

enum Type{email,name}

class ProfileTextField extends ConsumerWidget{
  
  const ProfileTextField({super.key, required this.type});
  final Type type;
  @override
  Widget build(BuildContext context,WidgetRef ref) {

    return TextFormField(
        validator: (value){
          if (type == Type.email){
            if (value ==null||!value.contains("@")||value.isEmpty){
              return "emailInValid".tr();
            }
            ref.read(homeControllerProvider.notifier).inputEmail=value;
            return null;
          }
          else {
            if (value ==null||value.isEmpty){
              return "nameInValid".tr();
            }
            ref.read(homeControllerProvider.notifier).inputName=value;
            return null;
          }
                                        },

        keyboardType: TextInputType.emailAddress,
        onTapOutside: (evenet)=>FocusManager.instance.primaryFocus?.unfocus(),
        decoration: InputDecoration(
          
          hintText: type==Type.name?( (Utils.user?.name!=null&&Utils.user!.name!.isNotEmpty)?Utils.user?.name: "name"): ((Utils.user?.email!=null)?Utils.user?.email:"email@gmail.com" ),
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
      )

    ;
  }

}