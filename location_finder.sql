SET @lat1 = "41.29358764548033", 
	@long1 ="-96.14311978546014",
    @point = point(@long1,@lat1);
    
SET @city_id = (SELECT id FROM (SELECT id, latitude, longitude FROM  usa 
	HAVING (3959 * ACOS(COS(RADIANS(@lat)) * COS(RADIANS(latitude)) * COS(RADIANS(longitude) - RADIANS(@long)) + SIN(RADIANS(@lat)) * SIN(RADIANS(latitude)))) < 15 
	ORDER BY (3959 * ACOS(COS(RADIANS(@lat)) * COS(RADIANS(latitude)) * COS(RADIANS(longitude) - RADIANS(@long)) + SIN(RADIANS(@lat)) * SIN(RADIANS(latitude)))) LIMIT 1)as city);
SET @lat2 = (SELECT latitude FROM usa WHERE id = @city_id),
	@long2= (SELECT longitude FROM usa WHERE id = @city_id);
    
SELECT (
	SELECT city FROM usa WHERE id = @city_id) as city,(
	SELECT state FROM usa WHERE id = @city_id) as state,(
  SELECT name FROM counties WHERE st_contains(the_geom,@point)) as county
	
