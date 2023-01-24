drop procedure if exists gps_from_zip;
DELIMITER $$;
CREATE PROCEDURE gps_from_zip()

BEGIN
DECLARE $user_count,$user_int INT default 1;
DECLARE $city,$zip,$state,$county varchar(30);
DECLARE $lat decimal(11,4);
DECLARE $long decimal(12,4);

set $user_count = (select count(id) from users),
	$user_int   = (select id from users group by id order by id asc limit 1);

myloop : loop

set $zip = (select zip from users where id = $user_int);
set $lat = (select latitude from usa where zip = $zip),
	  $long = (select longitude from usa where zip = $zip),
    $city = (select city from usa where zip = $zip),
	  $state = (select state from usa where zip = $zip);
set $county = (SELECT (name) FROM counties WHERE st_contains(the_geom,point($long,$lat)));

update users set latitude = $lat, longitude = $long, city = $city, county = $county, state = $state where id = $user_int;

set $user_int = $user_int + 1;	      
IF $user_int = $user_count + 1 THEN leave myloop;END IF;
end loop myloop;

END $$;
DELIMITER ;
call gps_from_zip;
