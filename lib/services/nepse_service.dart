import 'package:http/http.dart' as http;
import 'package:share_portfolio/data/database/portfolio_database.dart';
import 'dart:io';

class NEPSEService {
  static Future<List<Company>> liveData() async {
    try {
      var source =
          (await http.get('https://merolagani.com/LatestMarket.aspx')).body;
      var table = source.split('<tbody>').last.split('</tbody>').first;
      var trs = table.split('</tr>');
      return trs
          .map((tr) {
            try {
              return Company(
                name: tr.split("title='")[1].split("'>").first,
                ltp: double.tryParse(tr
                        .split("<td class='text-right'>")[1]
                        .split("</td>")
                        .first
                        .replaceAll(',', '')) ??
                    0.0,
              );
            } catch (e) {
              return Company(
                name: 'Cannot Retrieve',
                ltp: 0.0,
              );
            }
          })
          .take(trs.length - 1)
          .toList();
    } on SocketException catch (_) {
      throw SocketException('NO INTERNET');
    }
  }
}
