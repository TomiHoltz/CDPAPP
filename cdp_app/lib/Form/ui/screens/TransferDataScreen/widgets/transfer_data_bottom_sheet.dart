import 'package:cdp_app/Form/model/transfer_data.dart';
import 'package:cdp_app/Form/ui/screens/TransferDataScreen/widgets/add_transfer_data_dialog.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransferDataBottomSheet extends StatelessWidget {
  final String? tipo;
  final String? text;
  final StateProvider<TransferData?>? providerToChange;

  const TransferDataBottomSheet(
      {Key? key,
      @required this.text,
      @required this.tipo,
      this.providerToChange})
      : super(key: key);

  Widget addTransferDataButton(BuildContext context) => Column(
        children: [
          const SizedBox(
            height: defaultPadding,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddTransferDataDialog(
                      tipo: tipo,
                      text: text,
                    );
                  },
                );
              },
              child: const Text(
                "Agregar",
                style: TextStyle(color: darkColor),
              ),
            ),
          ),
        ],
      );

  Widget dataList() => Column(
        children: [],
      );

  Widget title() => Container(
        alignment: Alignment.center,
        child: Text(
          text!,
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
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        border: Border.all(),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: defaultPadding / 2),
            title(),
            dataList(),
            addTransferDataButton(context)
          ],
        ),
      ),
    );
  }
}
