import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/modules/my_tickets/presentation/provider/provider.dart';
import 'package:ics321/shared/custom_text.dart';
import 'package:ics321/shared/models/ticket.dart';

class TicketCancelation extends ConsumerWidget {
  const TicketCancelation(this.ticket, this.refresh, {super.key});
  final Ticket ticket;
  final Function refresh;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sizes = MediaQuery.of(context).size;
    final ticketStates = ref.watch(myTicketsProvider);
    return SizedBox(
      height: sizes.height / 3,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(
              "Are Sure You Want To Cancel ? ",
              fontsize: 26,
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomText(
                    "Importart Information",
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomText("10% fine will be detected from price")
                ),
              ],
            ),
            
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(builder: (context) {
                if (ticketStates is TicketLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: sizes.width / 3,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const CustomText("Cancel"),
                      ),
                    ),
                    SizedBox(
                        width: sizes.width / 3,
                        child: ElevatedButton(
                            onPressed: () async {
                              await ref
                                  .read(myTicketsProvider.notifier)
                                  .cancelTicket(
                                      ticket: ticket, context: context);
                              Navigator.of(context).pop();
                              refresh();
                            },
                            child: const CustomText("Confirm")))
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
