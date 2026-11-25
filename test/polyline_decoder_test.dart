/* import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:polyline_decoder/polyline_decoder.dart' as ffi_decoder;

void main() {
  /// Pure Dart int-based decoder
  List<gmaps.LatLng> decodeInt(String polyline) {
    final coordinates = <gmaps.LatLng>[];
    int index = 0;
    int lat = 0;
    int lng = 0;

    while (index < polyline.length) {
      int b;
      int shift = 0;
      int result = 0;

      // Decode latitude
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      // Decode longitude
      shift = 0;
      result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      coordinates.add(gmaps.LatLng(lat / 1e5, lng / 1e5));
    }
    return coordinates;
  }

  /// BigInt-based Dart decoder
  List<gmaps.LatLng> decodeBigInt(String encoded) {
    final points = <gmaps.LatLng>[];
    int index = 0;
    int lat = 0;
    int lng = 0;
    final BigInt Big0 = BigInt.zero;
    final BigInt Big0x1f = BigInt.from(0x1f);
    final BigInt Big0x20 = BigInt.from(0x20);

    while (index < encoded.length) {
      int shift = 0;
      BigInt result = Big0;
      BigInt b;

      // Latitude
      do {
        b = BigInt.from(encoded.codeUnitAt(index++) - 63);
        result |= (b & Big0x1f) << shift;
        shift += 5;
      } while (b >= Big0x20);
      int dLat = result.isOdd
          ? (~(result >> 1)).toInt()
          : (result >> 1).toInt();
      lat += dLat;

      // Longitude
      shift = 0;
      result = Big0;
      do {
        b = BigInt.from(encoded.codeUnitAt(index++) - 63);
        result |= (b & Big0x1f) << shift;
        shift += 5;
      } while (b >= Big0x20);
      int dLng = result.isOdd
          ? (~(result >> 1)).toInt()
          : (result >> 1).toInt();
      lng += dLng;

      points.add(gmaps.LatLng(lat / 1e5, lng / 1e5));
    }
    return points;
  }

  /// FFI-based decoder wrapper
  List<gmaps.LatLng> decodeFFI(String polyline) {
    final result = ffi_decoder.PolylineDecoder.decode(polyline);
    return result.map((p) => gmaps.LatLng(p.latitude, p.longitude)).toList();
  }

  /// Compare lists within tolerance
  bool comparePoints(
    List<gmaps.LatLng> a,
    List<gmaps.LatLng> b, {
    double tolerance = 1e-6,
  }) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if ((a[i].latitude - b[i].latitude).abs() > tolerance ||
          (a[i].longitude - b[i].longitude).abs() > tolerance) {
        return false;
      }
    }
    return true;
  }

  /// Measure average execution time over N runs
  Duration measureAvg(void Function() fn, int runs) {
    final sw = Stopwatch();
    Duration total = Duration.zero;
    for (var i = 0; i < runs; i++) {
      sw
        ..reset()
        ..start();
      fn();
      sw.stop();
      total += sw.elapsed;
    }
    return Duration(microseconds: (total.inMicroseconds / runs).round());
  }

  const basePolyline = "}_seFf`ys@_@a@}@iAo@iA{@mBkAaD}Bo@a@eAcBkBu@u@";
  String makeLargePolyline(int repeat) =>
      List.filled(repeat, basePolyline).join();

  group('Correctness + Multi-Scale Performance', () {
    final scenarios = {
      'Small (1x)': makeLargePolyline(1),
      'Medium (100x)': makeLargePolyline(100),
      'Large (10,000x)': makeLargePolyline(10000),
    };

    for (final entry in scenarios.entries) {
      final name = entry.key;
      final polyline = entry.value;

      test('Verify correctness + performance for $name', () {
        // Decode using all methods
        final ffiPts = decodeFFI(polyline);
        final intPts = decodeInt(polyline);
        final bigPts = decodeBigInt(polyline);

        // ✅ Correctness check
        expect(
          comparePoints(ffiPts, intPts),
          isTrue,
          reason: 'FFI vs int mismatch for $name',
        );
        expect(
          comparePoints(ffiPts, bigPts),
          isTrue,
          reason: 'FFI vs BigInt mismatch for $name',
        );

        // 🕒 Performance comparison (average over 10 runs)
        final ffiTime = measureAvg(() => decodeFFI(polyline), 10);
        final intTime = measureAvg(() => decodeInt(polyline), 10);
        final bigTime = measureAvg(() => decodeBigInt(polyline), 10);

        print('\n===== $name =====');
        print('FFI avg:    ${ffiTime.inMilliseconds} ms');
        print('Int avg:    ${intTime.inMilliseconds} ms');
        print('BigInt avg: ${bigTime.inMilliseconds} ms');
      });
    }
  });
}
 */
