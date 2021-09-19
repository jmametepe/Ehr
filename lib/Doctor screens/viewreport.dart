import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';


class ViewReport extends StatefulWidget {
  final String url;

  ViewReport({this.url});

  @override
  _ViewReportState createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {
  bool _isLoading = true;
  PDFDocument document;



  @override

  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/sample.pdf');

    setState(() => _isLoading = false);
  }

  changePDF(value) async {
    setState(() => _isLoading = true);
    document = await PDFDocument.fromURL(widget.url);

    setState(() => _isLoading = false);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Report"),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: _isLoading?
        CircularProgressIndicator(color: Colors.purple,):
            PDFViewer(document: document, zoomSteps: 1,)
      ),
    );
  }
}
