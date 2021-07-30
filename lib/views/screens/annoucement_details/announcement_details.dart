import 'package:flutter/material.dart';
import 'package:madrasah_app/views/constants.dart';
import 'package:madrasah_app/views/styles/styles.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ShowFullAnnoucement extends StatelessWidget {
  final String accouncementTitle;
  final String? contentString;
  final String? pdfURL;
  ShowFullAnnoucement(
      {Key? key,
      required this.accouncementTitle,
      this.pdfURL,
      this.contentString})
      : super(key: key);
  final ScrollController _scrollController = ScrollController();
  final PdfViewerController _pdfViewerController = PdfViewerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Text(
              accouncementTitle,
              maxLines: 3,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.openSans,
                  fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            contentString != null ? Text(contentString!) : Container(),
            SizedBox(
              height: 20,
            ),
            pdfURL != null
                ? SfPdfViewer.network(
                    pdfURL!,
                    controller: _pdfViewerController,
                    // canShowScrollStatus: false,
                  )
                : Container(),
          ],
        ),
      )),
    );
  }
}
