create database if not exists medical;
use medical;
drop table if exists patient;
drop table if exists nok;

drop table if exists dept;
drop table if exists doctor;
drop table if exists nurse;
drop table if exists therapist;
drop table if exists admin;

drop table if exists calender;
drop table if exists therapy;
drop table if exists hospitalization;
drop table if exists reservation;
drop table if exists record;
drop table if exists diagnosis;

drop table if exists questionnaire;
drop table if exists inbody;
drop table if exists xray;

drop table if exists authority;
drop table if exists patient_authority;
drop table if exists nok_authority;
drop table if exists doctor_authority;
drop table if exists nurse_authorization;
drop table if exists therapist_authority;
drop table if exists manager_authority;

drop table if exists equipment;
drop table if exists equipment_rental;
drop table if exists rehabilitation_equipment;
drop table if exists use_rehabilitation_equipment;



create table patient (
    patient_id varchar(50),
    patient_name varchar(10) not null,
    patient_birthday varchar(8) not null,
    patient_tel varchar(20) not null,
    patient_gender varchar(10) not null,
    patient_home varchar(100),
    patient_accept_id varchar(50),
    patient_hos Boolean not null,
    patient_pw varchar(100),
    primary key (patient_id)
);

create table nok (
    protector_id      varchar(50), 
    patient_id      varchar(50), 
    protector_nm      varchar(10) not null, 
    protector_tel      varchar(20) not null, 
    protector_gender   varchar(10) not null, 
    protector_birth_day   varchar(8) not null, 
    protector_pw      varchar(30) not null, 
    primary key (protector_id, patient_id),
    foreign key (patient_id) references patient(patient_id) on delete cascade
);


create table dept (
    dept_id		varchar(50), 
    dept_nm		varchar(10) not null,
    dept_res_id		varchar(50),
    staff_num		BIGINT,
    dept_tel		varchar(20),
    dept_mail		varchar(50),
    primary key (dept_id)
);


create table doctor (
    doctor_id		varchar(50),
    doctor_nm		varchar(10) NOT NULL,
    doctor_tel		varchar(20) NOT NULL,
    doctor_gender		varchar(10) NOT NULL,
    doctor_med_field	varchar(40) NOT NULL,
    dept_id		varchar(50),
    doctor_salary		int	    NOT NULL,
    doctor_pw		varchar(30) NOT NULL,
    primary key (doctor_id),
    foreign key (dept_id) references dept(dept_id) on delete set null
);


create table nurse (
    nurse_id		varchar(50), 
    nurse_salery		INT not null, 
    nurse_name		varchar(10) not null,
    nurse_tel		varchar(20) not null,
    nurse_gender		varchar(10) not null,
    nurse_med_field	varchar(40) not null,
    nurse_m_work		varchar(40) not null,
    dept_id		varchar(50),
    nurse_pw		varchar(30) not null,
    primary key (nurse_id),
    foreign key (dept_id) references dept(dept_id) on delete set null
		
);

create table therapist (
    therapist_id	varchar(50), 
    therapist_salery	INT not null, 
    therapist_nm	varchar(10) not null,
    therapist_tel	varchar(20) not null,
    therapist_gender	varchar(10) not null,
    therapist_m_work	varchar(40) not null,
    dept_id		varchar(50),
    therapist_pw	varchar(30) not null,
    primary key (therapist_id),
    foreign key (dept_id) references dept(dept_id) on delete set null
		
);


create table admin (
    admin_id		varchar(50),
    admin_name		varchar(10) not null,
    admin_pw		varchar(100) not null,
    admin_tel		varchar(20) not null,
    primary key (admin_id)
);

create table diagnosis (
    diag_id varchar(50),
    doctor_id varchar(50),
    diseases varchar(100),
    main_pain varchar(255),
    d_of_diseases varchar(100),
    therapy_select Boolean,
    field varchar(100),
    diseases_time varchar(17),
    patient_id varchar(50),
    primary key (diag_id),
    foreign key (patient_id) references patient(patient_id) 
        on delete cascade
);

create table record (
    patient_id varchar(50),
    record_id varchar(50),
    medical_date Datetime not null,
    therapist_id varchar(50) not null,
    diag_id varchar(50) not null,
    doctor_id varchar(50) not null,
    primary key (record_id, patient_id),
    foreign key (patient_id) references patient(patient_id) 
        on delete cascade,
	foreign key (therapist_id) references therapist(therapist_id) 
        on delete cascade,
	foreign key (diag_id) references diagnosis(diag_id) 
        on delete cascade,
	foreign key (doctor_id) references doctor(doctor_id) 
        on delete cascade
);


create table authority (
    authority_id varchar(50),
    author_name varchar(70) not null,
    register_date Datetime not null,
    revise_date Datetime,
    remove_y Boolean not null,
    primary key (authority_id)
);


create table patient_authority (
    patient_id varchar(50),
    authority_id varchar(50),
    primary key (patient_id, authority_id),
    foreign key (patient_id) references patient(patient_id) on delete cascade,
    foreign key (authority_id) references authority(authority_id) on delete cascade
);


create table doctor_authority (
    doctor_id varchar(50),
    authority_id varchar(50),
    primary key (doctor_id, authority_id),
    foreign key (doctor_id) references doctor(doctor_id) on delete cascade,
    foreign key (authority_id) references authority(authority_id) on delete cascade
);

create table calender (
    patient_id varchar(50),
    treatment_plan varchar(255),
    plan_date datetime not null,
    plan_diet varchar(255),
    plan_more_detail varchar(255),
    primary key (patient_id),
    foreign key (patient_id) references patient(patient_id) on delete cascade
        
);


create table therapy (
    treatment_id varchar(50),
    patient_id varchar(50),
    reh_goal varchar(255) not null,
    reh_therapy_kind varchar(50) not null,
    reh_therapy_date varchar(17) not null,
    use_drug varchar(255) not null,
    therapy_plan varchar(255) not null,
    therapy_point varchar(255) not null,
    therapist_id varchar(50),
    primary key (treatment_id, patient_id),
    foreign key (patient_id) references patient(patient_id) on delete cascade,
    foreign key (therapist_id) references therapist(therapist_id) on delete set null
        
);


create table hospitalization (
    patient_id varchar(50),
    patient_date varchar(17) not null,
    hospital_room_id varchar(50) not null,
    hospital_room_info varchar(100),
    hospital_bed_id varchar(50) not null,
    primary key (patient_id),
    foreign key (patient_id) references patient(patient_id) on delete cascade
        
);


create table reservation (
    res_id varchar(50),
    res_type varchar(100) not null,
    res_time datetime not null,
    pick_up boolean not null,
    pick_place varchar(255),
    patient_id varchar(50),
    primary key (res_id),
    foreign key (patient_id) references patient(patient_id) on delete set null
        
);


create table questionnaire (
    patient_id varchar(50),
    allergy varchar(30),
    disease varchar(30),
    symptom varchar(20),
    symptom_period varchar(17),
    reh_status boolean,
    disable_status varchar(50) not null,
    smoke_period varchar(30),
    drink int,
    exercise int,
    primary key (patient_id),
    foreign key (patient_id) references patient(patient_id) on delete cascade
        
);


create table inbody (
    patient_id             varchar(50),
    inbody_id              varchar(50) not null,
    measure_date           datetime not null,
    patient_weight         varchar(30) not null,
    body_fat_percentage    varchar(30) not null,
    muscle_mass            varchar(30) not null,
    basal_metabolism       varchar(30) not null,
    fatness_index          varchar(30) not null,
    aqua                   varchar(30) not null,
    obesity_scale          varchar(30) not null,
    unit_analysis          varchar(30) not null,
    nurse_id               varchar(30),
    primary key (patient_id),
    foreign key (patient_id) references patient(patient_id) on delete cascade,
    foreign key (nurse_id) references nurse(nurse_id) on delete set null
        
);


create table xray (
    patient_id             varchar(50),
    staff_id               varchar(255) not null,
    shooting_date          datetime not null,
    shooting_equipment     varchar(255),
    shooting_part          varchar(255),
    xray_type              varchar(255),
    doctor_opinion         text,
    image_url              varchar(255),
    nurse_id               varchar(50),
    primary key (patient_id),
    foreign key (patient_id) references patient(patient_id) on delete cascade,
    foreign key (nurse_id) references nurse(nurse_id) on delete set null
        
);

create table equipment (
    equipment_id          varchar(50),
    equipment_kind        varchar(50) not null,
    equipment_location    varchar(50) not null,
    use_equipment         boolean     not null,
    primary key (equipment_id)
);


create table equipment_rental (
    equipment_id          varchar(50),
    rental_period         varchar(17) not null,
    patient_id            varchar(50),
    primary key (equipment_id),
    foreign key (equipment_id) references equipment(equipment_id) on delete cascade,
    foreign key (patient_id) references patient(patient_id) on delete set null
        
);


create table rehabilitation_equipment (
    reh_id       varchar(50),
    reh_equipment_type     varchar(50) not null,
    reh_equipment_location varchar(50) not null,
    primary key (reh_id)
);


create table use_rehabilitation_equipment (
    reh_id                             varchar(50),
    use_reh_equipment                  boolean not null,
    patient_id                         varchar(50),
    primary key (reh_id),
    foreign key (reh_id) references rehabilitation_equipment(reh_id) on delete cascade,
    foreign key (patient_id) references patient(patient_id) on delete set null
        
);
		
      
create table nurse_authorization (
    authority_id                varchar(50),
    nurse_id		            varchar(50),
    primary key (nurse_id, authority_id),
    foreign key (authority_id) references authority(authority_id) on delete cascade,
    foreign key (nurse_id) references nurse(nurse_id) on delete cascade
);



create table therapist_authority (
    authority_id		    varchar(50),
    therapist_id		    varchar(50),
    primary key (therapist_id, authority_id),
    foreign key (authority_id) references authority(authority_id) on delete cascade,
    foreign key (therapist_id) references therapist(therapist_id) on delete cascade
);


create table manager_authority (
    authority_id		    varchar(50),
    admin_id		        varchar(50),
    primary key (admin_id, authority_id),
    foreign key (authority_id) references authority(authority_id) on delete cascade,
    foreign key (admin_id) references admin(admin_id) on delete cascade
);



create table nok_authority (
    protector_id		    varchar(50),
    patient_id		        varchar(50),
    authority_id		    varchar(50),
    primary key (protector_id, authority_id, patient_id),
    foreign key (protector_id) references nok(protector_id) on delete cascade,
    foreign key (patient_id) references patient(patient_id) on delete cascade,
    foreign key (authority_id) references authority(authority_id) on delete cascade
);
