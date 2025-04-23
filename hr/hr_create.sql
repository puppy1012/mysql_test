





drop table countries;
drop table regions;
drop table employees;
drop table departments;
drop table locations;




drop table job_history;
drop table jobs;

CREATE TABLE regions
    ( region_id      int(10) primary key
    , region_name    VARCHAR(25) 
    );


CREATE TABLE countries 
    ( country_id      CHAR(2) primary key 
    , country_name    VARCHAR(40) 
    , region_id       int 
    ) ;

ALTER TABLE countries
ADD foreign key(region_id) references regions(region_id);

CREATE TABLE locations
    ( location_id    int(4)  PRIMARY KEY
    , street_address VARCHAR(40)
    , postal_code    VARCHAR(12)
    , city       VARCHAR(30)  NOT NULL
    , state_province VARCHAR(25)
    , country_id     CHAR(2)
    ) ;

ALTER TABLE locations
ADD FOREIGN KEY (country_id)	  REFERENCES countries(country_id) ;



CREATE TABLE departments
    ( department_id    int(4)  PRIMARY KEY
    , department_name  VARCHAR(30)  NOT NULL
    , manager_id       int(6)
    , location_id      int(4)
    ) ;

ALTER TABLE departments
ADD FOREIGN KEY (location_id)	  REFERENCES locations (location_id) ;

CREATE TABLE jobs
    ( job_id         VARCHAR(10)  PRIMARY KEY
    , job_title      VARCHAR(35)  NOT NULL
    , min_salary     int(6)
    , max_salary     int(6)
    ) ;


CREATE TABLE employees
    ( employee_id    int(6) PRIMARY KEY
    , first_name     VARCHAR(20)
    , last_name      VARCHAR(25)  NOT NULL
    , email          VARCHAR(25) NOT NULL
    , phone_number   VARCHAR(20)
    , hire_date      DATE NOT NULL
    , job_id         VARCHAR(10) NOT NULL
    , salary         decimal(8,2)
    , commission_pct decimal(2,2)
    , manager_id     int(6)
    , department_id  int(4)
    ) ;


ALTER TABLE employees ADD FOREIGN KEY (department_id)  REFERENCES departments(department_id);
ALTER TABLE employees ADD FOREIGN KEY (job_id)  REFERENCES jobs (job_id);



CREATE TABLE job_history
    ( employee_id   int(6)  PRIMARY KEY
    , start_date    DATE NOT NULL
    , end_date      DATE  NOT NULL
    , job_id        VARCHAR(10)  NOT NULL
    , department_id int(4));
    
ALTER TABLE job_history ADD FOREIGN KEY (job_id)  REFERENCES jobs(job_id) ;
ALTER TABLE job_history ADD FOREIGN KEY (department_id)   REFERENCES departments(department_id) ;


