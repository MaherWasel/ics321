import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/modules/booking/presentation/provider/provider.dart';
import 'package:ics321/modules/booking/presentation/screen/plane_info.dart';
import 'package:ics321/shared/custom_button.dart';
import 'package:ics321/shared/custom_text.dart';
import 'package:ics321/shared/models/flight.dart';

class BookingCard extends ConsumerWidget{
  final FlightModel flight;

  const BookingCard({super.key, required this.flight});
  getFormatedDate(DateTime _date, bool time) {

    if (time){
    return DateFormat.jms().format(_date);
     

    }
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(_date);
    }
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final sizes=MediaQuery.of(context).size;
    final bookingStates=ref.watch(bookingStateProvider);
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.flight_takeoff),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(flight.source),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.flight_land),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(flight.destination),
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
                  child: Text(getFormatedDate(flight.date,false)),
                ),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.schedule),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(getFormatedDate(flight.time, true)),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextButton(onPressed: ()async{
                     await ref.read(bookingStateProvider.notifier).getPlane(planeId: flight.planeId);

                  if (ref.read(bookingStateProvider.notifier).selectedPlane!=null){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlaneInfoScreen()));

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
            SizedBox(
              width: sizes.width/2,
              child: CustomButton(
                child: CustomText("book".tr()), onPressed: () {
                
                }),
            )
          ],
        ),
      ),
    );
  }

}