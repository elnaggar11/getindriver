import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:getin_driver/core/utils/extentions.dart';
import '../../domain/model/report_model.dart';
import '../widgets/review_item_widget.dart';
import '../../cubit/report_cubit.dart';
import '../../cubit/report_states.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportCubit(),
      child: BlocConsumer<ReportCubit, ReportStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = ReportCubit.get(context)..addPageListener();
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                LocalizationHelper.tr.your_evaluations,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Column(
              children: [
                12.ph,
                Expanded(
                  child: PagedListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    pagingController: cubit.reviewsController,
                    builderDelegate: PagedChildBuilderDelegate<ReviewModel>(
                      itemBuilder: (context, item, index) {
                        return ReviewItemWidget(review: item);
                      },
                    ),
                    separatorBuilder: (context, index) => 12.ph,
                  ),
                ),
                20.ph,
              ],
            ),
          );
        },
      ),
    );
  }
}
