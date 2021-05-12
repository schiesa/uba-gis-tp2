import subprocess
import glob
import os
tile = '0000000000-0000000000'
images_ndvi = sorted(glob.glob(
    './images/aoi/**/{tile}_evi.tif'.format(tile=tile)))
images_ndvi_otb = ' '.join(images_ndvi)
im_out_fname = './images/aoi/results/{tile}_evi_plus.tif'.format(
    tile=tile)
cmd = """bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile;  otbcli_ConcatenateImages -il {im} -out {im_out}'""".format(
    im=images_ndvi_otb, im_out=im_out_fname)
print(cmd)
subprocess.run(cmd, shell=True)



print("Ahora conectanamos la segunda midad del area")
tile = '0000000000-0000010496'
images_ndvi = sorted(glob.glob(
    './images/aoi/**/{tile}_evi.tif'.format(tile=tile)))
images_ndvi_otb = ' '.join(images_ndvi)
im_out_fname = './images/aoi/results/{tile}_evi_plus.tif'.format(
    tile=tile)
cmd = """bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile;  otbcli_ConcatenateImages -il {im} -out {im_out}'""".format(
    im=images_ndvi_otb, im_out=im_out_fname)
print(cmd)
subprocess.run(cmd, shell=True)


#bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile;  otbcli_ConcatenateImages -il ./images/aoi/2020-10-01/0000000000-0000000000_evi.tif ./images/aoi/2020-11-01/0000000000-0000000000_evi.tif ./images/aoi/2020-12-01/0000000000-0000000000_evi.tif ./images/aoi/2021-01-01/0000000000-0000000000_evi.tif ./images/aoi/2021-02-20/0000000000-0000000000_evi.tif ./images/aoi/2021-03-17/0000000000-0000000000_evi.tif -out ./images/aoi/results/0000000000-0000000000_evi.tif'
