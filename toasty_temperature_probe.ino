#include <ESP8266HTTPClient.h>
#include <ESP8266WiFi.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include "secrets.h"

#define ONE_WIRE_BUS 2
#define oneHour 3600000000

OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature thermometer(&oneWire);

const char* ssid = SECRET_SSID;
const char* password = SECRET_PASSWORD;
const char* host = SECRET_HOST;

void setup() {
  Serial.begin(9600);
  thermometer.begin();

  Serial.print("Connecting to wifi...");
  WiFi.begin(ssid, password);
  Serial.println("ok!");
}

void loop() {
  if ((WiFi.status() == WL_CONNECTED)) {
    float currentTemperature = getCurrentTemperature();
    postCurrentTemperatureToServer(currentTemperature);

    ESP.deepSleep(oneHour);
  }
}

float getCurrentTemperature() {
  Serial.print("Reading temperature...");
  thermometer.requestTemperatures();
  Serial.println("done!");

  float currentTemperature = thermometer.getTempCByIndex(0);

  Serial.print("Current temperature: ");
  Serial.println(currentTemperature);

  return currentTemperature;
}

void postCurrentTemperatureToServer(float currentTemperature) {
  HTTPClient http;

  const char* endpoint = "/temperature_readings";
  http.begin(host, 3000, endpoint);
  http.addHeader("Content-Type", "application/json");

  Serial.println("");
  Serial.print("Sending temperature to server...");
  String params = buildParams(currentTemperature);
  int statusCode = http.POST(params);
  Serial.println("done!");

  Serial.println("");
  Serial.print("Status code from server: ");
  Serial.println(statusCode);
}

String buildParams(float temperature) {
  String finalParams;
  String sensorParamKey = "\"sensor_name\":";
  String sensorValue = "\"office\"";
  String sensorParam = sensorParamKey + sensorValue;

  String temperatureParamKey = "\"degrees_celsius\":";
  String temperatureString = String(temperature);
  String temperatureValue = "\"" + temperatureString + "\"";
  String temperatureParam = temperatureParamKey + temperatureValue;


  finalParams += "{";
  finalParams += sensorParam;
  finalParams += ", ";
  finalParams += temperatureParam;
  finalParams += "}";

  return finalParams;
}
