-- dropping enum types
DROP TYPE IF EXISTS nationality_enum CASCADE;
DROP TYPE IF EXISTS danger_category_enum CASCADE;
DROP TYPE IF EXISTS damage_enum CASCADE;
DROP TYPE IF EXISTS severity_damage_enum CASCADE;
DROP TYPE IF EXISTS gender_enum CASCADE;
DROP TYPE IF EXISTS type_of_search_enum CASCADE;


-- dropping tables
DROP TABLE IF EXISTS person CASCADE;
DROP TABLE IF EXISTS search CASCADE;
DROP TABLE IF EXISTS box CASCADE;
DROP TABLE IF EXISTS material_box CASCADE;
DROP TABLE IF EXISTS location CASCADE;
DROP TABLE IF EXISTS spider CASCADE;
DROP TABLE IF EXISTS state_of_map CASCADE;
DROP TABLE IF EXISTS map CASCADE;
DROP TABLE IF EXISTS boat CASCADE;
DROP TABLE IF EXISTS map_in_box CASCADE;

-- create enums
CREATE TYPE nationality_enum AS ENUM ('American', 'British', 'Canadian', 'Chinese', 'French', 'German', 'Indian', 'Japanese', 'Russian', 'Spanish');
CREATE TYPE danger_category_enum AS ENUM ('low', 'moderate', 'high', 'critical', 'unknown');
CREATE TYPE gender_enum AS ENUM ('male', 'female', 'indefinite');
CREATE TYPE damage_enum AS ENUM ('warped', 'moldy', 'torn', 'faded', 'stained', 'burnt', 'water_damaged','insect_damage', 'missing_parts', 'nothing');
CREATE TYPE severity_damage_enum AS ENUM ('minor', 'severe', 'critical', 'intact');
CREATE TYPE type_of_search_enum AS ENUM ('boat', 'map', 'box');


-- create tables

CREATE TABLE location (
    location_id SERIAL PRIMARY KEY,
    coordinates POINT NOT NULL,
    description TEXT NOT NULL
);

CREATE TABLE person (
    person_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
    age INTEGER NOT NULL CHECK (age > 0),
    gender gender_enum NOT NULL,
    nationality nationality_enum NOT NULL,
    location_id INTEGER NOT NULL REFERENCES location(location_id) ON DELETE SET NULL
);

CREATE TABLE material_box (
    material_id SERIAL PRIMARY KEY,
    description TEXT NOT NULL
);

CREATE TABLE box (
    box_id SERIAL PRIMARY KEY,
    capacity INTEGER NOT NULL CHECK (capacity > 0),
    content TEXT NOT NULL,
    location_id SERIAL NOT NULL REFERENCES location(location_id),
    material_id SERIAL NOT NULL REFERENCES material_box(material_id)
);

CREATE TABLE state_of_map (
    state_id SERIAL PRIMARY KEY,
    damage_type damage_enum NOT NULL,
    severity_state severity_damage_enum NOT NULL,
    cause TEXT NOT NULL
);

CREATE TABLE map (
    map_id SERIAL PRIMARY KEY,
    description TEXT NOT NULL,
    box_id SERIAL NOT NULL REFERENCES box(box_id),
    state_id SERIAL NOT NULL REFERENCES state_of_map(state_id)
);


CREATE TABLE map_in_box (
    map_in_box_id SERIAL PRIMARY KEY,
    map_id SERIAL NOT NULL REFERENCES map(map_id),
    box_id SERIAL NOT NULL REFERENCES box(box_id)
);



CREATE TABLE boat (
    boat_id SERIAL PRIMARY KEY,
    material TEXT NOT NULL,
    volume REAL NOT NULL CHECK(volume > 0)
);




CREATE TABLE search (
    search_id SERIAL PRIMARY KEY,
    description TEXT NOT NULL,
    type_of_search type_of_search_enum NOT NULL,
    map_id SERIAL REFERENCES map(map_id),
    boat_id SERIAL REFERENCES boat(boat_id),
    box_id SERIAL REFERENCES box(box_id),
    person_id SERIAL NOT NULL REFERENCES person(person_id)
);



CREATE TABLE spider (
    spider_id SERIAL PRIMARY KEY,
    size REAL NOT NULL CHECK(size > 0 AND size < 5),
    type TEXT NOT NULL,
    danger_category danger_category_enum NOT NULL,
    location_id SERIAL NOT NULL REFERENCES location(location_id)
);


-- INSERT INTO tables

INSERT INTO location (coordinates, description) VALUES (POINT(0.0, 0.0), 'Центр огромной тёмной комнаты');

INSERT INTO location (coordinates, description) VALUES (POINT(3.0, 5.0), 'Висит на стене огромной тёмной комнаты');

INSERT INTO location (coordinates, description) VALUES (POINT(3.2, 5.5), 'Рядом с ящиком на стене висит павутина');

INSERT INTO person (name, surname, age, gender, nationality, location_id) VALUES ('Petr', 'Mikhailov', 10, 'male', 'Russian', 1);

INSERT INTO material_box (description) VALUES ('Алюминиевый сплав');

INSERT INTO box (capacity, content, location_id, material_id) VALUES ('1200', 'Карты, книги, монеты', 2, 1);


INSERT INTO state_of_map (damage_type, severity_state, cause) VALUES ('moldy', 'severe', 'Долго лежала в сыром месте');


INSERT INTO map (description, box_id, state_id) VALUES ('Карта сокровищ', 1, 1);

INSERT INTO map_in_box (map_id, box_id) VALUES (1, 1);

INSERT INTO boat (material, volume) VALUES ('Wood', 2500);

INSERT INTO search (description, type_of_search, boat_id, person_id) VALUES ('Ищу лодку, затем нашёл коробку, а в ней карту', 'boat', 1, 1);




-- CREATE OR REPLACE  FUNCTION calculate_person_box_distance(personID INT, boxID int)
-- RETURNS  float AS $$
--     DECLARE
--         dist FLOAT := 0;
--         person_location_id INT;
--         box_location_id INT;
--         person_coords POINT;
--         box_coords POINT;
--     BEGIN
--         -- Получаем person_location_id
--         SELECT location_id INTO person_location_id FROM person WHERE person.person_id = personID;
--         IF person_location_id IS NULL THEN
--             RAISE EXCEPTION 'Person with id: % not found', personID;
--         END IF;
-- 
--         -- Получаем box_location_id
--         SELECT location_id INTO box_location_id FROM box WHERE box.box_id = boxID;
--         IF person_location_id IS NULL THEN
--             RAISE EXCEPTION 'Box with id: % not found', boxID;
--         END IF;
-- 
--         -- Получаем person_coords
--         SELECT coordinates INTO person_coords FROM location WHERE location_id = person_location_id;
--         IF person_location_id IS NULL THEN
--             RAISE EXCEPTION 'Person location with location_id: % has no coordinates', person_location_id;
--         END IF;
-- 
--         -- Получаем box_coords
--         SELECT coordinates INTO box_coords FROM location WHERE location_id = box_location_id;
--         IF person_location_id IS NULL THEN
--             RAISE EXCEPTION 'Box location with location_id: % has no coordinates', box_location_id;
--         END IF;
-- 
-- 
--         -- Вычисляем Евклидово расстояние
-- 
--         dist := sqrt((person_coords[0] - box_coords[0])^2 + (person_coords[1] - box_coords[1])^2);
--         RETURN dist;
--     END;
--     $$ LANGUAGE  plpgsql;



-- Триггер для вычисления среднего возраста всех людей
CREATE OR REPLACE FUNCTION calculate_global_avg_age_trigger_func()
RETURNS TRIGGER AS $$
DECLARE
    global_avg_age FLOAT;
BEGIN
    -- Вычисляем средний возраст всех людей
    SELECT AVG(age) INTO global_avg_age
    FROM person;

    -- Выводим результат в консоль
    RAISE NOTICE 'Новый человек добавлен. Средний возраст всех людей: % лет',
                 COALESCE(global_avg_age::NUMERIC(10,2)::TEXT, 'нет данных');

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Создаем триггер
CREATE TRIGGER person_global_avg_age_trigger
AFTER INSERT ON person
FOR EACH ROW
EXECUTE FUNCTION calculate_global_avg_age_trigger_func();

INSERT INTO person (name, surname, age, gender, nationality, location_id) VALUES ('Nikita', 'Ryz', 19, 'male', 'Russian',1);
