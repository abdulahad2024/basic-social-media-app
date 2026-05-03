import 'package:social_media_app/export.dart';
class CustomOtpBox extends StatelessWidget {
  const CustomOtpBox({
    super.key,
    required this.context,
    required this.controller,
    required this.first,
    required this.last,
  });

  final BuildContext context;
  final TextEditingController controller;
  final bool first;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 60,
      width: (MediaQuery.of(context).size.width - 100) / 4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: controller.text.isNotEmpty
              ? theme.colorScheme.primary
              : theme.colorScheme.outlineVariant,
          width: 1.5,
        ),
      ),
      child: TextFormField(
        controller: controller,
        autofocus: first,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
        ),
        decoration: const InputDecoration(
          counterText: "",
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (value) {
          if (value.length == 1 && last == false) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && first == false) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
