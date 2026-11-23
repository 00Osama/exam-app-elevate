import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A four-digit, single-field code input displayed as separate boxes.
class VerificationCodeInput extends StatefulWidget {
  const VerificationCodeInput({super.key, this.length = 4, this.onChanged})
    : assert(length > 0);

  final int length;
  final ValueChanged<String>? onChanged;

  @override
  State<VerificationCodeInput> createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
  late final TextEditingController verificationCodeController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    verificationCodeController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    verificationCodeController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const codeColor = Color(0xFF02369C);

    return Semantics(
      label: 'Verification code',
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: SizedBox(
          height: 58,
          child: Stack(
            children: [
              Row(
                children: List.generate(widget.length, (index) {
                  final hasDigit =
                      index < verificationCodeController.text.length;
                  final isActive =
                      _focusNode.hasFocus &&
                      index ==
                          verificationCodeController.text.length.clamp(
                            0,
                            widget.length - 1,
                          );

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 0 : 6,
                        right: index == widget.length - 1 ? 0 : 6,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isActive
                                ? codeColor
                                : const Color(0xFF9AA9C1),
                            width: isActive ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          hasDigit
                              ? verificationCodeController.text[index]
                              : '',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: codeColor,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              Positioned.fill(
                child: TextField(
                  controller: verificationCodeController,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.oneTimeCode],
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(widget.length),
                  ],
                  maxLength: widget.length,
                  onChanged: (value) {
                    setState(() {});
                    widget.onChanged?.call(value);
                  },
                  cursorColor: Colors.transparent,
                  style: const TextStyle(
                    color: Colors.transparent,
                    fontSize: 1,
                    height: 1,
                  ),
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isCollapsed: true,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
