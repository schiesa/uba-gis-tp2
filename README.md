# uba-gis-tp2
calculo de áreas de cultivo de maíz y soja a partir de imágenes de satélites.


1- Descargo imagenes satelitales

├── images
│   └── aoi
│       ├── 2020-10-01
│       │   ├── 0000000000-0000000000_ndvi.tif
│       │   ├── 0000000000-0000000000.tif
│       │   ├── 0000000000-0000010496_ndvi.tif
│       │   └── 0000000000-0000010496.tif
│       ├── 2020-11-01
│       │   ├── 0000000000-0000000000_evi.tif
│       │   ├── 0000000000-0000000000_ndvi.tif
│       │   ├── 0000000000-0000000000.tif
│       │   ├── 0000000000-0000010496_evi.tif
│       │   ├── 0000000000-0000010496_ndvi.tif
│       │   └── 0000000000-0000010496.tif
│       ├── 2020-12-01
│       │   ├── 0000000000-0000000000_evi.tif
│       │   ├── 0000000000-0000000000_ndvi.tif
│       │   ├── 0000000000-0000000000.tif
│       │   ├── 0000000000-0000010496_eva.tif
│       │   ├── 0000000000-0000010496_evi.tif
│       │   ├── 0000000000-0000010496_ndvi.tif
│       │   └── 0000000000-0000010496.tif
│       ├── 2021-01-01
│       │   ├── 0000000000-0000000000_ndvi.tif
│       │   ├── 0000000000-0000000000.tif
│       │   ├── 0000000000-0000010496_ndvi.tif
│       │   └── 0000000000-0000010496.tif
│       ├── 2021-02-01
│       │   ├── 0000000000-0000000000_ndvi.tif
│       │   ├── 0000000000-0000000000.tif
│       │   ├── 0000000000-0000010496_ndvi.tif
│       │   └── 0000000000-0000010496.tif
│       ├── 2021-03-01
│       │   ├── 0000000000-0000000000_ndvi.tif
│       │   ├── 0000000000-0000000000.tif
│       │   ├── 0000000000-0000010496_evi.tif
│       │   ├── 0000000000-0000010496_ndvi.tif
│       │   └── 0000000000-0000010496.tif
│       └── results
│           ├── 0000000000-0000000000_ndvi.tif
│           └── 0000000000-0000010496_ndvi.tif

2- Creo layers nvdi
python3 run_ndvi.py

3- creo layers run_evi
python3  run_evi.py

4- concateno todos los nvdi en un solo file (muchos layers)
python3 concat_ndvi.py
5- concateno todos los evi en un solo file (muchos layers)
python3 concat_evi.py
