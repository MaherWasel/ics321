import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ics321/core/utils/utils.dart';
import 'package:ics321/modules/my_tickets/presentation/provider/provider.dart';
import 'package:ics321/shared/custom_text.dart';
import 'package:ics321/shared/models/ticket.dart';
import 'package:uuid/uuid_value.dart';

class Pay extends ConsumerStatefulWidget{
  final Ticket ticket;
  final Function refresh;
  const Pay(this.ticket, this.refresh,{super.key});

  @override
  ConsumerState<Pay> createState() => _PayState();
}

class _PayState extends ConsumerState<Pay> {
  bool load=false;
  @override
  Widget build(BuildContext context) {

    return Container(
                                width: double.infinity,
                                height: 300,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                child: load?Center(child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),): Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: CustomText(
                                          "Pay With:",
                                          fontsize: 32,
                                          color: Colors.white,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          setState(() {
                                            load=true;
                                          });
                                          await ref
                                              .read(myTicketPaymentProvider
                                                  .notifier)
                                              .payTicket(
                                                  ticket: widget.ticket,
                                                  user_id: UuidValue.fromString(
                                                          Utils.userId)
                                                      .toFormattedString(),
                                                  context: context);
                                          setState(() {
                                            load=false;
                                          });
                                          Navigator.pop(context);
                                          widget.refresh();
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(8),
                                          height: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ]),
                                          child: const Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child:
                                                      Icon(Icons.credit_card),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: CustomText(
                                                      "With credit card"),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          setState(() {
                                            load=true;
                                          });
                                          await ref
                                              .read(myTicketPaymentProvider
                                                  .notifier)
                                              .payTicket(
                                                  ticket: widget.ticket,
                                                  user_id: UuidValue.fromString(
                                                          Utils.userId)
                                                      .toFormattedString(),
                                                  context: context);
                                          setState(() {
                                            load=false;
                                          });
                                          Navigator.pop(context);
                                          widget.refresh();
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(8),
                                          height: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ]),
                                          child: const Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    FontAwesomeIcons.applePay,
                                                    size: 36,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: CustomText(
                                                      "With Apple Pay"),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                 ) );
  }
}