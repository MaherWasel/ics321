import 'package:flutter/material.dart';
import 'package:ics321/constants/email_const.dart';
import 'package:ics321/core/utils/utils.dart';
import 'package:ics321/modules/booking/domain/seat.dart';
import 'package:ics321/shared/models/ticket.dart';
import 'package:ics321/shared/models/flight.dart';
import 'package:ics321/shared/models/plane.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid_value.dart';

class TicketRepository {
  Future<bool?> sendConfirmation({
    required String body,
    required String subject,
  }) async {
    try {
      final res = await Supabase.instance.client
          .from("User")
          .select(("email"))
          .eq("id", UuidValue.fromString(Utils.userId).toFormattedString());

      List<dynamic> data = res as List<dynamic>;

      final recmail = data[0]["email"];
      if (recmail == null) {
        return false;
      }
      print(recmail);
      print('The user email is: $recmail');
      final smtpServer = gmail(EmailConstants.email, EmailConstants.password);

      final message = Message()
            ..from = const Address(EmailConstants.email, 'Saudi Traveler')
            ..recipients.add(recmail)
            // ..ccRecipients.addAll(['abc@gmail.com', 'xyz@gmail.com']) // For Adding Multiple Recipients
            // ..bccRecipients.add(Address('a@gmail.com')) For Binding Carbon Copy of Sent Email
            ..subject = subject
            ..text = body
          // ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>"; // For Adding Html in email
          // ..attachments = [
          //   FileAttachment(File('image.png'))  //For Adding Attachments
          //     ..location = Location.inline
          //     ..cid = '<myimg@3.141>'
          // ]
          ;

      final sendReport = await send(message, smtpServer);

      print('Message sent: ' + sendReport.toString());

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Ticket>> getTickets({required String userId}) async {
    final response = await Supabase.instance.client
        .from("Ticket")
        .select()
        .eq('user_id', userId);

    final List<Ticket> list = [];
    for (int i = 0; i < response.length; i++) {
      final flightResponse = await Supabase.instance.client
          .from("Flight")
          .select()
          .eq("id", response[i]["flight_id"]);
      list.add(Ticket(
          id: response[i]["id"],
          flight: FlightModel.fromMap(flightResponse[0]),
          price: response[i]["price"] * 1.0,
          status: response[i]["status"],
          seat_location: response[i]["seat_location"],
          user_id: response[i]["user_id"],
          class_type: response[i]["class_type"]));
    }

    return list;
  }

  Future<List<Seat>> getAvailableSeats(
      {required String flight_id,
      String? status,
      String? type,
      required String class_type}) async {
    final response = await Supabase.instance.client
        .from("Seat")
        .select()
        .filter(
          "flight_id",
          'eq',
          flight_id,
        )
        .eq("type", class_type);
    List<Seat> list = [];
    for (int i = 0; i < response.length; i++) {
      list.add(Seat.fromMap(response[i]));
    }
    if (type != null) {
      list = list.where((element) => element.type == type).toList();
    }
    if (status != null) {
      list = list.where((element) => element.status == status).toList();
    }
    if (type != null && status != null) {
      list = list
          .where((element) => element.type == type && element.status == status)
          .toList();
    }
    if (status == null) {
      list = list.where((element) => element.status == null).toList();
    }

    return list;
  }

  Future<bool?> changeWaitList(
      {required Ticket ticketId, required String seatLocation}) async {
    await Supabase.instance.client
        .from("Ticket")
        .update({"status": "not paid", "seat_location": seatLocation}).eq(
            "id", ticketId.id);
    await Supabase.instance.client
        .from("Seat")
        .update({"status": "Reserved"})
        .eq("flight_id", ticketId.flight!.id)
        .eq("location", seatLocation);
    final res_email = await sendConfirmation(
        body:
            'The Ticket with the following ID ${ticketId.id} has been promoted from waitlisting.',
        subject: "Ticket WaitListed Promoted.");

    return res_email;
  }

  Future<bool?> cancelTicket({required Ticket ticket}) async {
    if (ticket.status=="waitList"){
      await Supabase.instance.client.from("Ticket").update({"status":"Cancelled"}).eq("id", ticket.id);

    }
    else {
  await Supabase.instance.client
        .from("Ticket")
        .update({"status": "Cancelled"})
        .eq("id", ticket.id);

    await Supabase.instance.client
        .from("Seat")
        .update({"status": null})
        .eq('flight_id', ticket.flight!.id)
        .eq('location', ticket.seat_location!);
    if (ticket.status == "paid") {
      await Supabase.instance.client.from("Payment").insert({
        "method": "Credit Card",
        'amount': ticket.price!*0.9,
        "user_id": ticket.user_id,
        "status": "Refund",
        "ticket_id": ticket.id
      });
    }
    final res_em = await sendConfirmation(
        body: 'The Ticket with the following ID ${ticket.id} has been cancled.',
        subject: "Ticket Cancilation.");

    return res_em;
  }
    }
   

  Future<Plane?> getPlane({required String planeId}) async {
    final response =
        await Supabase.instance.client.from("Plane").select().eq('id', planeId);

    if (response.isEmpty) {
      return null;
    }
    return Plane.fromMap(response[0]);
  }

  Future<bool?> payTicket(
      {required Ticket ticketId, required String user_id}) async {
    await Supabase.instance.client
        .from("Ticket")
        .update({"status": "paid"})
        .eq("id", ticketId.id)
        .eq("user_id", user_id);
    await Supabase.instance.client.from("Payment").insert({
      "user_id": user_id,
      "status": "paid",
      "method": "Credit Card",
      "amount": ticketId.price,
      "ticket_id": ticketId.id
    });
    final res = await sendConfirmation(
        body: 'The Ticket with the following ID ${ticketId.id} has been paid.',
        subject: "Ticket Payment.");

    return res;
  }
}
