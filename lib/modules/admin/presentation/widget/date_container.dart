import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ics321/modules/admin/presentation/provider/provider.dart';
import 'package:ics321/modules/admin/presentation/screen/admin_date_report.dart';
import 'package:ics321/modules/admin/presentation/widget/admin_plane_card.dart';
import 'package:ics321/shared/custom_text.dart';

class DateContainer extends ConsumerStatefulWidget{
   DateContainer({super.key});

  @override
 ConsumerState<DateContainer> createState() => _DateContainerState();
}

class _DateContainerState extends ConsumerState<DateContainer> {
   DateTime? selectedDate;
    bool forPlane=false;
  getFormatedDate(DateTime _date, bool time) {

    if (time){
    return DateFormat.jms().format(_date);
     

    }
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(_date);

    }

  @override
  Widget build(BuildContext context) {
    final sizes=MediaQuery.of(context).size;
    final adminStates=ref.watch(adminControllerProvider);
    return SizedBox(
      width: sizes.width*0.8,
      height: selectedDate==null?100: 250,
      child: Card(
        margin: const EdgeInsets.all(8),
        child: 
        Column(
          children: [
            CustomText("selectDateToGenerateReports".tr(),
            color: Theme.of(context).colorScheme.primary,),
            Row(
              children: [
                IconButton(onPressed: ()async{
                  final date= await showDatePicker(context: context, firstDate:DateTime(2024), lastDate:DateTime(2025));
                  selectedDate=date;
                  setState(() {
                    
                  });
                }, icon: const Icon(Icons.calendar_month,
                )),
                if (selectedDate!=null)
            CustomText(getFormatedDate(selectedDate!, false))
              ],
            ),

            if (selectedDate!=null)
            ListTile(
      leading: const Icon(FontAwesomeIcons.plane),
      title:  Text('reportForPlane?'.tr()),
      trailing: Icon(forPlane?Icons.radio_button_checked:(Icons.radio_button_off)),
      onTap: (){
        setState(() {
          forPlane=!forPlane;
        });
      },
    ),
            if (selectedDate!=null)
            Builder(
              builder: (context) {
                if (adminStates is AdminLoading){
                  return const Center(child: CircularProgressIndicator());
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: ()async{
                    if (forPlane){
                      final response = await ref.read(adminControllerProvider.notifier).getPlaneReport(date: selectedDate!);
                      if(response==null || response.isEmpty){
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Flights were found for that date")));
                      return;

                      }
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdminPlaneCard(listOfPlanes: response!)));

                      return;
                    }
                    final response = await ref.read(adminControllerProvider.notifier).getFlightReport(date: selectedDate!);
                    if (response==null || response.isEmpty){
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Flights were found for that date")));
                    }
                    else {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdminDateReport(listOfFligts: response)));
                    }

                  }, child:  Text("generate".tr())),
                );
              }
            )
            
          ],
        ),
      ),
    );
  }
}