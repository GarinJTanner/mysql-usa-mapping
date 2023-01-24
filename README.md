# Mapping the United States in MySQL

A relational database with people, places, cities, zip codes, states and county lines. Designed for MySQL 5.6 and greater. 

Run the scripts in this order:
1. locations.sql
2. USA.sql
3. counties.sql
4. usergen.sql

## Locations
A basic table of 265 Shake Shack locations. No index is needed for smaller tables.

## USA 
A table holding every city and zip code with their respective GPS coordinate. A powerful tool that I have used to pull a GPS coordinate based on a ZIP code. It is much easier to ask someone for their ZIP code than to ask them to give their coordinates.

## Counties
A table of multipolygon blobs. Using latitude and longitude coordinates, they draw the outline of counties. 

## Users
