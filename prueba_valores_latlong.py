import pandas as pd

# Leer el Excel y cargar lat y long como string
df = pd.read_excel('archivo_latlong.xlsx', dtype={'lat': str, 'long': str})

# Función para insertar el punto decimal después del tercer carácter
def insertar_punto(valor):
    return float(valor[:3] + '.' + valor[3:])

# Aplicamos la función a las columnas lat y long
df['lat_decimal'] = df['lat'].apply(insertar_punto)
df['long_decimal'] = df['long'].apply(insertar_punto)

# Guardamos el DataFrame modificado en un nuevo archivo
df.to_excel('coordenadas_decimales.xlsx', index=False)

print("Conversión terminada.")
