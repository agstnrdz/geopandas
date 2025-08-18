# Cargar librería
import pandas as py

# Leer el archivo previamente cargado en carpeta
df = pd.read_excel("nombre_archivo.xlsx")

# Dividir y crear columnas
df[['Lat', 'Lng']] = df['Coordenadas'].str.strip().str.split(',', expand = True)

# Guardar
df.to_excel("nombre_archivo.xlsx", index = False)
