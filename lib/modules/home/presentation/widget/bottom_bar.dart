import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/modules/home/presentation/provider/providers.dart';

class ButtomBar extends ConsumerWidget{
  const ButtomBar({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    int barIndex=ref.watch(bottomBarProvider);
    return BottomNavigationBar(
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.greenAccent,
      backgroundColor: Theme.of(context).colorScheme.primary,
      currentIndex: barIndex,
      onTap: (index){
        ref.read(bottomBarProvider.notifier).modifyBarIndex(index: index);
      },
      items:  [
        BottomNavigationBarItem(

        icon: const Icon(Icons.home),
        label: 'home'.tr(),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.airplane_ticket),
        label: 'myTickets'.tr(),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.settings),
        label: 'settings'.tr(),
      ),
      
      
      ],
    );
  }

}