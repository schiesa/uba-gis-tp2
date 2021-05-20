# UBA-GIS-TP2

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

- Convierto de Shapefile a geojson
ogr2ogr -f GeoJSON ./buffer/buffer_50_4326.geojson ./buffer/buffer_50_4326.shp



# 3- Funcion ConcatenateImages:
Ref: https://www.orfeo-toolbox.org/CookBook/Applications/app_ConcatenateImages.html

- 3.1- Creo layers nvdi

  python3 run_ndvi.py

- 3.2- creo layers run_evi

  python3  run_evi.py


# 4- concateno todos los nvdi en un solo file (muchos layers)

  python3 concat_ndvi.py

# 5- concateno todos los evi en un solo file (muchos layers)

- 5.1 python3 concat_evi.py

- 5.2 Ahora Saco las carpetas de enero que son los meses en que no se distingue bien Soja de Maiz.

python3 concat_evi_plus.py

 - 5.3 Ahora chequeo el resultado:

 Las imagenes resultantes con los 2 segmentos (tail) de la imagen con los 6 layers c/u se encuentre evi y ndvi.

 Las imagenes resultantes con los 2 segmentos (tail) de la imagen con los 5 layers c/u para evi_plus.


chequeamos que esten todas las Bandas

  gdalinfo -approx_stats  images/results/0000000000-0000010496_evi.tif

# 6- Filtros -Suavisado  
bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_Smoothing -in ./images/results/0000000000-0000000000_labeled_arbol.tif -out ./images/results/0000000000-0000000000_labeled_arbol_smooth_r2.tif -type mean -type.mean.radius 2'

- 6.1 aplicar matriz de confusion considerando prediccion en tile 1 y puntos de verdad de campo.

bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile;
otbcli_ComputeConfusionMatrix -in ./images/results/0000000000-0000000000_labeled_arbol_smooth_r2.tif -out ConfusionMatrix_sr2.csv \
-ref vector \
-ref.vector.in ~/buffer/buffer_50_4326.geojson \
-ref.vector.field id3 \
-ref.vector.nodata 0'


bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_Smoothing -in ./images/results/0000000000-0000000000_labeled_arbol.tif -out ./images/results/0000000000-0000000000_labeled_arbol_smooth_g.tif -type gaussian'

- 6.2 aplicar matriz de confusion considerando prediccion en tile 1 y puntos de verdad de campo.

bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile;
otbcli_ComputeConfusionMatrix -in ./images/results/0000000000-0000000000_labeled_arbol_smooth_g.tif -out ConfusionMatrix_sg.csv \
-ref vector \
-ref.vector.in ~/buffer/buffer_50_4326.geojson \
-ref.vector.field id3 \
-ref.vector.nodata 0'

- Nota: radio 2 pixels. (No 10 como tenia el tutorial)
- Nota: Deberia suavisar el arbol generado sin Enero.

# 7- Segmentacion
Para este documento nos va a interesar el algoritmo Meanshift (Fukunaga and Hostetler, 1975 y aquí para una introducción técnica).
Lo aplico mas adelante cuando tengo todo junto.


# 8- Descargar mascara de cultivos INTA.
En donde puedo descartar areas que no son de cultivos.

mkdir mascara
cd mascara
wget https://storage.googleapis.com/gis2021-teledeteccion/tp-teledeteccion-2/images/mask_agri_aoi.tif

- Chequeo proyeccion
gdalinfo mask_agri_aoi.tif

#ID["EPSG",4326]]

# 9- Verdad de Campo
Descargo verdad_de_campo.zip y descomprimo en una carpeta.
veo el detalle de los puntos observados:

ogrinfo -so verdad_campo.shp verdad_campo

- veo en que si esta proyectado en ID["EPSG",4326]]

ogrinfo -so ./verdad_campo/verdad_campo.shp verdad_campo

Resultado:
CRS
EPSG:4326 - WGS 84 - Geographic
Extent
Unit
degrees

- Reproyecto a otra proyeccion que este en metros para poder armar los buffers a 32721

ogr2ogr -f "ESRI Shapefile" -s_srs EPSG:4326 -t_srs EPSG:32721 verdad_campo/verdad_campo_32721.shp verdad_campo/verdad_campo.shp

- Chequeo layer:
ogrinfo -so  verdad_campo/verdad_campo_32721.shp verdad_campo_32721

PROJCRS["WGS 84 / UTM zone 21S",
    BASEGEOGCRS["WGS 84",
        DATUM["World Geodetic System 1984",
            ELLIPSOID["WGS 84",6378137,298.257223563,
                LENGTHUNIT["metre",1]]],
                ID["EPSG",32721]]

En metros como queriamos!


# 10 - Departamentos
Descargo departamentos.zip y descomprimo.

- Chequeo proyeccion
ogrinfo -so departamentos/departamentos.shp departamentos

Resultado:
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

# 11- Ahora utilizo los scripts para generar las clasificaciones

- 11.1 Corro 100 arboles con :
./arboles-multiple-deph.py
De ahi mido los Kappa y me quedo con profundidad 11 (no 5 como el ejemplo)

- 11.2 Corro 1 arbol con los parametros optimos asi me quedo con todos los datos.
./arbol.sh

- 11.3 Corro RandomForest (con evi_plus):
./randomforest.sh

2021-05-12 06:30:19 (INFO) TrainVectorClassifier: Computing model file : ./images/results/rfModel.txt
Training model...: 100% [**************************************************] (0s)
Validation...: 100% [**************************************************] (0s)
2021-05-12 06:30:19 (INFO) TrainVectorClassifier: Predicted list size : 1893
2021-05-12 06:30:19 (INFO) TrainVectorClassifier: ValidationLabeledListSample size : 1893
2021-05-12 06:30:19 (INFO) TrainVectorClassifier: Training performances:
2021-05-12 06:30:19 (INFO) TrainVectorClassifier: Confusion matrix (rows = reference labels, columns = produced labels):
    [1] [2] [3]
[1] 631   0   0
[2]   0 628   3
[3]   0   2 629

2021-05-12 06:30:19 (INFO) TrainVectorClassifier: Precision of class [1] vs all: 1
2021-05-12 06:30:19 (INFO) TrainVectorClassifier: Recall of class    [1] vs all: 1
2021-05-12 06:30:19 (INFO) TrainVectorClassifier: F-score of class   [1] vs all: 1

2021-05-12 06:30:19 (INFO) TrainVectorClassifier: Precision of class [2] vs all: 0.996825
2021-05-12 06:30:19 (INFO) TrainVectorClassifier: Recall of class    [2] vs all: 0.995246
2021-05-12 06:30:19 (INFO) TrainVectorClassifier: F-score of class   [2] vs all: 0.996035

2021-05-12 06:30:19 (INFO) TrainVectorClassifier: Precision of class [3] vs all: 0.995253
2021-05-12 06:30:19 (INFO) TrainVectorClassifier: Recall of class    [3] vs all: 0.99683
2021-05-12 06:30:19 (INFO) TrainVectorClassifier: F-score of class   [3] vs all: 0.996041

2021-05-12 06:30:19 (INFO) TrainVectorClassifier: Global performance, Kappa index: 0.996038
2021-05-12 06:30:19 (INFO) TrainVectorClassifier: mapOfIndicesValid[0] = 1
2021-05-12 06:30:19 (INFO) TrainVectorClassifier: mapOfIndicesValid[1] = 2
2021-05-12 06:30:19 (INFO) TrainVectorClassifier: mapOfIndicesValid[2] = 3

Clasifica muy bien!!!!


# 12 - Junto predicciones


Unir los resultados en ‘results_merge.tif’

- 10.1 Junto resultados de arboles

gdal_merge.py -ot UInt32 -o ./images/results/results_arbol_merge.tif ./images/results/0000000000-0000000000_labeled_arbol.tif ./images/results/0000000000-0000010496_labeled_arbol.tif

No recuerdo cual era el origen y destino pero es uno de estos 2 comandos:
gdal_translate -ot UInt32 ./images/results/results_arbol_merge.tif ./images/results/results_arbol_merge_temp.tif

- 10.2 Junto resultados de RandomForest
gdal_merge.py -ot UInt32 -o ./images/results/results_rf_merge.tif ./images/results/0000000000-0000000000_labeled_rf.tif ./images/results/0000000000-0000010496_labeled_rf.tif

gdal_translate -ot UInt32 ./images/results/results_rf_merge.tif ./images/results/results_rf_merge_temp.tif


12 - 2. Opcion de Juntar los 2 tail y corro un arbol con el 80/20.

./randomforest-complete.sh


[1] [2] [3]
[1] 956   0  32
[2] 454  12 522
[3]  51   9 928

2021-05-19 22:59:23 (INFO) TrainImagesClassifier: Precision of class [1] vs all: 0.654346
2021-05-19 22:59:23 (INFO) TrainImagesClassifier: Recall of class    [1] vs all: 0.967611
2021-05-19 22:59:23 (INFO) TrainImagesClassifier: F-score of class   [1] vs all: 0.780727

2021-05-19 22:59:23 (INFO) TrainImagesClassifier: Precision of class [2] vs all: 0.571429
2021-05-19 22:59:23 (INFO) TrainImagesClassifier: Recall of class    [2] vs all: 0.0121457
2021-05-19 22:59:23 (INFO) TrainImagesClassifier: F-score of class   [2] vs all: 0.0237859

2021-05-19 22:59:23 (INFO) TrainImagesClassifier: Precision of class [3] vs all: 0.626181
2021-05-19 22:59:23 (INFO) TrainImagesClassifier: Recall of class    [3] vs all: 0.939271
2021-05-19 22:59:23 (INFO) TrainImagesClassifier: F-score of class   [3] vs all: 0.751417

2021-05-19 22:59:23 (INFO) TrainImagesClassifier: Global performance, Kappa index: 0.459514
2021-05-19 22:59:23 (INFO) TrainImagesClassifier: mapOfIndicesValid[0] = 1
2021-05-19 22:59:23 (INFO) TrainImagesClassifier: mapOfIndicesValid[1] = 2
2021-05-19 22:59:23 (INFO) TrainImagesClassifier: mapOfIndicesValid[2] = 3




# 13 - Aplico la mascara del INTA que tiene las dimesiones de nuestra area y la misma resolucion (corregido por el profe)

- 11.1 Arbol
gdal_calc.py \
-A ./images/results/results_arbol_merge_temp.tif  \
--A_band=1 \
-B mascara/mask_agri_aoi.tif \
--B_band=1 \
--calc="((B==1)*A)+((B==0)*0)" \
--outfile ./images/results/results_merge_mask_temp.tif

- 11.2 RandomForest
gdal_calc.py \
-A ./images/results/results_rf_merge_temp.tif  \
--A_band=1 \
-B mascara/mask_agri_aoi.tif \
--B_band=1 \
--calc="((B==1)*A)+((B==0)*0)" \
--outfile ./images/results/results_rf_merge_masked.tif


# Hasta aqui tengo todo clasificado, el que tiene la mascara , ofusca la posibilidad de utilizar segmentacion, por lo que voy a utilizar la mascara mas adelante.

# 14 - Calculo por Pixel
-14.1 De los resultados mergeados me quedo con Soja


gdal_calc.py \
-A ./images/results/results_arbol_merge_temp.tif  \
--A_band=1 \
--calc="((A==1)*1 + (A!=1)*0)" \
--outfile ./images/results/results_merge_mask_soja.tif


me quedo con el maiz

gdal_calc.py \
-A ./images/results/results_arbol_merge_temp.tif  \
--A_band=1 \
--calc="((A==2)*1 + (A!=2)*0)" \
--outfile ./images/results/results_merge_mask_maiz.tif


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

Calculo para ROQUE SAENZ PEÑA

gdalwarp -cutline ./departamentos/repartamentos_rsp.shp -crop_to_cutline  ./images/results/results_merge_mask_soja.tif ./images/results/results_merge_mask_soja_rsp.tif

gdalwarp -cutline ./departamentos/repartamentos_rsp.shp -crop_to_cutline  ./images/results/results_merge_mask_maiz.tif ./images/results/results_merge_mask_maiz_rsp.tif

gdalwarp -cutline ./departamentos/repartamentos_rsp.shp -crop_to_cutline  ./images/results/results_merge_mask_otros.tif ./images/results/results_merge_mask_otros_rsp.tif


Calculo para GENERAL VILLEGAS

gdalwarp -cutline ./departamentos/departamentos_villegas.shp -crop_to_cutline  ./images/results/results_merge_mask_soja.tif ./images/results/results_merge_mask_soja_villegas.tif

gdalwarp -cutline ./departamentos/departamentos_villegas.shp -crop_to_cutline  ./images/results/results_merge_mask_maiz.tif ./images/results/results_merge_mask_maiz_villegas.tif

gdalwarp -cutline ./departamentos/departamentos_villegas.shp -crop_to_cutline  ./images/results/results_merge_mask_otros.tif ./images/results/results_merge_mask_otros_villegas.tif

Calculo para GENERAL ROCA

gdalwarp -cutline ./departamentos/departamentos_roca.shp -crop_to_cutline  ./images/results/results_merge_mask_soja.tif ./images/results/results_merge_mask_soja_roca.tif

gdalwarp -cutline ./departamentos/departamentos_roca.shp -crop_to_cutline  ./images/results/results_merge_mask_maiz.tif ./images/results/results_merge_mask_maiz_roca.tif

gdalwarp -cutline ./departamentos/departamentos_roca.shp -crop_to_cutline  ./images/results/results_merge_mask_otros.tif ./images/results/results_merge_mask_otros_roca.tif


- Pasar los resultados del ejercicio anterior a hectáreas.

Cada píxel mide aproximadamente 20 metros de lado, por lo que cada uno mide entonces 400 metros cuadrados. Esto equivale a 0.04 hectáreas.

Veo resultados
python3 cuenta-pixels.py

ROQUE SAENZ PEÑA
Soja 5585065 pixels 223402.6 Hectareas
Maiz 10302749  pixels 412109.96  Hectareas

GENERAL VILLEGAS
Soja 4488394  pixels 179535.76 Hectareas
Maiz 9097184  pixels 363887.36  Hectareas

GENERAL ROCA
Soja 7091860  pixels 283674.4  Hectareas
Maiz 19629041 785161.64 Hectareas

14.2 Random Forest por PIXEL

gdal_calc.py -A ./images/results/results_rf_merge_temp.tif --A_band=1 --calc="((A==1)*1 + (A!=1)*0)" \
--outfile ./images/results/rf_results_merge_mask_soja.tif

gdal_calc.py -A ./images/results/results_rf_merge_temp.tif --A_band=1 --calc="((A==2)*1 + (A!=2)*0)" \
--outfile ./images/results/results_merge_mask_maiz.tif

gdal_calc.py -A ./images/results/results_rf_merge_temp.tif --A_band=1 --calc="((A==3)*1 + (A!=3)*0)" --outfile ./images/results/rf_results_merge_mask_otros.tif

gdalwarp -cutline ./departamentos/repartamentos_rsp.shp -crop_to_cutline ./images/results/rf_results_merge_mask_soja.tif ./images/results/rf_results_merge_mask_soja_rsp.tif

gdalwarp -cutline ./departamentos/repartamentos_rsp.shp -crop_to_cutline ./images/results/rf_results_merge_mask_maiz.tif ./images/results/rf_results_merge_mask_maiz_rsp.tif


Calculo para GENERAL VILLEGAS

gdalwarp -cutline ./departamentos/departamentos_villegas.shp -crop_to_cutline ./images/results/rf_results_merge_mask_soja.tif ./images/results/rf_results_merge_mask_soja_villegas.tif

gdalwarp -cutline ./departamentos/departamentos_villegas.shp -crop_to_cutline ./images/results/rf_results_merge_mask_maiz.tif ./images/results/rf_results_merge_mask_maiz_villegas.tif


#Calculo para GENERAL ROCA

gdalwarp -cutline ./departamentos/departamentos_roca.shp -crop_to_cutline ./images/results/rf_results_merge_mask_soja.tif ./images/results/rf_results_merge_mask_soja_roca.tif

gdalwarp -cutline ./departamentos/departamentos_roca.sh

- Totales x pixel por RF
ROQUE SAENZ PEÑA
Soja 4521758 pixels 180870.32 Hectareas
Maiz 11431863  pixels 457274.52  Hectareas

GENERAL VILLEGAS
Soja 2624845  pixels 104993.8 Hectareas
Maiz 12060363  pixels 482414.52  Hectareas

GENERAL ROCA
Soja 5831862  pixels 233274.48  Hectareas
Maiz 21284898 pixels 851395.92 Hectareas



# 15 - Ahora vamos por la segmentacion

15.1 Segmentar una porción del tile 0000000000-0000000000 en base a un área de interés. Descargar el polígono desde este link:

mkdir segmentos
wget https://storage.googleapis.com/gis2021-teledeteccion/tp-teledeteccion-2/segs/aoi_segs_clip.zip
cd segmentos/
unzip aoi_segs_clip.zip
rm aoi_segs_clip.zip
cd ..

NOTA: Es un rectangulo que abarca los 3 departamentos que nos interesa.(sin mascara para que se puede segmentar bien)

15.2 Recortamos la imagen para no segmentar todo.

Primero recortamos la imagen que viene del punto 12.:

gdalwarp -t_srs EPSG:4326 -of GTiff -cutline ./segmentos/aoi_segs.shp -cl aoi_segs -crop_to_cutline ./images/results/results_rf_merge_temp.tif  ./images/results/results_rf_merge_clip.tif


- 15.3 Segmentamos con Meanshift.

MeanShiftSmoothing:

bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_MeanShiftSmoothing \
-in  ./images/results/results_rf_merge_clip.tif \
-fout  ./images/results/results_rf_merge_clip_smooth.tif \
-foutpos  ./images/results/results_rf_merge_clip_smooth_pos.tif \
-spatialr 5 \
-ranger 0.1 \
-maxiter 100'

15.4 LSMSSegmentation
bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_LSMSSegmentation -in ./images/results/results_rf_merge_clip_smooth.tif \
-inpos ./images/results/results_rf_merge_clip_smooth_pos.tif \
-out ./images/results/evi_plus_clip_seg.tif \           
-spatialr 5 \
-ranger 0.1 \
-minsize 5 \
-tilesizex 1024 \
-tilesizey 1024'


- 15.4 LSMSVectorization
bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_LSMSVectorization -in ./images/results/results_rf_merge_clip.tif  \
  -inseg ./images/results/evi_plus_clip_seg.tif  \
  -out ./images/results/evi_plus_clip_seg.shp'

# TENGO QUE REVISAR LA SEGMENTACION!!!!! CORRE TODO PERO TENGO UN ERROR CON EL AREA!! Creo que el clip  es un subsegmento de prueba


# Recursos adicionales
Procesamiento de datos vectoriales
https://docs.google.com/document/d/1UKcRoR7ajk1mEcmdqxk2lwx8spcXxez9UmP1k6Gi1dw/edit#heading=h.ts73213yd7m3

Bitácora ejercicios teledetección
https://docs.google.com/document/d/1zE4oFIGIQ0yXZJmgxsoPdYhyew2kUoMXQmr5WwbEMwY/edit

https://docs.qgis.org/3.16/en/docs/training_manual/rasters/data_manipulation.html

convierte drive to url
https://sites.google.com/site/gdocs2direct/home

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
