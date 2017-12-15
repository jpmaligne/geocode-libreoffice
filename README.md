# geocode-libreoffice

This script call google geocode api to extract data from a LibreOffice calc file
containing text address to Longitude and Latitude.

Useful for GeoJson creation.

See xlsm file for example.

NB :

Phone format 10 char, trimed and remove dots `=SUBSTITUE(TEXTE(SUBSTITUE(CELL;".";"");"0000000000");" ";"")`
