import 'package:cdp_app/Form/model/transport_data.dart';
import 'package:cdp_app/Form/ui/widgets/form_text_field.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransportBottomSheetField extends StatefulWidget {
  final String? text;
  final String? tipo;
  final StateProvider<TransportData?>? providerToChange;

  const TransportBottomSheetField(
      {Key? key,
      @required this.text,
      required this.tipo,
      this.providerToChange})
      : super(key: key);

  @override
  _TransportBottomSheetFieldState createState() =>
      _TransportBottomSheetFieldState();
}

class _TransportBottomSheetFieldState extends State<TransportBottomSheetField> {
  final TextEditingController controller = TextEditingController();

  Widget addDataButton(BuildContext context) => Column(
        children: [
          const SizedBox(
            height: defaultPadding,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: TextButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  context.read(widget.providerToChange!).state = TransportData(
                    tipo: widget.tipo,
                    text: controller.text,
                  );
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                }
              },
              child: const Text(
                "Agregar",
                style: TextStyle(color: darkColor),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
        ],
      );

  Widget textField() {

    int maxLenght() {
      if (widget.tipo == "camion" || widget.tipo == "acoplado") {
        return 7;
      } else {
        return 10;
      }
    }

    return FormTextField(
        dataWeWantReceive: "${widget.text} (Escriba aqui)",
        controller: controller,
        maxLength: maxLenght(),
        keyboardType: TextInputType.text);
  }

  Widget title() => Container(
        alignment: Alignment.center,
        child: Text(
          widget.text!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border.all(),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: defaultPadding / 2),
            title(),
            textField(),
            addDataButton(context)
          ],
        ),
      ),
    );
  }
}
