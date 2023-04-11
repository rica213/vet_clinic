CREATE DATABASE clinic;

USE DATABASE clinic;

CREATE TABLE patients (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE
);

CREATE TABLE medical_histories (
    id INT PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES patients(id)
)

CREATE TABLE invoices (
    id INT PRIMARY KEY,
    total_amount FLOAT(8),
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT,
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

CREATE TABLE treatments (
    id INT PRIMARY KEY,
    type VARCHAR(255),
    name VARCHAR(255)
)


CREATE TABLE invoice_items (
    id INT PRIMARY KEY,
    unit_price FLOAT(8),
    quantity INT,
    total_price FLOAT,
    invoice_id INT,
    treatment_id INT,
    FOREIGN KEY (invoice_id) REFERENCES invoices(id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(id)
)

CREATE TABLE medical_histories_treatments (
    id INT PRIMARY KEY,
    medical_histories_id INT,
    treatments_id INT,
    FOREIGN KEY (medical_histories_id) REFERENCES medical_histories(id),
    FOREIGN KEY (treatments_id) REFERENCES treatments(id),
)

