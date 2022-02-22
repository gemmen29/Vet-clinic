CREATE DATABASE medical_clinic;

CREATE TABLE patients
(
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(255),
	date_of_birth date
);

CREATE TABLE treatments
(
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	type VARCHAR(255),
	name VARCHAR(255)
);

CREATE TABLE medical_histories
(
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	admitted_at TIMESTAMP,
	patient_id INT,
	status VARCHAR(255),
	FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE invoices
(
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	total_amount DECIMAL,
	generated_at TIMESTAMP,
	payed_at TIMESTAMP,
	status VARCHAR(255),
	medical_history_id INT,
	FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE invoice_items
(
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	unit_price DECIMAL,
	quantity INT,
	total_price DECIMAL,
	invoice_id INT,
	treatment_id INT,
	FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (treatment_id) REFERENCES treatments(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE medical_history_treatment
(
	medical_history_id INT,
	treatment_id INT,
	PRIMARY KEY (medical_history_id, treatment_id),
	FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (treatment_id) REFERENCES treatments(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE INDEX medical_histories_patient_id_idx ON medical_histories(patient_id);

CREATE INDEX invoices_medical_history_id_idx ON invoices(medical_history_id);

CREATE INDEX invoice_items_invoice_id_idx ON invoice_items(invoice_id);

CREATE INDEX invoice_items_treatment_id_idx ON invoice_items(treatment_id);

CREATE INDEX medical_history_treatment_medical_history_id_idx ON medical_history_treatment(medical_history_id);

CREATE INDEX medical_history_treatment_treatment_id_idx ON medical_history_treatment(treatment_id);
