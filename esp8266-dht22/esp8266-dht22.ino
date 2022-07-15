#include <Arduino.h>
#include "pins_arduino.h"
#include <DHT.h>
#include <WiFiClient.h>
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>

#include <ESPAsyncTCP.h>
#include <ESPAsyncWebServer.h>
#include <AsyncElegantOTA.h>

#define LED1 D4
#define LED2 D0
bool LEDState=true;
long unsigned int ledFlashRate=60000;
long unsigned int lastLEDFlash;

#define DHTPIN1  D3
#define DHTTYPE DHT22   // DHT 22  (AM2302)
unsigned long lastDHTRead = 0;

DHT dht1(DHTPIN1, DHTTYPE); //// Initialize DHT sensor for normal 16mhz Arduino
float h;
float c;
float f;

const char* ssid         = "monsoon";
const char* password     = "S00n3rs!";
const String serverName  = "http://192.168.1.4";
const int httpPort       = 3000;
char httpRequestData[200];
bool lastNetworkRestart=false;

AsyncWebServer server(80);

void readDHT();
void sendData();

void setup() {
  Serial.begin(115200);
  dht1.begin();
  lastDHTRead=millis();

  pinMode(LED1, OUTPUT);     // Initialize the LED_BUILTIN pin as an output
  pinMode(LED2, OUTPUT);     // Initialize the LED_BUILTIN pin as an output
  digitalWrite(LED1, true);
  digitalWrite(LED2, false);

  manageWIFI();  //This will connect to the WiFi
}

void loop() {
  if ( millis() - lastDHTRead > 60000 ) {
    readDHT();
    sendData();
    flashLED();
    lastDHTRead=millis();
  }
    
  if ( millis() - lastLEDFlash > ledFlashRate ) {    
    flashLED();
  }    
}

void manageWIFI(){
  WiFi.disconnect();
  WiFi.begin(ssid, password);
  Serial.println();
  Serial.println();
  Serial.println("Connecting");
  while(WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    flashLED();
    delay(500);
  }
  Serial.println("");
  Serial.print("Connected to ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
  Serial.print("MAC Address: ");
  Serial.println(WiFi.macAddress());
  lastNetworkRestart = "network restart";

  server.on("/", HTTP_GET, [](AsyncWebServerRequest *request) {
    request->send(200, "text/plain", "Storage Room");
  });

  AsyncElegantOTA.begin(&server);    // Start ElegantOTA
  server.begin();
  Serial.println("HTTP server started");  
}

void flashLED(){
  lastLEDFlash=millis();
  digitalWrite(LED1, !digitalRead(LED1));
  digitalWrite(LED2, !digitalRead(LED2));
}

void readDHT() {
  IPAddress myIP=WiFi.localIP();
  h = dht1.readHumidity();
  c = dht1.readTemperature();
  f = dht1.readTemperature(true);

  String octet = String(myIP[3]);
  int sLen = octet.length();
  String lastDigit=octet.substring(sLen-1);
  sprintf(httpRequestData, "{\"ip\":\"%i.%i.%i.%i\",\"last_digit\":\"%s\",\"room\":\"StorageRoom\",\"tempf\":%.2f,\"tempc\":%.2f,\"humidity\":%.2f}", myIP[0], myIP[1], myIP[2], myIP[3], lastDigit.c_str(), f, c, h);
  Serial.println(httpRequestData);
}

void sendData(){
  WiFiClient wificlient;
  HTTPClient http;
  String serverPath=serverName+":"+String(httpPort)+"/airqual";
  Serial.println(serverPath + " " + httpRequestData);
  
  http.addHeader("Content-Type", "application/json");
  http.begin(wificlient, serverPath.c_str());
  int httpResponseCode = http.POST(httpRequestData);
  http.end();

  Serial.println("HTTP Response code: " + String(httpResponseCode));
  if (httpResponseCode != 201){
    manageWIFI();
    lastNetworkRestart=true; 
    ledFlashRate=1000;
  } else {
    ledFlashRate=60000;
    lastNetworkRestart=false;
  }
}
