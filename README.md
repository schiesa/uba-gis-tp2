# Uba-gis-tp2

El objetivo de este trabajo práctico es estimar la cantidad
de hectáreas sembradas con maíz y soja para la campaña 20/21 en los partido de Roque
Saenz Peña (Córdoba), General Roca (Córdoba) y General Villegas (Buenos Aires).

# Completar los datos

- 1. Departamento/ Provincia
Roque Saenz/ Peña Córdoba
General Roca / Córdoba
General Villegas/ Buenos Aires

 Has. Maíz
 Has. Soja

- 2. Mapa de las hectáreas sembradas con maíz y soja para cada uno de los partidos en
estos dos formatos (elegir al menos uno de cada ítem):
a. Capa vectorial o ráster (la suma del área de las geometrías/pixeles debe
corresponderse con los datos de la tabla)
b. JPG o PDF
- 3. Entregar un informe que incluya descripción metodológica y resultados, con una
discusión comparando las estrategias empleadas y qué cosas se podrían agregar en el
futuro.
- 4. Exponer los principales resultados en clase en una presentación (máximo 10 minutos).


calculo de áreas de cultivo de maíz y soja a partir de imágenes de satélites.

#git clone https://github.com/schiesa/uba-gis-tp2.git

Origen de las imagenes:
https://developers.google.com/earth-engine/datasets/catalog/COPERNICUS_S2_SR

Bandas: 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B8', 'B8A', 'B11', 'B12'
NDVI: (NIR-RED)/(NIR+RED) -> (B8-B4)/(B8+B4) -> (imb7-imb3)/(imb7+imb3)



# 1- Descargo imagenes satelitales

Bucket (~17 GB): gs://gis2021-teledeteccion/tp-teledeteccion-2/images/
En caso de usar google cloud copio directamente de este bucket publico.
gsutil -m cp -r gs://gis2021-teledeteccion/tp-teledeteccion-2/images/* ~/tp-2/images/aoi/

En mi caso que trabajo en forma local. Descargo imagenes

chmod a+x download-images.sh
- ./download-images.sh

Carpetas creadas:

├── 2020-10-01
│   ├── 0000000000-0000000000_evi.tif
│   ├── 0000000000-0000000000_ndvi.tif
│   ├── 0000000000-0000000000.tif
│   ├── 0000000000-0000010496_evi.tif
│   ├── 0000000000-0000010496_ndvi.tif
│   └── 0000000000-0000010496.tif
├── 2020-11-01
│   ├── 0000000000-0000000000_evi.tif
│   ├── 0000000000-0000000000_ndvi.tif
│   ├── 0000000000-0000000000.tif
│   ├── 0000000000-0000010496_evi.tif
│   ├── 0000000000-0000010496_ndvi.tif
│   └── 0000000000-0000010496.tif
├── 2020-12-01
│   ├── 0000000000-0000000000_evi.tif
│   ├── 0000000000-0000000000_ndvi.tif
│   ├── 0000000000-0000000000.tif
│   ├── 0000000000-0000010496_evi.tif
│   ├── 0000000000-0000010496_ndvi.tif
│   └── 0000000000-0000010496.tif
├── 2021-01-01
│   ├── 0000000000-0000000000_evi.tif
│   ├── 0000000000-0000000000_ndvi.tif
│   ├── 0000000000-0000000000.tif
│   ├── 0000000000-0000010496_evi.tif
│   ├── 0000000000-0000010496_ndvi.tif
│   └── 0000000000-0000010496.tif
├── 2021-02-20
│   ├── 0000000000-0000000000_evi.tif
│   ├── 0000000000-0000000000_ndvi.tif
│   ├── 0000000000-0000000000.tif
│   ├── 0000000000-0000010496_evi.tif
│   ├── 0000000000-0000010496_ndvi.tif
│   └── 0000000000-0000010496.tif
├── 2021-03-17
│   ├── 0000000000-0000000000_evi.tif
│   ├── 0000000000-0000000000_ndvi.tif
│   ├── 0000000000-0000000000.tif
│   ├── 0000000000-0000010496_evi.tif
│   ├── 0000000000-0000010496_ndvi.tif
│   └── 0000000000-0000010496.tif



# 2- Verifico sistema de coordenadas y layers de las imagenes descargadas.

- gdalinfo 0000000000-0000000000.tif


Driver: GTiff/GeoTIFF
Files: 0000000000-0000000000.tif
       0000000000-0000000000.tif.aux.xml
Size is 10496, 8653
Coordinate System is:
GEOGCRS["WGS 84",
    DATUM["World Geodetic System 1984",
        ELLIPSOID["WGS 84",6378137,298.257223563,
            LENGTHUNIT["metre",1]]],
    PRIMEM["Greenwich",0,
        ANGLEUNIT["degree",0.0174532925199433]],
    CS[ellipsoidal,2],
        AXIS["geodetic latitude (Lat)",north,
            ORDER[1],
            ANGLEUNIT["degree",0.0174532925199433]],
        AXIS["geodetic longitude (Lon)",east,
            ORDER[2],
            ANGLEUNIT["degree",0.0174532925199433]],
    ID["EPSG",4326]]
Data axis to CRS axis mapping: 2,1
Origin = (-65.117617304426346,-33.815102577054326)
Pixel Size = (0.000179663056824,-0.000179663056824)
Metadata:
  AREA_OR_POINT=Area
Image Structure Metadata:
  COMPRESSION=LZW
  INTERLEAVE=PIXEL
Corner Coordinates:
Upper Left  ( -65.1176173, -33.8151026) ( 65d 7' 3.42"W, 33d48'54.37"S)
Lower Left  ( -65.1176173, -35.3697270) ( 65d 7' 3.42"W, 35d22'11.02"S)
Upper Right ( -63.2318739, -33.8151026) ( 63d13'54.75"W, 33d48'54.37"S)
Lower Right ( -63.2318739, -35.3697270) ( 63d13'54.75"W, 35d22'11.02"S)
Center      ( -64.1747456, -34.5924148) ( 64d10'29.08"W, 34d35'32.69"S)
Band 1 Block=256x256 Type=Float32, ColorInterp=Gray
  Description = B2_median
  Min=0.005 Max=0.613
  Minimum=0.005, Maximum=0.613, Mean=0.083, StdDev=0.029
  Metadata:
    STATISTICS_APPROXIMATE=YES
    STATISTICS_MAXIMUM=0.61280000209808
    STATISTICS_MEAN=0.082584681193607
    STATISTICS_MINIMUM=0.0050499998033047
    STATISTICS_STDDEV=0.02902185932755
    STATISTICS_VALID_PERCENT=67.26
Band 2 Block=256x256 Type=Float32, ColorInterp=Undefined
  Description = B3_median
  Min=0.011 Max=0.639
  Minimum=0.011, Maximum=0.639, Mean=0.110, StdDev=0.032
  Metadata:
    STATISTICS_APPROXIMATE=YES
    STATISTICS_MAXIMUM=0.63919997215271
    STATISTICS_MEAN=0.10977454589249
    STATISTICS_MINIMUM=0.010649999603629
    STATISTICS_STDDEV=0.031670102148053
    STATISTICS_VALID_PERCENT=67.26
Band 3 Block=256x256 Type=Float32, ColorInterp=Undefined
  Description = B4_median
  Min=0.013 Max=0.674
  Minimum=0.013, Maximum=0.674, Mean=0.142, StdDev=0.045
  Metadata:
    STATISTICS_APPROXIMATE=YES
    STATISTICS_MAXIMUM=0.67379999160767
    STATISTICS_MEAN=0.14164904323743
    STATISTICS_MINIMUM=0.012600000016391
    STATISTICS_STDDEV=0.045282018041969
    STATISTICS_VALID_PERCENT=67.26
Band 4 Block=256x256 Type=Float32, ColorInterp=Undefined
  Description = B5_median
  Min=0.027 Max=0.693
  Minimum=0.027, Maximum=0.693, Mean=0.171, StdDev=0.042
  Metadata:
    STATISTICS_APPROXIMATE=YES
    STATISTICS_MAXIMUM=0.69279998540878
    STATISTICS_MEAN=0.17147803518039
    STATISTICS_MINIMUM=0.027149999514222
    STATISTICS_STDDEV=0.041671250440043
    STATISTICS_VALID_PERCENT=67.26
Band 5 Block=256x256 Type=Float32, ColorInterp=Undefined
  Description = B6_median
  Min=0.010 Max=0.678
  Minimum=0.010, Maximum=0.678, Mean=0.210, StdDev=0.036
  Metadata:
    STATISTICS_APPROXIMATE=YES
    STATISTICS_MAXIMUM=0.67825001478195
    STATISTICS_MEAN=0.21024092860017
    STATISTICS_MINIMUM=0.010449999943376
    STATISTICS_STDDEV=0.036069842361315
    STATISTICS_VALID_PERCENT=67.26
Band 6 Block=256x256 Type=Float32, ColorInterp=Undefined
  Description = B7_median
  Min=0.012 Max=0.681
  Minimum=0.012, Maximum=0.681, Mean=0.232, StdDev=0.040
  Metadata:
    STATISTICS_APPROXIMATE=YES
    STATISTICS_MAXIMUM=0.68075001239777
    STATISTICS_MEAN=0.23200811733391
    STATISTICS_MINIMUM=0.012149999849498
    STATISTICS_STDDEV=0.040240829348563
    STATISTICS_VALID_PERCENT=67.26
Band 7 Block=256x256 Type=Float32, ColorInterp=Undefined
  Description = B8_median
  Min=0.022 Max=0.696
  Minimum=0.022, Maximum=0.696, Mean=0.251, StdDev=0.043
  Metadata:
    STATISTICS_APPROXIMATE=YES
    STATISTICS_MAXIMUM=0.69620001316071
    STATISTICS_MEAN=0.25051026771933
    STATISTICS_MINIMUM=0.022099999710917
    STATISTICS_STDDEV=0.042647486953573
    STATISTICS_VALID_PERCENT=67.26
Band 8 Block=256x256 Type=Float32, ColorInterp=Undefined
  Description = B8A_median
  Min=0.011 Max=0.687
  Minimum=0.011, Maximum=0.687, Mean=0.257, StdDev=0.042
  Metadata:
    STATISTICS_APPROXIMATE=YES
    STATISTICS_MAXIMUM=0.68720000982285
    STATISTICS_MEAN=0.25720096325698
    STATISTICS_MINIMUM=0.011250000447035
    STATISTICS_STDDEV=0.042435061946721
    STATISTICS_VALID_PERCENT=67.26
Band 9 Block=256x256 Type=Float32, ColorInterp=Undefined
  Description = B11_median
  Min=0.008 Max=0.707
  Minimum=0.008, Maximum=0.707, Mean=0.326, StdDev=0.068
  Metadata:
    STATISTICS_APPROXIMATE=YES
    STATISTICS_MAXIMUM=0.70709997415543
    STATISTICS_MEAN=0.32564687144303
    STATISTICS_MINIMUM=0.0082999998703599
    STATISTICS_STDDEV=0.068452604454744
    STATISTICS_VALID_PERCENT=67.26
Band 10 Block=256x256 Type=Float32, ColorInterp=Undefined
  Description = B12_median
  Min=0.006 Max=0.666
  Minimum=0.006, Maximum=0.666, Mean=0.261, StdDev=0.068
  Metadata:
    STATISTICS_APPROXIMATE=YES
    STATISTICS_MAXIMUM=0.66584998369217
    STATISTICS_MEAN=0.26133495152215
    STATISTICS_MINIMUM=0.0059000002220273
    STATISTICS_STDDEV=0.067971671312658
    STATISTICS_VALID_PERCENT=67.26

Tengo solo 10 bandas en ID["EPSG",4326]]

CRS
EPSG:4326 - WGS 84 - Geographic
Unit
degrees


# 3- Funcion ConcatenateImages:
Ref: https://www.orfeo-toolbox.org/CookBook/Applications/app_ConcatenateImages.html

- 3.1- Creo layers nvdi

  python3 run_ndvi.py

- 3.2- creo layers run_evi

  python3  run_evi.py

# 4- concateno todos los nvdi en un solo file (muchos layers)

  python3 concat_ndvi.py

# 5- concateno todos los evi en un solo file (muchos layers)

  python3 concat_evi.py

# Importante
 Las imagenes resultantes con los 2 segmentos de la imagen con los 6 layers c/u se encuentre en el Drive TP2.


chequeamos que esten todas las Bandas

  gdalinfo -approx_stats  images/results/0000000000-0000010496_evi.tif


# Descargar mascara de cultivos Inta.
En donde puedo descartar areas que no son de cultivos.
-rw-rw-r-- 1 sebastian sebastian 2179794948 May  8 20:14 0000000000-0000000000_evi.tif
-rw-rw-r-- 1 sebastian sebastian 1114022244 May  8 20:24 0000000000-0000010496_evi.tif

mkdir mascara

cd mascara

wget https://storage.googleapis.com/gis2021-teledeteccion/tp-teledeteccion-2/images/mask_agri_aoi.tif

- Chequeo proyeccion
gdalinfo mask_agri_aoi.tif

#ID["EPSG",4326]]

# Verdad de Campo
Descargo verdad_de_campo.zip y descomprimo en una carpeta.
veo el detalle de los puntos observados:
ogrinfo -so verdad_campo.shp verdad_campo

veo en que esta proyectado
ID["EPSG",4326]]
- ogrinfo -so ./verdad_campo/verdad_campo.shp verdad_campo

CRS
EPSG:4326 - WGS 84 - Geographic
Extent
Unit
degrees

Reproyecto a otra proyeccion que este en metros para poder armar los buffers a 32721

ogr2ogr -f "ESRI Shapefile" -s_srs EPSG:4326 -t_srs EPSG:32721 verdad_campo/verdad_campo_32721.shp verdad_campo/verdad_campo.shp

Chequeo layer:
ogrinfo -so  verdad_campo/verdad_campo_32721.shp verdad_campo_32721

PROJCRS["WGS 84 / UTM zone 21S",
    BASEGEOGCRS["WGS 84",
        DATUM["World Geodetic System 1984",
            ELLIPSOID["WGS 84",6378137,298.257223563,
                LENGTHUNIT["metre",1]]],
                ID["EPSG",32721]]

En metros como queria!


# Departamentos
Descargo departamentos.zip y descomprimo.

ogrinfo -so departamentos/departamentos.shp departamentos


Encoding
UTF-8
Geometry
Polygon (MultiPolygonZ)
CRS
EPSG:4326 - WGS 84 - Geographic


# Tips
Calcular el área en hectáreas para cada polígono y agregarlo con el nombre de area.
Considerar la proyección EPSG:32721 para poder medir en metros.
La relación de cálculo es: 1 m2 = 0.0001 hectáreas
La función es $area*0.0001

ogr2ogr -f GeoJSON ./data/buffer_50_clase3.geojson ./data/buffer_50_clase3.shp



# Junto predicciones

Unir los resultados en ‘results_merge.tif’


gdal_merge.py -ot UInt32 -o ./images/results/results_arbol_merge.tif ./images/results/0000000000-0000000000_labeled_arbol.tif ./images/results/0000000000-0000010496_labeled_arbol.tif


gdal_translate -ot UInt32 ./images/results/results_arbol_merge_temp.tif ./images/results/results_arbol_merge.tif

gdal_translate -ot UInt32 ./images/results/results_arbol_merge.tif ./images/results/results_arbol_merge_temp.tif



### CORRREGIR la mascara a las dimesiones de nuestar area.

Me quedo con los de la mascara (falta cotar la mascara)

gdal_calc.py \
-A ./images/results/results_arbol_merge_temp.tif  \
--A_band=1 \
-B mascara/mask_agri_aoi.tif \
--B_band=1 \
--calc="((B==1)*A)+((B==0)*0)" \
--outfile ./images/results/results_merge_mask_temp.tif

De los resultados mergeados me quedo con Soja


gdal_calc.py \
-A ./images/results/results_arbol_merge_temp.tif  \
--A_band=1 \
--calc="((A==1)*1 + (A!=1)*0)" \
--outfile ./images/results/results_merge_mask_soja.tif

De los resultados mergeados me quedo con otros

gdal_calc.py \
-A ./images/results/results_arbol_merge_temp.tif  \
--A_band=1 \
--calc="((A==3)*1 + (A!=3)*0)" \
--outfile ./images/results/results_merge_mask_otros.tif

Genero un layer con el departamento de Roque Saenz Pena.

ogr2ogr -sql "SELECT * FROM departamentos WHERE nombre='PTE ROQUE SAENZ PENA'" -dialect sqlite ./departamentos/departamentos_rsp.shp ./departamentos/departamentos.shp

ogr2ogr -sql "SELECT * FROM departamentos WHERE nombre='GENERAL VILLEGAS'" -dialect sqlite ./departamentos/departamentos_villegas.shp ./departamentos/departamentos.shp

ogr2ogr -sql "SELECT * FROM departamentos WHERE nombre='GENERAL ROCA'" -dialect sqlite ./departamentos/departamentos_roca.shp ./departamentos/departamentos.shp


Ahora, recortamos cada raster por cultivo y departamento.

Calculo soja para ROQUE SAENZ PEÑA

gdalwarp -cutline ./departamentos/departamentos_rsp.shp -crop_to_cutline  ~/images/results/results_merge_mask_soja.tif ~/images/results/results_merge_mask_soja_rsp.tif

gdalwarp -cutline ./departamentos/departamentos_rsp.shp -crop_to_cutline  ~/images/results/results_merge_mask_soja.tif ~/images/results/results_merge_mask_soja_rsp.tif

gdalwarp -cutline ./departamentos/departamentos_rsp.shp -crop_to_cutline  ~/images/results/results_merge_mask_soja.tif ~/images/results/results_merge_mask_soja_rsp.tif


# Recursos adicionales

1- Estimaciones por cultivo y departamento del Ministerio de Agroindustria, Ganadería y Pesca.
http://datosestimaciones.magyp.gob.ar/reportes.php?reporte=Estimaciones

2- Estimaciones bolsas de cereales:
Buenos Aires: https://www.bolsadecereales.com/estimaciones-informes
Córdoba: https://www.bccba.org.ar/home/dptos-informacion/estadisticas-cultivos/

3- Competencia clasificación de cultivos Fundación Sadosky (buscar código de los ganadores
en GitHub)
https://metadata.fundacionsadosky.org.ar/competition/22/

4- Calendario de siembra y cosecha por cultivo en Argentina
https://public.tableau.com/profile/gabi.ta1236#!/vizhome/Cultivosxprovincia/Cultivosporprovincias

5- Mapa público de cultivos de INTA
https://intainforma.inta.gob.ar/presentan-el-primer-mapa-nacional-de-cultivos-extensivos/
http://geointa.inta.gob.ar/publico/MNC/

6- Mapa público de cultivos MAGyP
https://www.magyp.gob.ar/sitio/areas/estimaciones/acerca_de/mapa_cultivo_fina/index.php
https://www.magyp.gob.ar/sitio/areas/estimaciones/acerca_de/mapa_cultivo_fina/_archivos/000
000_Mapa%20de%20cultivos%20para%20la%20campa%C3%B1a%20fina%202019.pdf
