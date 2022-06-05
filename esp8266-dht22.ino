#include <Arduino.h>
#include "pins_arduino.h"
#include <DHT.h>
#include <WiFiClient.h>
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>

#define LED1 D4
#define LED2 D0
bool LEDState=true;

#define DHTPIN1  D3
#define DHTTYPE DHT22   // DHT 22  (AM2302)
unsigned long lastDHTRead = 0;
DHT dht1(DHTPIN1, DHTTYPE); //// Initialize DHT sensor for normal 16mhz Arduino
float h;
float c;
float f;

const char* ssid         = "monsoon";
const char* password     = "S00n3rs!";
const String serverName  = "http://192.168.1.3";
const int httpPort       = 3000;
char httpRequestData[100];

//const char* serverName   = "http://192.168.1.157:8086/write?db=home";
//const char* serverName = "http://192.168.1.179:8086/write?db=home&u=mqtt&p=mqtt";

void readDHT();
void sendData();

void setup() {
  Serial.begin(115200);
  dht1.begin();
  lastDHTRead=millis();

  Serial.println(LED1);
  Serial.println(LED2);
  pinMode(LED1, OUTPUT);     // Initialize the LED_BUILTIN pin as an output
  pinMode(LED2, OUTPUT);     // Initialize the LED_BUILTIN pin as an output  

  WiFi.begin(ssid, password);
  Serial.println("Connecting");
  while(WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    digitalWrite(LED1, !digitalRead(LED1));
    digitalWrite(LED2, !digitalRead(LED2));
    delay(500);
  }
  Serial.println("");
  Serial.println(WiFi.localIP());
}

void loop() {
  if (millis() - lastDHTRead > 60000) {
    readDHT();
    sendData();
    if (LEDState==true) {
      digitalWrite(LED1, LOW);   // Turn the LED on by making the voltage LOW
      digitalWrite(LED2, HIGH);   // Turn the LED on by making the voltage LOW
      LEDState=false;
    } else {
      digitalWrite(LED1, HIGH);  // Turn the LED off by making the voltage HIGH
      digitalWrite(LED2, LOW);  // Turn the LED off by making the voltage HIGH
      LEDState=true;
    }
    lastDHTRead=millis();
  }
}

void readDHT() {
  IPAddress myIP=WiFi.localIP();
  h = dht1.readHumidity();
  c = dht1.readTemperature();
  f = dht1.readTemperature(true);

  String octet = String(myIP[3]);
  int sLen = octet.length();
  String lastDigit=octet.substring(sLen-1);
  sprintf(httpRequestData, "{\"ip\":\"%i.%i.%i.%i\",\"last_digit\":\"%s\",\"tempf\":%.2f,\"tempc\":%.2f,\"humidity\":%.2f}", myIP[0], myIP[1], myIP[2], myIP[3], lastDigit, f, c, h); 
}

void sendData(){
  WiFiClient wificlient;
  HTTPClient http;
  String serverPath=serverName+":"+String(httpPort)+"/airqual";
  Serial.println(serverPath + " " + String(httpRequestData));
  
  http.addHeader("Content-Type", "application/json");
  http.begin(wificlient, serverPath.c_str());
  int httpResponseCode = http.POST(httpRequestData);
  Serial.println("HTTP Response code: " + String(httpResponseCode));
  http.end();
} 

