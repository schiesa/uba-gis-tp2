import rasterio as rio
file = './images/results/smooth_soja_rsp.tif'
raster = rio.open(file).read()
raster_crop = raster[raster==1]
sum_pixels = raster_crop.sum()
print("ROQUE SAENZ PEÑA")
print("Soja ",sum_pixels, " pixels ",sum_pixels*0.04," Hectareas")

file = './images/results/smooth_maiz_rsp.tif'
raster = rio.open(file).read()
raster_crop = raster[raster==1]
sum_pixels = raster_crop.sum()
print("Maiz ",sum_pixels, " pixels ",sum_pixels*0.04," Hectareas")

print("")
file = './images/results/smooth_soja_villegas.tif'
raster = rio.open(file).read()
raster_crop = raster[raster==1]
sum_pixels = raster_crop.sum()
print("GENERAL VILLEGAS")
print("Soja ",sum_pixels, " pixels ",sum_pixels*0.04," Hectareas")

file = './images/results/smooth_maiz_villegas.tif'
raster = rio.open(file).read()
raster_crop = raster[raster==1]
sum_pixels = raster_crop.sum()
print("Maiz ",sum_pixels, " pixels ",sum_pixels*0.04," Hectareas")

print("")

file = './images/results/smooth_soja_roca.tif'
raster = rio.open(file).read()
raster_crop = raster[raster==1]
sum_pixels = raster_crop.sum()
print("GENERAL ROCA")
print("Soja ",sum_pixels, " pixels ",sum_pixels*0.04," Hectareas")

file = './images/results/smooth_maiz_roca.tif'
raster = rio.open(file).read()
raster_crop = raster[raster==1]
sum_pixels = raster_crop.sum()
print("Maiz ",sum_pixels, " pixels ",sum_pixels*0.04," Hectareas")
