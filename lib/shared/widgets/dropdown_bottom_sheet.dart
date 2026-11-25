import 'package:flutter/material.dart';
import 'package:getin_driver/shared/widgets/edit_text_widget.dart';

class BottomSheetDropdownField<T> extends StatefulWidget {
  const BottomSheetDropdownField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.fetchItems, // async request function
    required this.itemBuilder, // custom UI for item
    required this.selector, // what happens on select
    required this.displayStringForItem, // <-- NEW (convert T to String)
    this.selectedItem,
    this.validator,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final Future<List<T>> Function() fetchItems;
  final Widget Function(BuildContext context, T item, bool isSelected)
  itemBuilder;
  final void Function(T item) selector;
  final String Function(T item) displayStringForItem; // convert T -> String
  final T? selectedItem;
  final String? Function(String?)? validator;

  @override
  State<BottomSheetDropdownField<T>> createState() =>
      _BottomSheetDropdownFieldState<T>();
}

class _BottomSheetDropdownFieldState<T>
    extends State<BottomSheetDropdownField<T>> {
  T? _selected;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.selectedItem;
    if (_selected != null) {
      widget.controller.text = widget.displayStringForItem(_selected as T);
    }
  }

  Future<void> _openBottomSheet() async {
    setState(() => _isLoading = true);

    late List<T> items;
    try {
      items = await widget.fetchItems();
    } finally {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }

    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              ListTile(
                title: Text(
                  widget.label,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const Divider(),
              const SizedBox(height: 6),
              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (items.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("No items found"),
                  ),
                )
              else
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: items.length,
                    separatorBuilder: (ctx, i) => const SizedBox(height: 10),
                    itemBuilder: (ctx, i) {
                      final item = items[i];
                      final isSelected = item == _selected;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selected = item;
                            widget.controller.text = widget
                                .displayStringForItem(item); // update text
                          });
                          widget.selector(item);
                          Navigator.pop(context);
                        },
                        child: widget.itemBuilder(ctx, item, isSelected),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      readOnly: true,
      validator: widget.validator,
      controller: widget.controller,
      onTap: _openBottomSheet,
      fixedlabel: widget.label,
      hintText: widget.hintText,
      suffixIcon: const Icon(Icons.keyboard_arrow_down),
    );
  }
}
