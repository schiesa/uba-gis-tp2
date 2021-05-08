import subprocess
import glob
import os
images = glob.glob('./images/aoi/**/*.tif')
for image in images:
    fname, ext = os.path.splitext(image)
    im_out_fname = '{im}_evi.tif'.format(im=fname)
    cmd = """bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile;  otbcli_BandMath -il {im} -out {im_out} -exp "(2.5*(im1b7-im1b3))/((1+im1b7+6*im1b3-7.5*im1b1))"'""".format(
        im=image, im_out=im_out_fname)
    print(cmd)
    subprocess.run(cmd, shell=True)
