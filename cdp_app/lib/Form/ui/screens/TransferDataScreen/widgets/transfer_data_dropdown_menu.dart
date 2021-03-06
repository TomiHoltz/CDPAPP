import 'package:cdp_app/Form/model/transfer_data.dart';
import 'package:cdp_app/Form/ui/screens/TransferDataScreen/widgets/transfer_data_bottom_sheet.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransferDataDropdownMenu extends ConsumerWidget {
  const TransferDataDropdownMenu(
      {Key? key, this.text, this.providerToChange, this.tipo})
      : super(key: key);

  final String? tipo;
  final String? text;
  final StateProvider<TransferData?>? providerToChange;

  Widget dataNameText() => Text(
        text!,
        style: const TextStyle(fontWeight: FontWeight.w600),
      );

  Widget arrowButton(BuildContext context) => Container(
        alignment: Alignment.centerRight,
        child: IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (context) {
                return TransferDataBottomSheet(
                  tipo: tipo,
                  text: text,
                  providerToChange: providerToChange,
                );
              },
            );
          },
          icon: const Icon(Icons.arrow_drop_down),
        ),
      );

  Widget deleteButton(BuildContext context) => Container(
        alignment: Alignment.centerRight,
        child: IconButton(
          onPressed: () {
            context.read(providerToChange!).state = TransferData(
              nombre: "",
              cuit: "",
              acoplado: "",
              camion: "",
              tipo: tipo,
            );
          },
          icon: const Icon(Icons.delete),
        ),
      );

  Widget dataTexts() => Consumer(
        builder: (context, watch, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(watch(providerToChange!).state!.nombre!),
              const SizedBox(height: defaultPadding / 4),
              Text("CUIT: ${watch(providerToChange!).state!.cuit!}"),
            ],
          );
        },
      );

  Widget dataTextsIfChofer() => Consumer(
        builder: (context, watch, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (watch(providerToChange!).state!.nombre!.isNotEmpty)
                Text("Nombre: ${watch(providerToChange!).state!.nombre!}"),
              if (watch(providerToChange!).state!.nombre!.isNotEmpty)
                const SizedBox(height: defaultPadding / 2),
              if (watch(providerToChange!).state!.cuit!.isNotEmpty)
                Text("CUIT: ${watch(providerToChange!).state!.cuit!}"),
              if (watch(providerToChange!).state!.cuit!.isNotEmpty)
                const SizedBox(height: defaultPadding / 2),
              if (watch(providerToChange!).state!.camion!.isNotEmpty)
                Text("Camion: ${watch(providerToChange!).state!.camion!}"),
              if (watch(providerToChange!).state!.camion!.isNotEmpty)
                const SizedBox(height: defaultPadding / 2),
              if (watch(providerToChange!).state!.acoplado!.isNotEmpty)
                Text("Acoplado: ${watch(providerToChange!).state!.acoplado!}"),
            ],
          );
        },
      );

  Widget selectButton() {
    return Consumer(
      builder: (context, watch, child) {
        if (watch(providerToChange!).state!.nombre!.isNotEmpty &&
            watch(providerToChange!).state!.cuit!.isNotEmpty) {
          return deleteButton(context);
        } else {
          return arrowButton(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return GestureDetector(
      onTap: () {
        if (watch(providerToChange!).state!.nombre!.isEmpty &&
            watch(providerToChange!).state!.cuit!.isEmpty) {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) {
              return TransferDataBottomSheet(
                tipo: tipo,
                text: text,
                providerToChange: providerToChange,
              );
            },
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        margin: const EdgeInsets.all(defaultPadding / 2),
        alignment: Alignment.centerLeft,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: dataNameText(),
                  ),
                  Expanded(child: selectButton()),
                  const SizedBox(height: defaultPadding / 2),
                ],
              ),
              Consumer(
                builder: (context, watch, child) {
                  if (watch(providerToChange!).state!.nombre!.isNotEmpty &&
                      watch(providerToChange!).state!.cuit!.isNotEmpty &&
                      watch(providerToChange!).state!.tipo! != "chofer") {
                    return dataTexts();
                  } else {
                    return const SizedBox(
                      height: 0,
                      width: 0,
                    );
                  }
                },
              ),
              if (watch(providerToChange!).state!.tipo == "chofer")
                dataTextsIfChofer()
            ],
          ),
        ),
      ),
    );
  }
}
