#!/bin/bash

# Radom Forest

#PolygonClassStatistics
bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_PolygonClassStatistics  -in ./images/results/0000000000-0000000000_evi_plus.tif  \
                        -vec buffer/buffer_50_4326.geojson\
                        -field  id3 \
                        -out ./images/results/images_statistics_0000000000-0000000000_evi_plus.xml'

#SampleSelection
bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_SampleSelection -in ./images/results/0000000000-0000000000_evi_plus.tif \
                       -vec buffer/buffer_50_4326.geojson\
                       -instats ./images/results/images_statistics_0000000000-0000000000_evi_plus.xml \
                       -field id3 \
                       -strategy smallest \
                       -outrates ./images/results/rates_plus.csv \
                       -out ./images/results/samples_plus.sqlite'

#SampleExtraction
bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_SampleExtraction -in ./images/results/0000000000-0000000000_evi_plus.tif \
                        -vec ./images/results/samples_plus.sqlite \
                        -outfield prefix \
                        -outfield.prefix.name band_ \
                        -field id3'


#ComputeImageStatistics
bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_ComputeImagesStatistics -il  ./images/results/0000000000-0000000000_evi_plus.tif \
                               -out ./images/results/images_statistics_tail1_plus.xml'

bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_ComputeImagesStatistics -il  ./images/results/0000000000-0000010496_evi_plus.tif \
                                                              -out ./images/results/images_statistics_tail2_plus.xml'



# 80/20 Train y Test.

#TrainVectorClassifier
#bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_TrainVectorClassifier -io.vd ./images/results/samples_plus.sqlite \
#			     -io.stats ./images/results/images_statistics_tail1_plus.xml \
#                             -cfield id3 \
#                             -classifier rf \
#                             -classifier.rf.max 15 \
#                             -classifier.rf.nbtrees 150 \
#                             -io.out ./images/results/rfModel.txt \
#                             -io.confmatout ./images/results/ConfusionMatrixRF.csv \
#                             -feat band_0 band_1 band_2 band_3 band_4'
bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_TrainImagesClassifier -io.il ./images/results/0000000000-0000000000_evi_plus.tif \
                            -io.vd ./buffer/buffer_50_4326.geojson\
                            -io.imstat ./images/results/images_statistics_tail1_plus.xml \
                            -sample.vtr 0.80 \
                            -sample.vfn id3 \
                            -classifier rf \
                            -classifier.rf.nbtrees 200 \
                            -classifier.rf.max 15 \
                            -io.out ./images/results/RFModel_80.txt \
                            -io.confmatout ./images/results/ConfusionMatrixRF_80.csv'

#Tiene una banda menos

#Predecir sobre el tile 0000000000-0000010496.
#Tener en cuenta que el tile para predecir tiene que tener la misma estructura que la imagen de entrada del punto anterior.

#ImageClassifier
bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_ImageClassifier -in ./images/results/0000000000-0000010496_evi_plus.tif  \
                       -imstat ./images/results/images_statistics_tail2_plus.xml \
                       -model ./images/results/RFModel_80.txt  \
                       -out ./images/results/0000000000-0000010496_labeled_rf.tif'

#Etiqueto la otra mitad
#ImageClassifier
bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_ImageClassifier -in ./images/results/0000000000-0000000000_evi_plus.tif  \
                                              -imstat ./images/results/images_statistics_tail1_plus.xml \
                                              -model ./images/results/RFModel_80.txt  \
                                              -out ./images/results/0000000000-0000000000_labeled_rf.tif'
