import psycopg2


debian_9_conn = psycopg2.connect("dbname='emi' user='postgres' host='192.168.1.14' password='bdpostgres'")
#debian_8_conn = psycopg2.connect("dbname='emi' user='postgres' host='192.168.1.18' password='bdpostgres'")

cur = debian_9_conn.cursor()

try:
    cur.execute("SELECT dblink_connect('debian8', 'dbname=emi host=192.168.1.18 user=postgres password=bdpostgres')")
    #cur.execute("SELECT dblink_connect('debian9', 'dbname=emi host=192.168.1.14 user=postgres password=bdpostgres')")
    cur.execute("SELECT * FROM vista_estudiantes;")
    rows = cur.fetchall()
    for row in rows:
        print(row)
    cur.execute("SELECT dblink_disconnect('debian8')")
except:
    print("Error al seleccionar datos")  

cur.close()
debian_9_conn.close()
#debian_8_conn.close()