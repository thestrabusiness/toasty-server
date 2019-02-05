# Toasty Server

This repo contains the webserver for collecting temperature readings from various wifi-connected sensors places throughout my home.

The server runs continuously on a RaspberryPi listening for requests on the local network.

The sensors are built with Aadafruit Featherweight (arduino compatibile boards) connected to some temperature-sensing circuitry. They periodically wake up, take a reading and then POST it to the server.

Ultimately the goal of this project was to sense the temperature in various rooms of my apartment to enable control of a radiator cover/ventilation system.


