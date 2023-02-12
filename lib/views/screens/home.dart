import 'package:flutter/material.dart';
import '../../helpers/api_helper.dart';
import '../../model/weather.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Weather?> getData;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData = APIHelper.apiHelper.fechWeather(city: 'surat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Weather"),
      ),
      body: FutureBuilder(
          future: getData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("ERROR : ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              Weather? data = snapshot.data;
              if ((data != null)) {
                double celcius = data.temp - 273.15;
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.055,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    blurRadius: 3,
                                    color: Colors.black38,
                                    offset: Offset(2, 3)),
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: searchController,
                              decoration: InputDecoration(
                                enabled: true,
                                filled: true,
                                focusedBorder: InputBorder.none,
                                hintText: 'Search city weather',
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Colors.grey.shade800, fontSize: 17),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              String searchKey = searchController.text;
                              setState(() {
                                getData = APIHelper.apiHelper
                                    .fechWeather(city: searchKey);
                              });
                            },
                            icon: const Icon(Icons.search_rounded),

                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.main,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                data.desc,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                celcius.toString().split('.')[0],
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                " °C",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07,
                          ),
                          Text(
                            data.country,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          // Text(
                          //   data.country,
                          //   style: const TextStyle(
                          //     fontSize: 25,
                          //     color: Colors.black,
                          //   ),
                          // ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        color: Colors.lightBlue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            (data.desc == "Smoke" ||
                                    data.main == "Haze" ||
                                    data.main == "Fog")
                                ? Image.asset(
                                    "assets/gif/smoke1.gif",
                                  )
                                : (data.main == "Clouds")
                                    ? Image.asset(
                                        "assets/gif/clouds2.gif",
                                      )
                                    : (data.main == "Clear")
                                        ? Image.asset(
                                            "assets/gif/clear3.gif",
                                          )
                                        : (data.main == "Rain")
                                            ? Image.asset(
                                                "assets/gif/rain4.gif",
                                              )
                                            : (data.main == "Thunderstorm")
                                                ? Image.asset(
                                                    "assets/gif/snowman6.gif",
                                                  )
                                                : (data.main == "Snow")
                                                    ? Image.asset(
                                                        "assets/gif/smoke1.gif",
                                                      )
                                                    : (data.main == "Drizzle")
                                                        ? Image.asset(
                                                            "assets/gif/drizzle7.gif",
                                                          )
                                                        : Image.asset(
                                                            "assets/gif/snowman6.gif",
                                                          ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.035,
                          ),
                          Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.09,
                                width: MediaQuery.of(context).size.width * 0.18,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.air_rounded,
                                  size: 50,
                                ),
                              ),
                              Text(
                                "${data.speed}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.09,
                                width: MediaQuery.of(context).size.width * 0.18,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.thermostat,
                                  size: 50,
                                ),
                              ),
                              Text(
                                "${data.temp}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.09,
                                width: MediaQuery.of(context).size.width * 0.18,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.water,
                                  size: 50,
                                ),
                              ),
                              Text(
                                "${data.humidity}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.035,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text("Data Not Found"),
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      backgroundColor: Colors.white,
    );
  }
}
