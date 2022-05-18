DROP TABLE IF EXISTS patients CASCADE;
DROP TABLE IF EXISTS medical_histories CASCADE;
DROP TABLE IF EXISTS treatments CASCADE;
DROP TABLE IF EXISTS treatment_histories;
DROP TABLE IF EXISTS invoices CASCADE;
DROP TABLE IF EXISTS invoice_items;

CREATE TABLE patients (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(50),
  date_of_birth DATE,
  PRIMARY KEY (id)
);

CREATE TABLE medical_histories (
  id INT GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP NOT NULL,
  patient_id INT,
  status VARCHAR(50),
  CONSTRAINT fk_patient_id
      FOREIGN KEY(patient_id)
        REFERENCES patients(id)
          ON DELETE CASCADE,
  PRIMARY KEY (id)
);

CREATE TABLE invoices (
  id INT GENERATED ALWAYS AS IDENTITY,
  total_amount DECIMAL NOT NULL,
  generated_at TIMESTAMP NOT NULL,
  payed_at TIMESTAMP NOT NULL,
  medical_history_id INT,
  CONSTRAINT fk_medical_history_id
    FOREIGN KEY (medical_history_id)
      REFERENCES medical_histories(id)
        ON DELETE CASCADE,
  PRIMARY KEY (id)
);

CREATE TABLE treatments (
  id INT GENERATED ALWAYS AS IDENTITY,
  type VARCHAR(50) NOT NULL,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);
