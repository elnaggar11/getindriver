import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:getin_driver/features/static_pages/cubit/staticpage_cubit.dart';
import 'package:getin_driver/shared/back_widget.dart';
import 'package:getin_driver/shared/widgets/html_content_widget.dart';
import 'package:getin_driver/shared/widgets/retry_error_widget.dart';

/// Shared scaffold for static CMS HTML pages (Terms & Conditions, Privacy Policy).
class StaticHtmlPageView extends StatelessWidget {
  const StaticHtmlPageView({
    super.key,
    required this.fallbackTitle,
    required this.onLoad,
  });

  final String fallbackTitle;
  final Future<void> Function(StaticpageCubit cubit) onLoad;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = StaticpageCubit();
        onLoad(cubit);
        return cubit;
      },
      child: _StaticHtmlPageContent(
        fallbackTitle: fallbackTitle,
        onRetry: onLoad,
      ),
    );
  }
}

class _StaticHtmlPageContent extends StatelessWidget {
  const _StaticHtmlPageContent({
    required this.fallbackTitle,
    required this.onRetry,
  });

  final String fallbackTitle;
  final Future<void> Function(StaticpageCubit cubit) onRetry;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaticpageCubit, StaticpageState>(
      builder: (context, state) {
        final String title =
            (state is GetTermsSucess &&
                state.terms.title != null &&
                state.terms.title!.trim().isNotEmpty)
            ? state.terms.title!
            : fallbackTitle;

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
          body: _StaticHtmlBody(state: state, onRetry: onRetry),
        );
      },
    );
  }
}

class _StaticHtmlBody extends StatelessWidget {
  const _StaticHtmlBody({required this.state, required this.onRetry});

  final StaticpageState state;
  final Future<void> Function(StaticpageCubit cubit) onRetry;

  @override
  Widget build(BuildContext context) {
    if (state is GetTermsLoading) {
      return const Center(
        child: CircularProgressIndicator(color: LightThemeColors.primary),
      );
    }

    if (state is GetTermsFailed) {
      final failed = state as GetTermsFailed;
      return RetryErrorWidget(
        message: failed.message,
        onRetry: () => onRetry(context.read<StaticpageCubit>()),
      );
    }

    if (state is GetTermsSucess) {
      final success = state as GetTermsSucess;
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: HtmlContentWidget(html: success.terms.content ?? ''),
      );
    }

    return const SizedBox.shrink();
  }
}
