#!/usr/bin/python3

import subprocess
import glob
import os

max_depth = 50
for i in range(4,max_depth):
    if i != max_depth -1:
        concat = ""
    else:
        concat = ""
    cmd = """bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_TrainVectorClassifier \
-io.vd ./images/results/samples.sqlite \
-io.stats ./images/results/images_statistics_tail1.xml \
-cfield id3 \
-classifier dt \
-classifier.dt.max {depth} \
-io.out ./images/results/dTModel_{depth}.txt \
-io.confmatout ./images/results/ConfusionMatrixArbol_{depth}.csv \
-feat band_0 band_1 band_2 band_3 band_4 band_5' | grep -oP '(?<=Kappa index: )[0-9]+\.[0-9]+' >> ./images/results/kappas_trees_dt.txt {concat} """.format(depth=i, concat=concat)
    print(cmd)
    subprocess.run(cmd, shell=True)
