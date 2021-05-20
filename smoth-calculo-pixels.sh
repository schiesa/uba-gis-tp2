#!/bin/bash

#Calculo los layer por cultivos


gdal_calc.py -A ./images/results/tp-2_0000000000-0000000000_labeled_arbol_smooth_r2.tif --A_band=1 --calc="((A==1)*1 + (A!=1)*0)" \
--outfile ./images/results/smooth_soja.tif

gdal_calc.py -A ./images/results/tp-2_0000000000-0000000000_labeled_arbol_smooth_r2.tif --A_band=1 --calc="((A==2)*1 + (A!=2)*0)" \
--outfile ./images/results/smooth_maiz.tif

gdal_calc.py -A ./images/results/tp-2_0000000000-0000000000_labeled_arbol_smooth_r2.tif --A_band=1 --calc="((A==3)*1 + (A!=3)*0)" \
--outfile ./images/results/smooth_otros.tif

#Calculo para ROQUE SAENZ PENA

gdalwarp -cutline ./departamentos/repartamentos_rsp.shp -crop_to_cutline ./images/results/smooth_soja.tif ./images/results/smooth_soja_rsp.tif

gdalwarp -cutline ./departamentos/repartamentos_rsp.shp -crop_to_cutline ./images/results/smooth_maiz.tif ./images/results/smooth_maiz_rsp.tif


#Calculo para GENERAL VILLEGAS

gdalwarp -cutline ./departamentos/departamentos_villegas.shp -crop_to_cutline ./images/results/smooth_soja.tif ./images/results/smooth_soja_villegas.tif

gdalwarp -cutline ./departamentos/departamentos_villegas.shp -crop_to_cutline ./images/results/smooth_maiz.tif ./images/results/smooth_maiz_villegas.tif


#Calculo para GENERAL ROCA


gdalwarp -cutline ./departamentos/departamentos_roca.shp -crop_to_cutline ./images/results/smooth_soja.tif ./images/results/smooth_soja_roca.tif

gdalwarp -cutline ./departamentos/departamentos_roca.shp -crop_to_cutline ./images/results/smooth_maiz.tif ./images/results/smooth_maiz_roca.tif
