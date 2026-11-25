import 'package:getin_driver/features/finance/presentation/screens/finance_screen.dart';
import 'package:getin_driver/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getin_driver/features/profile/presentation/screens/profile_screen.dart';
import 'package:getin_driver/features/report/presentation/screens/report_screen.dart';

//import '../../../home/presentation/screens/home_screen.dart';
import '../../cubit/layout_cubit.dart';
import '../../cubit/layout_states.dart';
import '../widgets/widgets.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key, this.index});
  final int? index;

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()..initTabBar(this, widget.index ?? 0),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = LayoutCubit.get(context);
          return PopScope(
            canPop: false,
            child: Scaffold(
              body: TabBarView(
                controller: cubit.tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  //    const HomeScreen(),
                  HomeScreen(),
                  FinanceScreen(),
                  ReportScreen(),
                  ProfileScreen(),
                ],
              ),
              bottomNavigationBar: CustomBottomNavBar(
                currentIndex: cubit.tabController.index,
                onTap: cubit.changeTab,
              ),
              extendBody: true,
            ),
          );
        },
      ),
    );
  }
}
