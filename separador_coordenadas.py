import pandas as pd

df = pd.read_excel("nombre_archivo.xlsx")

df[['Lat', 'Lng']] = df['Coordenadas'].str.strip().str.split(',', expand = True)

df.to_excel("nombre_archivo.xlsx", index = False)
