select * from crime_scene_report where date = "20180115" and type = "murder" and city = "SQL City"; -- Crime scene report for the murder 
-- that occurred on Jan.15, 2018, in SQL City

select * from person p inner join interview i on p.id=i.person_id;

SELECT *
FROM person
WHERE (name LIKE 'Annabel%' AND address_street_name = 'Franklin Ave')
   OR (address_street_name = 'Northwestern Dr' AND address_number = (SELECT MAX(address_number) FROM person)); -- Personal details of witnesses involved in the case
-- Morty Schapiro, Annabel Miller

SELECT transcript, p.id, p.name
FROM person p inner join interview i on i.person_id = p.id 
WHERE (name LIKE 'Annabel%' AND p.address_street_name = 'Franklin Ave')
   OR (p.address_street_name = 'Northwestern Dr' AND p.address_number = (SELECT MAX(p.address_number) FROM person p)); -- Recorded interviews of witnesses conducted after the murder
-- I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".
-- I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

select * from get_fit_now_member g inner join get_fit_now_check_in gg on gg.membership_id=g.id 
where g.id like "48Z%" and g.membership_status="gold"; -- Gym database using details obtained from the crime scene report and witness interviews


select * from drivers_license where plate_number like "%H42W%"; -- 183779,423327,664760 -- Car details associated with the crime scene.

-- 6
select * from person p inner join facebook_event_checkin f on f.person_id=p.id
and license_id in ('183779','423327','664760'); --  person id 67318 Jeremy Bowers -- Identify and collect personal details mentioned in the previous query

-- 7 
select * from get_fit_now_member where name="Jeremy Bowers"; -- who is identified in the previous query as a member of the gym
select * from interview where person_id = '67318'; -- Investigation from Jeremy Bowers. 
-- "I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017."

select * from drivers_license where car_make = 'Tesla' and car_model='Model S' 
and gender = 'female' and hair_color='red'; -- red hair female woman who drive Tesla Model S

select * from person where license_id in ('202298','291182','918773'); -- finding the person id of the above query
-- 78881,90700,99716

SELECT person_id, COUNT(*) as event_count, event_name
FROM facebook_event_checkin
WHERE event_name = "SQL Symphony Concert" AND date LIKE "201712%" AND person_id in ('78881','90700','99716')
GROUP BY person_id, event_name
HAVING event_count >= 3;  -- Person Id for the culprit is 99716 

select * from person where id = '99716'; -- Miranda Priestly is the culprit