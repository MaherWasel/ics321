import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:ics321/constants/email_const.dart';
import 'package:ics321/core/utils/utils.dart';
import 'package:ics321/shared/models/plane.dart';
import 'package:ics321/modules/booking/domain/seat.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class BookingRepository {
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
      print(1);
      final sendReport = await send(message, smtpServer);
      print(2);
      print('Message sent: ' + sendReport.toString());

      return true;
    } catch (e) {
      print(e);
      return false;
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

  Future<List<Seat>> getAvailableSeats(
      {required String flight_id, String? status, String? type}) async {
    final response =
        await Supabase.instance.client.from("Seat").select().filter(
              "flight_id",
              'eq',
              flight_id,
            );
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

  Future<void> sendTicket(
      {required String flight_id,
      required double price,
      required String? seatLocation,
      String? status,
      required String classType}) async {
    final response = await Supabase.instance.client
        .from("Ticket")
        .select()
        .not('status', 'eq', 'Cancelled')
        .eq("user_id", UuidValue.fromString(Utils.userId).toFormattedString())
        .eq("flight_id", flight_id);
    if (response.length == 10) {
      throw Exception();
    }
    if (status != null && status == "waitList") {
      await Supabase.instance.client.from("Ticket").insert({
        "flight_id": flight_id,
        "price": price,
        "seat_location": null,
        "status": "waitList",
        "class_type": classType,
        "user_id": UuidValue.fromString(Utils.userId).toFormattedString()
      });
      return;
    }

    await Supabase.instance.client.from("Ticket").insert({
      "flight_id": flight_id,
      "price": price,
      "seat_location": seatLocation,
      "status": "not paid",
      "class_type": classType,
      "user_id": UuidValue.fromString(Utils.userId).toFormattedString()
    });
    await Supabase.instance.client
        .from("Seat")
        .update({"status": "Reserved"})
        .eq("location", seatLocation!)
        .eq("flight_id", flight_id);

    final sentEmail = await sendConfirmation(
        body:
            'You have reservation in $seatLocation and with flightId $flight_id',
        subject: "Booking Flight");

    print(sentEmail);
  }
}
