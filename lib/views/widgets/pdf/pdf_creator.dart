import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfGenerator {
  static createPdf(var listMyBills) async {
    String path = (await getApplicationDocumentsDirectory()).path;
    File file = File("$path/baiti.pdf");

    pw.Document pdf = pw.Document();
    pw.Page page = await _createPage(listMyBills);
    pdf.addPage(page);

    Uint8List bytes = await pdf.save();
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  static Future<pw.Page> _createPage(var listMyBills) async {
    var font = await rootBundle.load("assets/fonts/amarai.ttf");
    return pw.Page(
      textDirection: pw.TextDirection.rtl,
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Container(
          margin: const pw.EdgeInsets.all(20),
          decoration: pw.BoxDecoration(
            color: PdfColor.fromHex('FFFFFF'),
            boxShadow: const [
              pw.BoxShadow(
                color: PdfColors.grey,
                spreadRadius: 1,
                blurRadius: 1,
                offset: PdfPoint(0, 0),
              ),
            ],
          ),
          child: pw.Table(
            children: [
              pw.TableRow(
                children: [
                  pw.Center(
                    child: pw.Padding(
                      padding: pw.EdgeInsets.symmetric(vertical: 14.h),
                      child: pw.Text(
                        'التاريخ',
                        style: pw.TextStyle(
                            fontSize: 15.sp,
                            fontWeight: pw.FontWeight.bold,
                            font: pw.Font.ttf(font)),
                      ),
                    ),
                  ),
                  pw.Center(
                    child: pw.Padding(
                      padding: pw.EdgeInsets.symmetric(vertical: 14.h),
                      child: pw.Text(
                        'المبلغ',
                        style: pw.TextStyle(
                            fontSize: 15.sp,
                            fontWeight: pw.FontWeight.bold,
                            font: pw.Font.ttf(font)),
                      ),
                    ),
                  ),
                  pw.Center(
                    child: pw.Padding(
                      padding: pw.EdgeInsets.symmetric(vertical: 14.h),
                      child: pw.Text(
                        'نوع الدفعة',
                        style: pw.TextStyle(
                            fontSize: 15.sp,
                            fontWeight: pw.FontWeight.bold,
                            font: pw.Font.ttf(font)),
                      ),
                    ),
                  ),
                ],
              ),
              ...listMyBills.asMap().entries.map((e) {
                int index = e.key;
                var item = e.value;
                return pw.TableRow(
                  decoration: pw.BoxDecoration(
                    color: index.isEven ? PdfColor.fromHex('C2DDFF') : null,
                  ),
                  children: [
                    pw.Container(
                      width: double.infinity,
                      alignment: pw.Alignment.center,
                      padding: pw.EdgeInsets.symmetric(vertical: 14.w),
                      // color: Colors.transparent,
                      child: pw.Text(
                        item['date'],
                        maxLines: 1,
                        overflow: pw.TextOverflow.clip,
                        style: pw.TextStyle(fontSize: 13.sp),
                      ),
                    ),
                    pw.Container(
                      width: double.infinity,
                      alignment: pw.Alignment.center,
                      padding: pw.EdgeInsets.symmetric(vertical: 14.w),
                      // color: Colors.transparent,
                      child: pw.Text(
                        '${item['amount'].toString()} د.ك',
                        maxLines: 1,
                        overflow: pw.TextOverflow.clip,
                        style: pw.TextStyle(
                            fontSize: 13.sp, font: pw.Font.ttf(font)),
                      ),
                    ),
                    pw.Container(
                      width: double.infinity,
                      alignment: pw.Alignment.center,
                      padding: pw.EdgeInsets.symmetric(vertical: 14.w),
                      // color: Colors.transparent,
                      child: pw.Text(
                        item['batchType'],
                        maxLines: 1,
                        overflow: pw.TextOverflow.clip,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(fontSize: 13.sp),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  static createGeneralPdf(
      {required String total, required List listAllBills}) async {
    String path = (await getApplicationDocumentsDirectory()).path;
    File file = File("$path/baiti.pdf");

    pw.Document pdf = pw.Document();
    pw.Page page =
        await _createGeneralPage(total: total, listAllBills: listAllBills);
    pdf.addPage(page);

    Uint8List bytes = await pdf.save();
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  static Future<pw.Page> _createGeneralPage(
      {required String total, required List listAllBills}) async {
    var font = await rootBundle.load("assets/fonts/amarai.ttf");
    return pw.Page(
      textDirection: pw.TextDirection.rtl,
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Container(
          margin: const pw.EdgeInsets.all(20),
          decoration: pw.BoxDecoration(
            color: PdfColor.fromHex('FFFFFF'),
            boxShadow: const [
              pw.BoxShadow(
                color: PdfColors.grey,
                spreadRadius: 1,
                blurRadius: 1,
                offset: PdfPoint(0, 0),
              ),
            ],
          ),
          child: pw.Table(
            children: [
              pw.TableRow(
                children: [
                  pw.Container(
                    width: double.infinity,
                    alignment: pw.Alignment.center,
                    padding: pw.EdgeInsets.symmetric(vertical: 14.w),
                    // color: Colors.transparent,
                    child: pw.Text(
                      total,
                      maxLines: 1,
                      overflow: pw.TextOverflow.clip,
                      style: pw.TextStyle(fontSize: 13.sp),
                    ),
                  ),
                  pw.Center(
                    child: pw.Padding(
                      padding: pw.EdgeInsets.symmetric(vertical: 14.h),
                      child: pw.Text(
                        'إجمالي المدفوعات',
                        style: pw.TextStyle(
                            fontSize: 15.sp,
                            fontWeight: pw.FontWeight.bold,
                            font: pw.Font.ttf(font)),
                      ),
                    ),
                  ),
                ],
              ),
              ...listAllBills.asMap().entries.map((e) {
                int index = e.key;
                var item = e.value;
                return pw.TableRow(
                  decoration: pw.BoxDecoration(
                    color: index.isEven ? PdfColor.fromHex('C2DDFF') : null,
                  ),
                  children: [
                    pw.Container(
                      width: double.infinity,
                      alignment: pw.Alignment.center,
                      padding: pw.EdgeInsets.symmetric(vertical: 14.w),
                      // color: Colors.transparent,
                      child: pw.Text(
                        '${item['total'].toString()} د.ك',
                        maxLines: 1,
                        overflow: pw.TextOverflow.clip,
                        style: pw.TextStyle(
                            fontSize: 13.sp, font: pw.Font.ttf(font)),
                      ),
                    ),
                    pw.Container(
                      width: double.infinity,
                      alignment: pw.Alignment.center,
                      padding: pw.EdgeInsets.symmetric(vertical: 14.w),
                      // color: Colors.transparent,
                      child: pw.Text(
                        item['name'],
                        maxLines: 1,
                        overflow: pw.TextOverflow.clip,
                        style: pw.TextStyle(fontSize: 13.sp),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
