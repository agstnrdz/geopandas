## Jupyter Notebook en Visual Studio Code
Introducción a GeoPandas usando Jupyter Notebook en Visual Studio Code. La base es sustituir Anaconda para usar Jupyter Notebook aprovechando las funcionalidades, extensiones y conexiones de Visual Studio Code.

### Documentación

Mostrar la url del repositorio en cuestión
```ruby
git remote show origin
```

Cambiar el repositorio en cuestión
```ruby
git remote remove origin
```

```ruby
git remote add origin /url/
```

En caso de que rechace el push
```ruby
git fetch origin
```

```ruby
git reset --hard origin/main
```

```ruby
git push -f origin main
```

Agregar commits a GitHub
```ruby
git add .
```

```ruby
git status
```

```ruby
git commit -m "acción"
```

```ruby
# "n" files changed"
```

```ruby
git push
```

### R-tree Spatial Indexing with Python

Practicamos la indexación espacial de  [Geoff Boeing](https://geoffboeing.com/2016/10/r-tree-spatial-index-python/) usando GeoPandas. En este caso vamos a usar los geodataframes que venimos usando en este archivo.

### Hierarchical Hexagonal Geospatial Indexing System (H3)

Instalamos la librería de H3 en Anaconda Powershell Prompt dentro del environment GIS mediante ```conda config --add channels conda-forge```, ```conda install h3``` y ```conda install h3-py``` ya que usamos el kernel de Anaconda, que es donde tenemos las librerías instaladas.

Esta librería contiene funciones para convertir latitudes y longitudes en strings que representan los centroides de las celdas hexagonales. Los hexágonos tienen ventajas claras sobre las celdas de cuadrados, ya que ofrecen tamaños de celdas más uniformes y menos efectos de bordes, lo que los hace perfectos para los análisis geoespaciales. H3 tiene una resolución jerárquica, posee 16 niveles de resolución, desde una celda muy grande hasta celdas extremadamente pequeñas. Es muy eficiente para realizar operaciones geoespaciales como cálculos de distancia, contención, agregación de datos, etc.

```python
la función h3.geo_to_h3 se suplantó en la nueva versión por h3.latlng_to_cell
```