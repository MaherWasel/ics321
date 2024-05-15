import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/modules/booking/domain/seat.dart';
import 'package:ics321/modules/my_tickets/presentation/provider/provider.dart';
import 'package:ics321/shared/custom_button.dart';
import 'package:ics321/shared/custom_text.dart';
import 'package:ics321/shared/models/ticket.dart';

class SeatPicker extends ConsumerStatefulWidget {
  SeatPicker(this.refresh,
      {super.key, required this.listOfSeats, required this.ticket});
  final Function refresh;
  final List<Seat> listOfSeats;
  final Ticket ticket;
  @override
  ConsumerState<SeatPicker> createState() => _SeatPickerState();
}

class _SeatPickerState extends ConsumerState<SeatPicker> {
  String? selectedSeat;

  @override
  Widget build(BuildContext context) {
    final ticketState = ref.watch(myTicketsProvider);
    if (ticketState is TicketLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("found the following seats"),
        ),
        DropdownButton<String>(
          hint: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('seat'),
          ),
          isExpanded: true,
          value: selectedSeat,
          items: widget.listOfSeats.map((e) {
            return DropdownMenuItem(
              value: e.location,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  e.location,
                  fontsize: 22,
                ),
              ),
            );
          }).toList(),
          onChanged: (_) {
            setState(() {
              selectedSeat = _ ?? "";
            });
          },
        ),
        const Spacer(),
        if (selectedSeat != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 300,
              child: CustomButton(
                  child: Text("confirm".tr()),
                  onPressed: () async {
                    await ref.read(myTicketsProvider.notifier).changeWaitList(
                        ticketId: widget.ticket,
                        seatLocation: selectedSeat!,
                        context: context);
                    if (ref.read(myTicketsProvider) is TicketSuccess) {
                      Navigator.pop(context);
                      widget.refresh();
                    }
                  }),
            ),
          )
      ],
    );
  }
}
