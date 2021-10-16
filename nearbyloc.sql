drop procedure if exists nearbyloc;
DELIMITER //
CREATE PROCEDURE nearbyloc(in user_id int, in $distance int)
BEGIN
DECLARE $lat decimal(11,6);
DECLARE $long decimal(12,6);


SET @user_id = CONCAT('set @user_id=', user_id);
PREPARE stmt FROM @user_id;
EXECUTE stmt;
set $lat=(select latitude from users where id=@user_id),$long=(select longitude from users where id=@user_id);
DEALLOCATE PREPARE stmt;

select *,
	
( 3959 * acos( cos( radians($lat) ) * cos( radians( latitude ) ) 
* cos( radians( longitude ) - radians($long) )
 + sin( radians($lat) ) * sin(radians(latitude)) ) ) 
			AS distance 

from locations 

HAVING distance < $distance
ORDER BY distance 
LIMIT 0,50;

end//
DELIMITER ;

#call nearbyloc(1,50)
