
#GROUP NAMES
#student 1:Joshua Ayelazuno
#student 2:
#student 3:
import sqlite3
def database():
    con = sqlite3.connect('weather.db')
    cur = con.cursor()

    print("(a)")
    cur.execute('SELECT * FROM WeatherData WHERE City="London"')
    for record in cur.fetchall():
        print(record)
    ''' rest of the queries follow '''

   
    # (b) All summer records
    print("(b)")
    cur.execute('SELECT * FROM WeatherData WHERE Season=3')
    for record in cur.fetchall():
        print(record)

    # (c) City, country, and season for which the temperature is less than 20 degrees
    print("(c)")
    cur.execute('SELECT City, Country, Season FROM WeatherData WHERE Temperature < 20')
    for record in cur.fetchall():
        print(record)

    # (d) City, country, and season for which temperature > 20 degrees and rainfall < 10mm
    print("(d)")
    cur.execute('SELECT City, Country, Season FROM WeatherData WHERE Temperature > 20 AND Rainfall < 10')
    for record in cur.fetchall():
        print(record)

    # (e) City, maximum rainfall, and season for Sydney
    print("(e)")
    cur.execute('SELECT City, MAX(Rainfall), Season FROM WeatherData WHERE City="Sydney"')
    for record in cur.fetchall():
        print(record)

    # (f) City, season, and rainfall amounts for all records in descending order by rainfall
    print("(f)")
    cur.execute('SELECT City, Season, Rainfall FROM WeatherData ORDER BY Rainfall DESC')
    for record in cur.fetchall():
        print(record)

    # (g) The total yearly rainfall for Cairo, Egypt
    print("(g)")
    cur.execute('SELECT SUM(Rainfall) FROM WeatherData WHERE City="Cairo" AND Country="Egypt"')
    for record in cur.fetchall():
        print(record)

    # (h) City name, country, and total yearly rainfall for every distinct city
    print("(h)")
    cur.execute('SELECT City, Country, SUM(Rainfall) FROM WeatherData GROUP BY City')
    for record in cur.fetchall():
        print(record)

    cur.close()

# Execute the function to fetch the outputs
#database()

