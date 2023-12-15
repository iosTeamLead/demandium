import 'dart:ui';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class MapScreen extends StatefulWidget {
  final AddressModel? address;
  const MapScreen({super.key, @required this.address});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  late LatLng _latLng;
  Set<Marker> _markers = {};
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _latLng = LatLng(double.parse(widget.address!.latitude!), double.parse(widget.address!.longitude!));
    _setMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'location'.tr),
      body: Center(
        child: SizedBox(
          width: Dimensions.webMaxWidth,
          child: Stack(children: [
            GoogleMap(
              minMaxZoomPreference: const MinMaxZoomPreference(0, 16),
              initialCameraPosition: CameraPosition(target: _latLng, zoom: 16),
              zoomGesturesEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              indoorViewEnabled: true,
              markers:_markers,
              onMapCreated: (controller) {
                _mapController = controller;
                _mapController!.setMapStyle(
                  Get.isDarkMode ? Get.find<ThemeController>().darkMap : Get.find<ThemeController>().lightMap,
                );
              },
            ),
            Positioned(
              left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeLarge, bottom: Dimensions.paddingSizeLarge,
              child: InkWell(
                onTap: () {
                  if(_mapController != null) {
                    _mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _latLng, zoom: 17)));
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    color: Theme.of(context).cardColor,
                    boxShadow: [BoxShadow(color: Colors.grey[300]!, spreadRadius: 3, blurRadius: 10)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(
                          widget.address!.addressType == 'home' ? Icons.home_outlined : widget.address!.addressType == 'office'
                              ? Icons.work_outline : Icons.location_on,
                          size: 30, color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text(widget.address!.addressType!, style: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor,
                            )),
                            Text(widget.address!.address!, style: ubuntuMedium),
                          ]),
                        ),
                      ]),
                      Text('- ${widget.address!.contactPersonName}', style: ubuntuMedium.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: Dimensions.fontSizeLarge,
                      )),
                      Text('- ${widget.address!.contactPersonNumber}', style: ubuntuRegular),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _setMarker() async {
    Uint8List destinationImageData = await convertAssetToUnit8List(Images.marker, width: 120);

    _markers = {};
    _markers.add(Marker(
      markerId: const MarkerId('marker'),
      position: _latLng,
      icon: BitmapDescriptor.fromBytes(destinationImageData),
    ));

    setState(() {});
  }

  Future<Uint8List> convertAssetToUnit8List(String imagePath, {int width = 50}) async {
    ByteData data = await rootBundle.load(imagePath);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!.buffer.asUint8List();
  }

}
