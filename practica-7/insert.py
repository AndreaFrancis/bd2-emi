import psycopg2
import sys

# Conexion para sistemas
debian_9_conn = psycopg2.connect("dbname='emi' user='postgres' host='192.168.1.14' password='bdpostgres'")
# Conexion para agro
debian_8_conn = psycopg2.connect("dbname='emi' user='postgres' host='192.168.1.18' password='bdpostgres'")
    
cur_8 = debian_8_conn.cursor()
cur_9 = debian_9_conn.cursor()

nombre = sys.argv[1]
carrera = sys.argv[2]
semestre = sys.argv[3]
sangre = sys.argv[4]
deporte = sys.argv[5]

if(carrera == 'Sistemas'):
    cur_8.execute('INSERT INTO estudiantes (nombre, carrera, semestre, sangre, deporte) VALUES (%s, %s, %s, %s, %s)', (nombre, carrera, semestre, sangre, deporte))
    debian_8_conn.commit()
    cur_8.close()
elif (carrera == 'Agro'):
    cur_9.execute('INSERT INTO estudiantes (nombre, carrera, semestre, sangre, deporte) VALUES (%s, %s, %s, %s, %s)', (nombre, carrera, semestre, sangre, deporte))
    debian_9_conn.commit()
    cur_9.close()
else:
    print("Fragmento no disponible")

debian_9_conn.close()
debian_8_conn.close()