import 'package:flutter/material.dart';
import 'package:ics321/shared/custom_text.dart';

class TicketCancelation extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final sizes =MediaQuery.of(context).size;
    return SizedBox(
      height: sizes.height/3,
      child: Card(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText("Are Sure You Want To Cancel ? ",
            fontsize: 26,),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomText("Importart Information",
                  color: Colors.red,),
                ),
              ],
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomText(
                    "penalty for ***"
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomText(
                    "penalty for ***"
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomText(
                    "penalty for ***"
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(
                    width: sizes.width/3,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      }, 
                      child: const CustomText("Cancel"),
                                  
                      ),
                  ),
                  SizedBox(
                    width: sizes.width/3,
                    child: ElevatedButton(onPressed: (){}, child: const CustomText("Confirm")))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}