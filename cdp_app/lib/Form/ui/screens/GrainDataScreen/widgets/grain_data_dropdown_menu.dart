import 'package:cdp_app/Form/model/grain_data.dart';
import 'package:cdp_app/Form/model/procedencia_mercaderia.dart';
import 'package:cdp_app/Form/ui/screens/GrainDataScreen/widgets/grain_bottom_sheet_field.dart';
import 'package:cdp_app/Form/ui/screens/GrainDataScreen/widgets/grain_data_bottom_sheet.dart';
import 'package:cdp_app/Form/ui/screens/GrainDataScreen/widgets/procedencia_bottom_sheet.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GrainDataDropdownMenu extends ConsumerWidget {
  const GrainDataDropdownMenu(
      {Key? key,
      required this.tipo,
      required this.text,
      this.providerToChange,
      this.procedenciaProviderToChange})
      : super(key: key);

  final String? tipo;
  final String? text;
  final StateProvider<GrainData?>? providerToChange;
  final StateProvider<ProcedenciaMercaderia>? procedenciaProviderToChange;

  Widget dataName() => Expanded(
        flex: 2,
        child: Text(
          text!,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      );

  Widget showBottomSheetButton(BuildContext context) => Expanded(
        child: Container(
          alignment: Alignment.centerRight,
          child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    if (tipo == "procedenciaMercaderia") {
                      return ProcedenciaBottomSheet(
                        text: text,
                        tipo: tipo,
                        providerToChange: procedenciaProviderToChange,
                      );
                    } else if (tipo == "contratoNro" ||
                        tipo == "kgsEstimados" ||
                        tipo == "pesoBruto" ||
                        tipo == "pesoTara" ||
                        tipo == "pesoNeto" ||
                        tipo == "observaciones") {
                      return GrainBottomSheetField(
                        text: text,
                        tipo: tipo,
                        providerToChange: providerToChange,
                      );
                    }
                    return GrainDataBottomSheet(
                      text: text,
                      tipo: tipo,
                      providerToChange: providerToChange,
                    );
                  },
                );
              },
              icon: const Icon(Icons.arrow_drop_down)),
        ),
      );

  Widget deleteButton(BuildContext context) => Container(
        alignment: Alignment.centerRight,
        child: IconButton(
          onPressed: () {
            if (tipo != "procedenciaMercaderia") {
              context.read(providerToChange!).state = GrainData(
                text: "",
                tipo: tipo,
              );
            } else {
              context.read(procedenciaProviderToChange!).state =
                  ProcedenciaMercaderia(
                      direccion: "",
                      provincia: "",
                      localidad: "",
                      establecimiento: "",
                      renspa: "");
            }
          },
          icon: const Icon(Icons.delete),
        ),
      );

  Widget dataTexts() => Consumer(
        builder: (context, watch, child) {
          if (watch(providerToChange!).state!.text!.isNotEmpty) {
            return Row(
              children: [
                Expanded(
                  child: Text(watch(providerToChange!).state!.text!),
                ),
              ],
            );
          } else {
            return const SizedBox(
              height: 0,
              width: 0,
            );
          }
        },
      );

  Widget dataTextsIfProcedenciaMercaderia() => Consumer(
        builder: (context, watch, child) {
          if (watch(procedenciaProviderToChange!).state.direccion!.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          watch(procedenciaProviderToChange!).state.direccion!),
                    ),
                  ],
                ),
                const SizedBox(height: defaultPadding / 2),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          "${watch(procedenciaProviderToChange!).state.provincia!} - ${watch(procedenciaProviderToChange!).state.localidad!} - ${watch(procedenciaProviderToChange!).state.establecimiento!} "),
                    ),
                  ],
                ),
                const SizedBox(height: defaultPadding / 2),
                Text(
                  "RENSPA: ${watch(procedenciaProviderToChange!).state.renspa!}",
                ),
              ],
            );
          } else {
            return const SizedBox(
              height: 0,
              width: 0,
            );
          }
        },
      );

  Widget selectButton() {
    return Consumer(
      builder: (context, watch, child) {
        if (tipo != 'procedenciaMercaderia') {
          if (watch(providerToChange!).state!.text!.isNotEmpty) {
            return deleteButton(context);
          } else {
            return showBottomSheetButton(context);
          }
        } else {
          if (watch(procedenciaProviderToChange!).state.direccion!.isNotEmpty) {
            return deleteButton(context);
          } else {
            return showBottomSheetButton(context);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return GestureDetector(
      onTap: () {
        if (watch(providerToChange!).state!.text!.isEmpty &&
            tipo != "procedenciaMercaderia") {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              if (tipo == "contratoNro" ||
                  tipo == "kgsEstimados" ||
                  tipo == "pesoBruto" ||
                  tipo == "pesoTara" ||
                  tipo == "pesoNeto" ||
                  tipo == "observaciones") {
                return GrainBottomSheetField(
                  text: text,
                  tipo: tipo,
                  providerToChange: providerToChange,
                );
              }
              return GrainDataBottomSheet(
                text: text,
                tipo: tipo,
                providerToChange: providerToChange,
              );
            },
          );
        } else if (watch(procedenciaProviderToChange!)
                .state
                .direccion!
                .isEmpty &&
            tipo == "procedenciaMercaderia") {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return ProcedenciaBottomSheet(
                text: text,
                tipo: tipo,
                providerToChange: procedenciaProviderToChange,
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
            borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                children: [
                  dataName(),
                  selectButton(),
                  const SizedBox(height: defaultPadding / 2),
                ],
              ),
              if (tipo != "procedenciaMercaderia") dataTexts(),
              if (tipo == "procedenciaMercaderia")
                dataTextsIfProcedenciaMercaderia(),
            ],
          ),
        ),
      ),
    );
  }
}
