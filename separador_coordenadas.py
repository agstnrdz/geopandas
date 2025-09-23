import pandas as import pd

df = pd.read_excel("archivo.xlsx")

df[['Lat', 'Lng']] = df['Coordenadas'].str.strip().str.split(',', expand=True)

df.to_excel("archivo.xlsx", index = False)