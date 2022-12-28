set @user_id = 3;
set @lat=(SELECT latitude FROM users WHERE id=@user_id),@long=(SELECT longitude FROM users WHERE id=@user_id);
SELECT 
(SELECT username FROM users WHERE id = @user_id) as username,(
SELECT ip_address FROM users WHERE id = @user_id) as ip_address,(
SELECT city FROM usa WHERE id = @city_id) as city,(
SELECT zip FROM usa WHERE id = @city_id) as zip,(
SELECT state FROM usa WHERE id = @city_id) as state,(
SELECT UPPER(name) FROM counties WHERE st_contains(the_geom,@point)) as county,(
SELECT latitude FROM users WHERE id = @user_id) as latitude,(
SELECT longitude FROM users WHERE id = @user_id) as longitude,(
SELECT phone_model FROM devices WHERE id in (SELECT device_id FROM user_devices WHERE user_id = @user_id)) as device,(

SELECT location FROM (SELECT *,
	
( 3959 * acos( cos( radians(@lat) ) * cos( radians( latitude ) ) 
* cos( radians( longitude ) - radians(@long) )
 + sin( radians(@lat) ) * sin(radians(latitude)) ) ) 
			AS distance 

FROM locations 

HAVING distance < 50
ORDER BY distance 
LIMIT 1)as location) as nearby_shake_shack,(
SELECT truncate(distance,3) FROM (SELECT *,
	
( 3959 * acos( cos( radians(@lat) ) * cos( radians( latitude ) ) 
* cos( radians( longitude ) - radians(@long) )
 + sin( radians(@lat) ) * sin(radians(latitude)) ) ) 
			AS distance 

FROM locations 

HAVING distance < 50
ORDER BY distance 
LIMIT 1)as distance) as shake_shack_distance
