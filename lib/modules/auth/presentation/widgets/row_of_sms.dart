import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/modules/auth/presentation/provider/providers.dart';

class RowOfSmS extends ConsumerWidget{
  const RowOfSmS({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final sizes=MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(2),
          width: sizes.width/7,
          child: TextFormField(
            textAlign: TextAlign.center,
          validator: (value){
            if (value==null || value.length!=1){
              return "";
            }
            ref.read(authStateProvider.notifier).modifySmS(index: 0, smsValue: value);
            return null;
          },
          onChanged: (value){
            FocusScope.of(context).nextFocus();
          },
          onTapOutside: (evenet)=>FocusManager.instance.primaryFocus?.unfocus(),
          maxLength: 1,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            counterText: "",
            border: OutlineInputBorder(    
                                 
          borderRadius:BorderRadius.circular(30))
          ),
          
        )),
        Container(
          margin: const EdgeInsets.all(2),
          width: sizes.width/7,
          child: TextFormField(
                        textAlign: TextAlign.center,

          validator: (value){
            if (value==null || value.length!=1){
              return "";
            }
            ref.read(authStateProvider.notifier).modifySmS(index: 1, smsValue: value);
            return null;
          },
          onChanged: (value){
            FocusScope.of(context).nextFocus();
          },
          onTapOutside: (evenet)=>FocusManager.instance.primaryFocus?.unfocus(),
          maxLength: 1,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            counterText: "",
            border: OutlineInputBorder(    
                                 
          borderRadius:BorderRadius.circular(30))
          ),
          
        )),
        Container(
          margin: const EdgeInsets.all(2),

          width: sizes.width/7,
          child: TextFormField(
                        textAlign: TextAlign.center,

          validator: (value){
            if (value==null || value.length!=1){
              return "";
            }
            ref.read(authStateProvider.notifier).modifySmS(index: 2, smsValue: value);
            return null;
          },
          onChanged: (value){
            FocusScope.of(context).nextFocus();
          },
          onTapOutside: (evenet)=>FocusManager.instance.primaryFocus?.unfocus(),
          maxLength: 1,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            counterText: "",
            border: OutlineInputBorder(    
                                 
          borderRadius:BorderRadius.circular(30))
          ),
          
        )),
        Container(
          margin: const EdgeInsets.all(2),
          width: sizes.width/7,
          child: TextFormField(
                        textAlign: TextAlign.center,

          validator: (value){
            if (value==null || value.length!=1){
              return "";
            }
            ref.read(authStateProvider.notifier).modifySmS(index: 3, smsValue: value);
            return null;
          },
          onTapOutside: (evenet)=>FocusManager.instance.primaryFocus?.unfocus(),
          onChanged: (value){
            FocusScope.of(context).nextFocus();
          },
          maxLength: 1,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            counterText: "",
            border: OutlineInputBorder(    
                                 
          borderRadius:BorderRadius.circular(30))
          ),
          
        )),
        Container(
          margin: const EdgeInsets.all(2),
          width: sizes.width/7,
          child: TextFormField(
                        textAlign: TextAlign.center,

          validator: (value){
            if (value==null || value.length!=1){
              return "";
            }
            ref.read(authStateProvider.notifier).modifySmS(index: 4, smsValue: value);
            return null;
          },
          onChanged: (value){
            FocusScope.of(context).nextFocus();
          },
          onTapOutside: (evenet)=>FocusManager.instance.primaryFocus?.unfocus(),
          maxLength: 1,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            counterText: "",
            border: OutlineInputBorder(    
                                 
          borderRadius:BorderRadius.circular(30))
          ),
          
        )),
        Container(
          margin: const EdgeInsets.all(2),
          width: sizes.width/7,
          child: TextFormField(
                        textAlign: TextAlign.center,
                        

          validator: (value){
            if (value==null || value.length!=1){
              return "";
            }
            ref.read(authStateProvider.notifier).modifySmS(index: 5, smsValue: value);
            return null;
          },
          onChanged: (value){
            FocusScope.of(context).nextFocus();
          },
          maxLength: 1,
          keyboardType: TextInputType.number,
          onTapOutside: (evenet)=>FocusManager.instance.primaryFocus?.unfocus(),
          decoration: InputDecoration(
            
            counterText: "",
            border: OutlineInputBorder(    
                                 
          borderRadius:BorderRadius.circular(30))
          ),
          
        )),

      ],
    );
  }

}