import 'package:cdp_app/Form/ui/screens/DestinationScreen/destination_screen.dart';
import 'package:cdp_app/Form/ui/screens/GrainDataScreen/grain_data_screen.dart';
import 'package:cdp_app/Form/ui/screens/SwornDeclarationScreen/sworn_declaration_screen.dart';
import 'package:cdp_app/Form/ui/screens/TransferDataScreen/transfer_data_screen.dart';
import 'package:cdp_app/Form/ui/screens/TransportDataScreen/transport_data_screen.dart';
import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  /// Here the user will give us some data that we need to create the PDF later
  const FormScreen({Key? key, required this.pdfFile}) : super(key: key);

  final PdfFile pdfFile;

  @override
  Widget build(BuildContext context) {
    final tabs = <Tab>[
      const Tab(text: "Traslado"),
      const Tab(text: "Granos"),
      const Tab(text: "Destino"),
      const Tab(text: "Transporte"),
      const Tab(text: "D.J"),
    ];
    final tabsPages = [
      const TransferDataScreen(),
      const GrainDataScreen(),
      const DestinationScreen(),
      const TransportDataScreen(),
      SwornDeclarationScreen(selectedFile: pdfFile),
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: false,
          title: const Text(
            "Llenar carta de porte",
            style: TextStyle(
              color: darkColor,
            ),
          ),
          bottom: TabBar(
            tabs: tabs,
          ),
        ),
        body: TabBarView(children: tabsPages),
      ),
    );
  }
}
