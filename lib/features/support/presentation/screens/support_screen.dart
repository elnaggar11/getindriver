import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:getin_driver/core/utils/extentions.dart';
import 'package:getin_driver/features/support/cubit/support_cubit.dart';
import 'package:getin_driver/shared/back_widget.dart';
import 'package:getin_driver/shared/widgets/html_content_widget.dart';
import 'package:getin_driver/shared/widgets/retry_error_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SupportCubit()..getSupport(),
      child: const _SupportScreenContent(),
    );
  }
}

class _SupportScreenContent extends StatelessWidget {
  const _SupportScreenContent();

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber.trim());
    try {
      await launchUrl(phoneUri);
    } catch (e) {
      debugPrint('Failed to launch phone dialer: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupportCubit, SupportState>(
      builder: (context, state) {
        final String title =
            (state is SupportSuccess &&
                state.supportModel.title != null &&
                state.supportModel.title!.trim().isNotEmpty)
            ? state.supportModel.title!
            : LocalizationHelper.tr.support;

        return Scaffold(
          appBar: AppBar(
            leading: const BackWidget(),
            centerTitle: false,
            title: Text(
              title,
              style: const TextStyle(
                color: LightThemeColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: _SupportBody(state: state, onCallTap: _launchPhone),
        );
      },
    );
  }
}

class _SupportBody extends StatelessWidget {
  const _SupportBody({required this.state, required this.onCallTap});

  final SupportState state;
  final Future<void> Function(String phoneNumber) onCallTap;

  @override
  Widget build(BuildContext context) {
    if (state is SupportLoading) {
      return const Center(
        child: CircularProgressIndicator(color: LightThemeColors.primary),
      );
    }

    if (state is SupportFailed) {
      final failed = state as SupportFailed;
      return RetryErrorWidget(
        message: failed.message,
        onRetry: () => context.read<SupportCubit>().getSupport(),
      );
    }

    if (state is SupportSuccess) {
      final support = (state as SupportSuccess).supportModel;
      final bool hasPhone =
          support.phoneNumber != null && support.phoneNumber!.trim().isNotEmpty;

      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            40.ph,
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: LightThemeColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.support_agent,
                size: 60,
                color: LightThemeColors.primary,
              ),
            ),
            24.ph,
            if (support.title != null && support.title!.trim().isNotEmpty) ...[
              Text(
                support.title!,
                style: const TextStyle(
                  color: LightThemeColors.primary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              16.ph,
            ],
            if (support.description != null &&
                support.description!.trim().isNotEmpty) ...[
              HtmlContentWidget(
                html: support.description!,
                textStyle: const TextStyle(
                  color: LightThemeColors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                ),
              ),
              32.ph,
            ],
            if (hasPhone) ...[
              _PhoneWidget(
                phoneNumber: support.phoneNumber!,
                onTap: () => onCallTap(support.phoneNumber!),
              ),
              24.ph,
            ],
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

class _PhoneWidget extends StatelessWidget {
  const _PhoneWidget({required this.phoneNumber, required this.onTap});

  final String phoneNumber;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: LightThemeColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: LightThemeColors.primary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: LightThemeColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.phone, color: Colors.white, size: 24),
          ),
          16.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocalizationHelper.tr.contact_support,
                  style: const TextStyle(
                    color: LightThemeColors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                4.ph,
                Text(
                  phoneNumber,
                  style: const TextStyle(
                    color: LightThemeColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.call, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}
