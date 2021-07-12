CREATE TABLE goals (
  id serial PRIMARY KEY,
  goal text NOT NULL UNIQUE
);


CREATE TABLE habit_types (
  id serial PRIMARY KEY,
  habit_type text NOT NULL
);

CREATE TABLE habits (
  id serial PRIMARY KEY,
  habit text NOT NULL,
  goal_id integer REFERENCES goals(id),
  prompt text NOT NULL,
  habit_type_id integer NOT NULL REFERENCES habit_types(id)
);

CREATE TABLE habit_log (
  id serial PRIMARY KEY,
  date date NOT NULL DEFAULT NOW(),
  habit_id integer REFERENCES habits(id),
  habit_type_id integer REFERENCES habit_types(id),
  progress integer DEFAULT 0
);

ALTER TABLE habit_log ADD CHECK ( (habit_type_id = 1 AND progress >= 0) OR (habit_type_id = 2 AND (progress BETWEEN 0 AND 5)) );
ALTER TABLE habit_log ADD UNIQUE(date, habit_id);