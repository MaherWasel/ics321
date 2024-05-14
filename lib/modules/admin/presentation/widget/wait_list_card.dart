import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ics321/modules/admin/presentation/provider/provider.dart';
import 'package:ics321/modules/my_tickets/presentation/widget/seats_picker.dart';
import 'package:ics321/shared/custom_button.dart';
import 'package:ics321/shared/custom_text.dart';
import 'package:ics321/shared/models/ticket.dart';
import 'package:ics321/shared/plane_info.dart';

class WaitListCard extends ConsumerStatefulWidget{
  final Ticket ticket;
  const WaitListCard({super.key, required this.ticket});

  @override
  ConsumerState<WaitListCard> createState() => _WaitListCardState();
}

class _WaitListCardState extends ConsumerState<WaitListCard> {
  getFormatedDate(DateTime _date, bool time) {

    if (time){
    return DateFormat.jms().format(_date);
     

    }
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(_date);

    }
  bool hide=false;
  @override
  Widget build(BuildContext context) {
    final adminStates = ref.watch(adminControllerProvider);
    if (hide){
      return const SizedBox.shrink();
    }
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (widget.ticket.status!="Cancelled")
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0,
                  vertical: 2),
                  child: TextButton(
                    onPressed: (){

                    },
                    child:  Row(
                      children: [
                        CustomText("deleteTicket".tr()),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Icon(Icons.delete),
                        ),
                      ],
                    )),
                )
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.flight_takeoff),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.ticket.flight!.source),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.flight_land),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(widget.ticket.flight!.destination),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.calendar_month),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(getFormatedDate(widget.ticket.flight!.date,false)),
                ),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.schedule),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(getFormatedDate(widget.ticket.flight!.time, true)),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextButton(onPressed: ()async{
                    final response =await ref.read(adminControllerProvider.notifier).getPlane(planeId: widget.ticket.flight!.planeId);

                  if (response!=null){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlaneInfoScreen(plane: response,)));

                  }
           
                  }, child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.info),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("planeInfo".tr()),
                      )
                    ],
                  )),
                )
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(FontAwesomeIcons.moneyCheckDollar,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(widget.ticket.price.toString()),
                ),
                CustomText("sr".tr()),
                const Spacer(),

                CustomText("status".tr()),
                const SizedBox(
                  width: 10,
                ),
                CustomText(widget.ticket.status=="Cancelled"?"cancelled".tr():(widget.ticket.status=="not paid"?"notPaid".tr():(widget.ticket.status=="waitList"?"waitList".tr(): "paid".tr()))),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${'classType'.tr()} : ${widget.ticket.class_type!.tr()}"),
                )
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.chair_sharp),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(widget.ticket.seat_location??""),
                )
              ],
            ),
            if (widget.ticket.status=="not paid")
            SizedBox(
              width:300,
              child: CustomButton(
                child: CustomText("pay".tr()), onPressed: () {
                  showBottomSheet(context: context, builder: (context)=>Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
                        ),
                        child: Builder(
                          builder: (context) {
                             if (adminStates is AdminLoading){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                     
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CustomText("Pay With:",fontsize: 32,
                                  color: Colors.white,),
                                ),
                                InkWell(
                                  onTap: ()async {
                                    
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    height: 60,
                                                        
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white,
                                      boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),]
                                    ),
                                    child: const Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.credit_card),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: CustomText("With credit card"),
                                          )],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: ()async{
                                    
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    height: 60,
                                                        
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white,
                                      boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),]
                                    ),
                                    child: const Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(FontAwesomeIcons.applePay,size: 36,),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: CustomText("With Apple Pay"),
                                          )],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        ),
                          

                    
                  ));
                }),
            )
            else if (widget.ticket.status=="waitList")
            Builder(
              builder: (context) {
                if (adminStates is AdminLoading){
                  return const Center(child: CircularProgressIndicator());
                }
                return SizedBox(
                  width: 300,
                  child: CustomButton(child: Text("Search"), onPressed: ()async {
                    final response = await ref.read(adminControllerProvider.notifier).getAvailableSeats(flight_id: widget.ticket.flight!.id,class_type: widget.ticket.class_type!);
                    if (response==null ||response.isEmpty){
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("noSeats".tr())));
                      return;
                    }
                    else {
                      // ignore: use_build_context_synchronously
                      showDialog(context: context, builder: (context)=>Dialog(
                        clipBehavior: Clip.hardEdge,
                        child: Material(child: SizedBox(
                          height: 150,
                          
                          child: SeatPicker(listOfSeats: response,ticket: widget.ticket,()=>setState(() {
                            hide=true;
    })))),
                      ));
                    }
                  }),
                );
              }
            )
            else 
            Container(
              width:300,
              height: 45,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(100)
              
              ),
              child: Center(child:  CustomText(widget.ticket.status=="Cancelled"?"cancelled".tr():(widget.ticket.status=="not paid"?"notPaid".tr():(widget.ticket.status=="waitList"?"waitList".tr(): "paid".tr())),
              color: Theme.of(context).colorScheme.primary,)),
            )
            

          ],
        ),
      ),
    );
  }
}