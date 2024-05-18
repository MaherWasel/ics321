import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ics321/core/utils/utils.dart';
import 'package:ics321/modules/home/presentation/widget/flight_card.dart';
import 'package:ics321/modules/my_tickets/presentation/widget/pay.dart';
import 'package:ics321/modules/my_tickets/presentation/widget/seats_picker.dart';
import 'package:ics321/shared/models/ticket.dart';
import 'package:ics321/modules/my_tickets/presentation/provider/provider.dart';
import 'package:ics321/modules/my_tickets/presentation/widget/ticket_cancelation.dart';
import 'package:ics321/shared/custom_button.dart';
import 'package:ics321/shared/custom_text.dart';
import 'package:ics321/shared/plane_info.dart';

import 'package:uuid/uuid_value.dart';

class TicketCard extends ConsumerWidget {
  final Ticket ticket;
  final Function refresh;
  const TicketCard({super.key, required this.refresh, required this.ticket});
  getFormatedDate(DateTime _date, bool time) {
    if (time) {
      return DateFormat.jms().format(_date);
    }
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(_date);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketStates = ref.watch(myTicketsProvider);

    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (ticket.status != "Cancelled")
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 2),
                    child: TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => Center(
                                  child: TicketCancelation(
                                      ticket, () => refresh())));
                        },
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0),
                              child: Icon(Icons.delete),
                            ),
                            CustomText("cancelTicket".tr()),
                            
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
                  child: Text(ticket.flight!.source),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.flight_land),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(ticket.flight!.destination),
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
                  child: Text(getFormatedDate(ticket.flight!.date, false)),
                ),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.schedule),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(getFormatedDate(ticket.flight!.time, true)),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextButton(
                      onPressed: () async {
                        final response = await ref
                            .read(myTicketsProvider.notifier)
                            .getPlane(planeId: ticket.flight!.planeId);

                        if (response != null) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PlaneInfoScreen(
                                    plane: response,
                                  )));
                        }
                      },
                      child: Row(
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
                  child: Icon(
                    FontAwesomeIcons.moneyCheckDollar,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(ticket.price.toString()),
                ),
                CustomText("sr".tr()),
                const Spacer(),
                CustomText("status".tr()),
                const SizedBox(
                  width: 10,
                ),
                if (ticket.status=="Expired")
                CustomText('expired'.tr())
                else if (ticket.status=="Reusable")
                CustomText('reusable'.trim())
                else
                CustomText(ticket.status == "Cancelled"
                    ? "cancelled".tr()
                    : (ticket.status == "not paid"
                        ? "notPaid".tr()
                        : (ticket.status == "waitList"
                            ? "waitList".tr()
                            : "paid".tr()))),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Text("${'classType'.tr()} : ${ticket.class_type!.tr()}"),
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
                  child: CustomText(ticket.seat_location ?? ""),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${"tickedID".tr()} : ${ticket.id}        "),
            ),
            if (ticket.status == "not paid")
              SizedBox(
                width: 300,
                child: CustomButton(
                    child: CustomText("pay".tr()),
                    onPressed: () {
                      showBottomSheet(
                          context: context,
                          builder: (context) =>Pay(ticket, ()=>refresh()));
                    }),
              )
            else if (ticket.status == "waitList")
              Builder(builder: (context) {
                if (ticketStates is TicketLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return SizedBox(
                  width: 300,
                  child: CustomButton(
                      child: Text("waitList".tr()),
                      onPressed: () async {
                        final response = await ref
                            .read(myTicketsProvider.notifier)
                            .getAvailableSeats(
                                flight_id: ticket.flight!.id,
                                class_type: ticket.class_type!);
                        if (response == null || response.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("noSeats".tr())));
                          return;
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                    clipBehavior: Clip.hardEdge,
                                    child: Material(
                                        child: SizedBox(
                                            height: 150,
                                            child: SeatPicker(
                                                listOfSeats: response,
                                                ticket: ticket,
                                                refresh))),
                                  ));
                        }
                      }),
                );
              })
            else if (ticket.status=="Expired")
            Container(
                width: 300,
                height: 45,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                    child: CustomText(
                  "expired".tr(),
                  color: Theme.of(context).colorScheme.primary,
                )),
              )
            else if (ticket.status=="Reusable")
            InkWell(
              onTap: (){
                Utils.reusableTicket=ticket;
                showDialog(context: context, builder: (context)=>Dialog(
                  child: SizedBox(
                    height: 350, 
                    child: FlightCard()),
                ));
              },
              child: Container(
                  width: 300,
                  height: 45,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                      child: CustomText(
                    "reSchedule".tr(),
                    color: Theme.of(context).colorScheme.primary,
                  )),
                ),
            )
            else
              Container(
                width: 300,
                height: 45,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                    child: CustomText(
                  ticket.status == "Cancelled"
                      ? "cancelled".tr()
                      : (ticket.status == "not paid"
                          ? "notPaid".tr()
                          : (ticket.status == "waitList"
                              ? "waitList".tr()
                              : "paid".tr())),
                  color: Theme.of(context).colorScheme.primary,
                )),
              )
          ],
        ),
      ),
    );
  }
}
