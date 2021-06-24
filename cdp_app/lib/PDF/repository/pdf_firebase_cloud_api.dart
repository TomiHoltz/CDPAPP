import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/PDF/ui/screens/PdfsListScreen/widgets/uploaded_file_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PdfFirebaseCloudApi {
  final FirebaseFirestore firebaseCloud = FirebaseFirestore.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  void uploadPdfFile(PdfFile file) {
    firebaseCloud
        .collection(currentUser!.uid)
        .doc('pdfs')
        .collection('pdfFiles')
        .doc(file.pdfName)
        .set(
      {
        'pdfUrl': "${currentUser!.uid}/${file.pdfName}",
        'pdfName': file.pdfName,
        'availableCDPs': file.availableCDPs,
        'issuedCDPs': file.issuedCDPs,
        'time': file.time,
      },
    );
  }

  List<UploadedFileItem> buildUploadedFileItems(
      {required List<DocumentSnapshot<Map<String, dynamic>>> list}) {
    final List<UploadedFileItem> files = [];
    for (final pdf in list) {
      files.add(
        UploadedFileItem(
          userFile: PdfFile(
            pdfUrl: pdf.get('pdfUrl') as String,
            pdfName: pdf.get('pdfName') as String,
            availableCDPs: pdf.get('availableCDPs') as double,
            issuedCDPs: pdf.get('issuedCDPs') as double,
            time: pdf.get('time') as Timestamp,
          ),
        ),
      );
    }
    return files;
  }
}
