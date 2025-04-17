import 'dart:io';
import 'package:baiti/views/widgets/loading_dialog.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../snack.dart';

class PdfGenerator {
  static createPdf(List<dynamic> listMyBills) async {
    LoadingDialog().dialog();
    try {
      String path = (await getApplicationDocumentsDirectory()).path;
      String fileName = "baiti_${DateTime.now().millisecondsSinceEpoch}.pdf";
      File file = File("$path/$fileName");

      pw.Document pdf = pw.Document();
      pw.Page page = await _createPage(listMyBills);
      pdf.addPage(page);

      Uint8List bytes = await pdf.save();
      await file.writeAsBytes(bytes);
      await OpenFile.open(file.path);
    } catch (e) {
      Snack().show(type: false, message: 'حدث خطأ أثناء إنشاء الملف');
    } finally {
      Get.back();
    }
  }

  static Future<pw.Page> _createPage(List<dynamic> listMyBills) async {
    try {
      final pw.Font font =
          pw.Font.ttf(await rootBundle.load("assets/fonts/amarai.ttf"));
      return pw.Page(
        textDirection: pw.TextDirection.rtl,
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            margin: const pw.EdgeInsets.all(24),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'تفاصيل الدفعات',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                    font: font,
                  ),
                ),
                pw.SizedBox(height: 12),
                pw.Table(
                  border:
                      pw.TableBorder.all(color: PdfColors.grey300, width: 1),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(2),
                    1: const pw.FlexColumnWidth(2),
                    2: const pw.FlexColumnWidth(3),
                  },
                  children: [
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.blue100),
                      children: [
                        _buildHeaderCell('التاريخ', font),
                        _buildHeaderCell('المبلغ', font),
                        _buildHeaderCell('اسم الدفعة', font),
                      ],
                    ),
                    ...listMyBills.asMap().entries.map((e) {
                      int index = e.key;
                      var item = e.value;
                      return pw.TableRow(
                        decoration: pw.BoxDecoration(
                          color: index.isEven
                              ? PdfColors.grey100
                              : PdfColors.white,
                        ),
                        children: [
                          _buildCell(item['date'], font: font),
                          _buildCell('${item['amount']} د.ك', font: font),
                          _buildCell(item['batchType'], font: font),
                        ],
                      );
                    }),
                  ],
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  static createGeneralPdf({
    required String total,
    required List listAllBills,
  }) async {
    LoadingDialog().dialog();
    try {
      String path = (await getApplicationDocumentsDirectory()).path;
      String fileName = "baiti_${DateTime.now().millisecondsSinceEpoch}.pdf";
      File file = File("$path/$fileName");

      pw.Document pdf = pw.Document();
      pw.Page page =
          await _createGeneralPage(total: total, listAllBills: listAllBills);
      pdf.addPage(page);

      Uint8List bytes = await pdf.save();
      await file.writeAsBytes(bytes);
      await OpenFile.open(file.path);
    } catch (e) {
      Snack().show(type: false, message: 'حدث خطأ أثناء إنشاء الملف العام');
    } finally {
      Get.back();
    }
  }

  static Future<pw.Page> _createGeneralPage({
    required String total,
    required List listAllBills,
  }) async {
    try {
      final font =
          pw.Font.ttf(await rootBundle.load("assets/fonts/amarai.ttf"));
      return pw.Page(
        textDirection: pw.TextDirection.rtl,
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            margin: const pw.EdgeInsets.all(24),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'المدفوعات العامة',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                    font: font,
                  ),
                ),
                pw.SizedBox(height: 12),
                pw.Text(
                  'إجمالي المدفوعات: $total د.ك',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.normal,
                    font: font,
                  ),
                ),
                pw.SizedBox(height: 12),
                pw.Table(
                  border:
                      pw.TableBorder.all(color: PdfColors.grey300, width: 1),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(2),
                    1: const pw.FlexColumnWidth(4),
                  },
                  children: [
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.blue100),
                      children: [
                        _buildHeaderCell('القيمة', font),
                        _buildHeaderCell('نوع الفاتورة', font),
                      ],
                    ),
                    ...listAllBills.asMap().entries.map((e) {
                      int index = e.key;
                      var item = e.value;
                      return pw.TableRow(
                        decoration: pw.BoxDecoration(
                          color: index.isEven
                              ? PdfColors.grey100
                              : PdfColors.white,
                        ),
                        children: [
                          _buildCell('${item['total']} د.ك', font: font),
                          _buildCell(item['name'], font: font),
                        ],
                      );
                    }),
                  ],
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  static pw.Widget _buildHeaderCell(String text, pw.Font font) {
    return pw.Container(
      alignment: pw.Alignment.center,
      padding: pw.EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 16,
          fontWeight: pw.FontWeight.bold,
          font: font,
        ),
      ),
    );
  }

  static pw.Widget _buildCell(String text, {pw.Font? font}) {
    return pw.Container(
      alignment: pw.Alignment.center,
      padding: pw.EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: pw.Text(
        text,
        maxLines: 1,
        overflow: pw.TextOverflow.clip,
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
          font: font,
        ),
      ),
    );
  }
}
