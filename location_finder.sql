SET @lat1 = "38.52505627318625", @long1 ="-118.62491926921778";
SET @point = point(@long1,@lat1);

SET @city_id = (SELECT id FROM (SELECT id, latitude, longitude FROM  usa 
		ORDER BY (3959 * ACOS(COS(RADIANS(@lat1)) * COS(RADIANS(latitude)) * COS(RADIANS(longitude) - RADIANS(@long1)) + SIN(RADIANS(@lat1)) * SIN(RADIANS(latitude)))) LIMIT 1)as city);
SET @lat2 = (SELECT latitude FROM usa WHERE id = @city_id),
    @long2= (SELECT longitude FROM usa WHERE id = @city_id);


SELECT (
	SELECT city FROM usa WHERE id = @city_id) as city,(
    SELECT zip FROM usa WHERE id = @city_id) as zip,(
	SELECT state FROM usa WHERE id = @city_id) as state,(
    SELECT UPPER(name) FROM counties WHERE st_contains(the_geom,@point)) as county
