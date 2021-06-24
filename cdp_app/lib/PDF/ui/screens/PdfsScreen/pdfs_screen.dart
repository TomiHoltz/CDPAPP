import 'package:cdp_app/PDF/providers/pdf_cloud_providers.dart';
import 'package:cdp_app/PDF/repository/pdf_cloud_repository.dart';
import 'package:cdp_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PdfsScreen extends ConsumerWidget {
  ///Here we have a list of the PdfFiles that the user uploaded to Firebase
  const PdfsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
  final PdfCloudRepository cloudRepository = PdfCloudRepository();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: StreamBuilder(
        stream: watch(pdfsFirebaseCollectionProvider).state,
        builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              return ListView(
                children: cloudRepository.buildUploadedFileItems(list: snapshot.data!.docs),
              );
          }
        },
      ),
    );
  }
}
