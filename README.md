# Mapping the United States in MySQL

A relational database with people, places, cities, zip codes, states and county lines. Designed for MySQL 5.6 and greater. 

Run the scripts in this order:
1. USA.sql
2. counties.sql
3. usergen.sql
4. gps_from_zip.sql

## Locations
A basic table of 265 Shake Shack locations. No index is needed for smaller tables.

## USA 
A table holding every city and zip code with their respective GPS coordinate. A powerful tool that I have used to pull a GPS coordinate based on a ZIP code. It is much easier to ask someone for their ZIP code than to ask them to give their coordinates.

## Counties
A table of multipolygon blobs. Using latitude and longitude coordinates, they draw the outline of counties. 

## Usergen
Creates a table of random people. It will contain only a name, IP address and zip code for now.

## gps_from_zip
Using the zip code, it will assign a city, state, county and latitude/longitude coordinates.
