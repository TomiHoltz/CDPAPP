import 'package:cdp_app/CDP/models/cdp.dart';
import 'package:cdp_app/CDP/repository/cdp_api.dart';
import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/constants.dart';
import 'package:flutter/material.dart';

class IssuedCdpListItem extends StatefulWidget {
  const IssuedCdpListItem({Key? key, required this.cdp, required this.userFile})
      : super(key: key);

  final CDP cdp;
  final PdfFile userFile;

  @override
  _IssuedCdpListItemState createState() => _IssuedCdpListItemState();
}

class _IssuedCdpListItemState extends State<IssuedCdpListItem> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 2),
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 4),
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Text(
            widget.cdp.cdpName,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              final CdpApi cdpApi = CdpApi();
              cdpApi.copyCDP(context,
                  pdfFile: widget.userFile, cdp: widget.cdp);
            },
            icon: const Icon(Icons.copy),
          ),
          IconButton(
            onPressed: () {
              final CdpApi cdpApi = CdpApi();
              setState(() {
                isLoading = true;
              });
              cdpApi
                  .fillPdfFileWithCdpData(
                      file: widget.userFile, cdp: widget.cdp)
                  .whenComplete(() {
                setState(() {
                  isLoading = false;
                });
              });
            },
            icon: isLoading
                ? const CircularProgressIndicator()
                : const Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }
}
