# PART I: 7 LIDAR DATA SOURCES

# 0. PACKAGES
#------------

install.packages("pacman")
pacman::p_load(
    terra, tidyverse, sf,
    terrainr, osmdata, marmap,
    rayshader
)

dem_final <- terra::rast(
    "MDE_CR_ejido2.tif"
)

# imprimir el DEM en la consola
print(dem_final)

# PART II: RENDERING 3D MAP
# 3D MAP

# raster to matrix
mat <- rayshader::raster_to_matrix(
    dem_final
)

# texture // define the color palette from values of the pie
cols <- marmap::etopo.colors(n = 16)
pie(rep(1, length(cols)), col = cols)
pal <- cols[c(1, 4:5, 10:12)]
pie(rep(1, length(pal)), col = pal)

# OpenStreetMap features

if (terra::crs(dem_final) != "EPSG:4326") {
    dem_new <- terra::project(
        dem_final, "EPSG:4326"
    )
}

# Get the extent
dem_ext <- terra::ext(dem_new)

print(dem_ext)

# Create a bounding box
dem_bbox <- c(
    dem_ext$xmin, dem_ext$ymin,
    dem_ext$xmax, dem_ext$ymax
)

# OSM roads

osm_data_roads <- osmdata::opq(dem_bbox) |>
    osmdata::add_osm_feature("highway") |>
    osmdata::osmdata_sf()

print(osm_data_roads)

roads <- osm_data_roads$osm_lines |>
    sf::st_transform(
        terra::crs(dem_final)
    )

print(roads)

# OSM rivers

osm_data_rivers <- osmdata::opq(dem_bbox) |>
    osmdata::add_osm_feature("waterway") |>
    osmdata::osmdata_sf()

rivers <- osm_data_rivers$osm_lines |>
    sf::st_transform(
        terra::crs(dem_final)
    )

# OSM buildings
osm_data_buildings <- osmdata::opq(dem_bbox) |>
    osmdata::add_osm_feature("building") |>
    osmdata::osmdata_sf()

buildings <- osm_data_buildings$osm_polygons |>
    sf::st_transform(
        terra::crs(dem_final)
    )

# OSM places
osm_data_places <- osmdata::opq(dem_bbox) |>
    osmdata::add_osm_feature("place") |>
    osmdata::osmdata_sf()

places <- osm_data_places$osm_points |>
    sf::st_transform(
        terra::crs(dem_final)
    )

print(places)

# render scene <>

# basic <>

# Paleta realista sin nieve ni colores de mar
texture <- c(
  "#e8e8d0",  # valle seco o zonas bajas
  "#c2c59d",  # transición
  "#a5b386",  # laderas con vegetación
  "#7d9d58",  # cerros bajos
  "#a58b6f",  # zonas más áridas
  "#776b5d"   # zonas rocosas, para contraste
)

mat |>
    rayshader::height_shade(
        texture = texture
    ) |>
    # add shadow to emphasize the slopes and depressions
    rayshader::add_shadow(
        rayshader::lamb_shade(
            mat,
            zscale = 6
        ), .2
    ) |>
    # add shading by adjusting details, contrast & brightness
    rayshader::add_shadow(
        rayshader::texture_shade(
            mat,
            detail = .9,
            contrast = 9, brightness = 12
        ), .15
    ) |>

    # simulate soft shadows in areas with diffuse lighting
    rayshader::add_shadow(
        rayshader::ambient_shade(mat), .1
    ) |> rayshader::plot_map()