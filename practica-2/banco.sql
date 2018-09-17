-- Paso 1 - Creando tabla cuentas
--DROP TABLE cuenta;

CREATE TABLE cuenta (
	id SERIAL PRIMARY KEY,
	nombre_cliente VARCHAR(100),
	monto REAL,
	fecha_creacion TIMESTAMP, 
	fecha_modificacion TIMESTAMP
);

-- Paso 2 - Insertar valores de ejemplo
INSERT INTO cuenta (nombre_cliente, monto, fecha_creacion, fecha_modificacion)
VALUES ('Alberto Marques', 0, CURRENT_TIMESTAMP, NULL);

INSERT INTO cuenta (nombre_cliente, monto, fecha_creacion, fecha_modificacion)
VALUES ('EMI CBBA', 0, CURRENT_TIMESTAMP, NULL);

SELECT * FROM cuenta;

-- Paso 3 - Crear tabla de transacciones bancarias
DROP TABLE transaccion;
CREATE TABLE transaccion (
	id SERIAL PRIMARY KEY,
	cuenta_origen INTEGER REFERENCES cuenta,
	cuenta_destino INTEGER REFERENCES cuenta,
	monto REAL,
	fecha TIMESTAMP,
	ci VARCHAR(20),
	nombre VARCHAR(100),
	detalle VARCHAR(200)
);

-- Paso 4 - Insertar valores de ejemplo en transacciones conciderando su impacto en las cuentas
-- Andrea le deposita Bs. 3000 a la cuenta de Alberto
INSERT INTO transaccion (cuenta_destino, monto, fecha, ci, nombre, detalle) 
VALUES (1, 3000, CURRENT_TIMESTAMP, '44810342', 'Angela Marquez', 'Mesada');

-- Por ende la cuenta de Alberto subira en Bs. 3000
UPDATE cuenta 
SET 	monto = monto + 3000,
	fecha_modificacion = CURRENT_TIMESTAMP
WHERE id = 1;

SELECT * FROM cuenta;

-- Una vez que tiene dinero, el papa de Toño va a pagar Bs. 1600 la mensualidad
INSERT INTO transaccion (cuenta_origen, cuenta_destino, monto, fecha, ci, nombre, detalle) 
VALUES (1, 2, 1600, CURRENT_TIMESTAMP, '11223344', 'Albeto Marquez', 'Pago por 1era mensualidad');

SELECT * FROM transaccion;

SELECT * FROM cuenta;

-- Por ende la cuenta de Alberto disminuye en Bs. 1600
UPDATE cuenta 
SET 	monto = monto - 1600,
	fecha_modificacion = CURRENT_TIMESTAMP
WHERE id = 1;

-- Y la cuenta de la EMI aumenta en Bs. 1600
UPDATE cuenta 
SET 	monto = monto + 1600,
	fecha_modificacion = CURRENT_TIMESTAMP
WHERE id = 2;

SELECT * FROM cuenta;

-- Ver listado de ingreso de cuentas
SELECT a.nombre_cliente, a.monto, b.cuenta_origen, b.monto, b.nombre, b.detalle, b.fecha
FROM cuenta a
INNER JOIN transaccion b
	ON a.id = b.cuenta_destino;

-- Alberto va a pagar Bs. 1600 de la mensualidad para el segundo mes
INSERT INTO transaccion (cuenta_origen, cuenta_destino, monto, fecha, ci, nombre, detalle) 
VALUES (1, 2, 1600, CURRENT_TIMESTAMP, '11223344', 'Albeto Marquez', 'Pago por 2da mensualidad');

SELECT * FROM transaccion;

SELECT * FROM cuenta;

-- Por ende la cuenta de Alberto deberia disminuir en Bs. 1600
UPDATE cuenta 
SET 	monto = monto - 1600,
	fecha_modificacion = CURRENT_TIMESTAMP
WHERE id = 1;

-- Y la cuenta de la EMI aumenta en Bs. 1600
UPDATE cuenta 
SET 	monto = monto + 1600,
	fecha_modificacion = CURRENT_TIMESTAMP
WHERE id = 2;

SELECT * FROM cuenta;

 -- TRUNCATE TABLE transaccion, cuenta;
 -- SELECT * FROM cuenta;

INSERT INTO transaccion (cuenta_destino, monto, fecha, ci, nombre, detalle) 
VALUES (5, 3000, CURRENT_TIMESTAMP, '44810342', 'Angela Marquez', 'Mesada');
UPDATE cuenta 
SET 	monto = monto + 3000,
	fecha_modificacion = CURRENT_TIMESTAMP
WHERE id = 5;

SELECT * FROM cuenta;

-- Supongamos que ahora quiere pagar dos mesualidades en una
UPDATE cuenta 
SET 	monto = monto - 3200,
	fecha_modificacion = CURRENT_TIMESTAMP
WHERE id = 5;

INSERT INTO transaccion (cuenta_origen, cuenta_destino, monto, fecha, ci, nombre, detalle) 
VALUES (5, 6, 1600, CURRENT_TIMESTAMP, '11223344', 'Albeto Marquez', 'Pago por 1era y 2da mensualidad');

-- Y la cuenta de la EMI aumenta en Bs. 1600
UPDATE cuenta 
SET 	monto = monto + 3200,
	fecha_modificacion = CURRENT_TIMESTAMP
WHERE id = 6;

SELECT * FROM transaccion;
SELECT * FROM cuenta;

-- TRUNCATE TABLE transaccion, cuenta;
-- SELECT * FROM cuenta;

INSERT INTO transaccion (cuenta_destino, monto, fecha, ci, nombre, detalle) 
VALUES (7, 3000, CURRENT_TIMESTAMP, '44810342', 'Angela Marquez', 'Mesada');

UPDATE cuenta 
SET 	monto = monto + 3000,
	fecha_modificacion = CURRENT_TIMESTAMP
WHERE id = 7;

SELECT * FROM cuenta;

-- Supongamos que ahora quiere pagar dos mesualidades en una
BEGIN;
UPDATE cuenta 
SET 	monto = monto - 3200,
	fecha_modificacion = CURRENT_TIMESTAMP
WHERE id = 7;

SELECT * FROM cuenta;

INSERT INTO transaccion (cuenta_origen, cuenta_destino, monto, fecha, ci, nombre, detalle) 
VALUES (7, 8, 1600, CURRENT_TIMESTAMP, '11223344', 'Albeto Marquez', 'Pago por 1era y 2da mensualidad');

SELECT * FROM transaccion;

-- Y la cuenta de la EMI aumenta en Bs. 1600
UPDATE cuenta 
SET 	monto = monto + 3200,
	fecha_modificacion = CURRENT_TIMESTAMP
WHERE id = 8;

SELECT * FROM transaccion;
SELECT * FROM cuenta;

-- ROLLBACK;
-- COMMIT;


-- Supongamos que ahora quiere pagar dos mesualidades en una, pero el sistema pide adicionalmente que se le cobre un 
-- pequeño porcentaje cuando va al banco
TRUNCATE TABLE transaccion, cuenta;
SELECT * FROM cuenta;
SELECT * FROM transaccion;
BEGIN;
INSERT INTO transaccion (cuenta_origen, cuenta_destino, monto, fecha, ci, nombre, detalle) 
VALUES (9, 10, 0, CURRENT_TIMESTAMP, '11223344', 'Albeto Marquez', 'Pago por 1era y 2da mensualidad');

SAVEPOINT transaccion_obligatoria;
UPDATE cuenta 
SET 	monto = monto - 3200,
	fecha_modificacion = CURRENT_TIMESTAMP
WHERE id = 9;

SELECT * FROM cuenta;

INSERT INTO transaccion (cuenta_origen, cuenta_destino, monto, fecha, ci, nombre, detalle) 
VALUES (9, 10, 3200, CURRENT_TIMESTAMP, '11223344', 'Albeto Marquez', 'Pago por 1era y 2da mensualidad');

SELECT * FROM transaccion;

-- Y la cuenta de la EMI aumenta en Bs. 1600
UPDATE cuenta 
SET 	monto = monto + 3200,
	fecha_modificacion = CURRENT_TIMESTAMP
WHERE id = 10;

SELECT * FROM transaccion;
SELECT * FROM cuenta;

ROLLBACK to transaccion_obligatoria
COMMIT;

select * from cuenta;

SELECT ejecutar_transaccion(100, 9, 10);
SELECT * FROM transaccion;
