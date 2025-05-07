## Conversión de valores planos a coordenadas decimales

import pandas as pd

# .xlsx
df = pd.read_excel('archivo_latlong.xlsx')

# Función insertar el punto decimal después del tercer carácter
def insertar_punto(valor):
    valor_str = str(int(valor))  # convertimos a entero y luego a string
    return float(valor_str[:3] + '.' + valor_str[3:])

# Aplico la función a las columnas lat y long
df['lat_decimal'] = df['lat'].apply(insertar_punto)
df['long_decimal'] = df['long'].apply(insertar_punto)

# Exporto el GDF modificado en un nuevo archivo
df.to_excel('coordenadas_decimales.xlsx', index=False)

print("Conversión terminada.")