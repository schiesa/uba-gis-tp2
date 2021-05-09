### para generar verdad_campo.geojson se hace haciendo guardar como geojson desde QGIS

####ARBOL
####PolygonClassStatistics
bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_PolygonClassStatistics  -in ./images/results/0000000000-0000000000_evi.tif \
                        -vec buffer/buffer_50_4326.geojson\
                        -field  id3 \
                        -out ./images/results/images_statistics_0000000000-0000000000_evi.xml'




###SampleSelection
bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_SampleSelection -in ./images/results/0000000000-0000000000_evi.tif \
                       -vec buffer/buffer_50_4326.geojson\
                       -instats ./images/results/images_statistics_0000000000-0000000000_evi.xml \
                       -field id3 \
                       -strategy smallest \
                       -outrates ./images/results/rates.csv \
                       -out ./images/results/samples.sqlite'

###SampleExtraction
bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_SampleExtraction -in ./images/results/0000000000-0000000000_evi.tif \
                        -vec ./images/results/samples.sqlite \
                        -outfield prefix \
                        -outfield.prefix.name band_ \
                        -field id3'


###ComputeImageStatistics
bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_ComputeImagesStatistics -il  ./images/results/0000000000-0000000000_evi.tif \
                               -out ./images/results/images_statistics_tail1.xml'


ARBOL
###TrainVectorClassifier
bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_TrainVectorClassifier -io.vd ./images/results/samples.sqlite \
                             -io.stats ./images/results/images_statistics_tail1.xml \
                             -cfield id3 \
                             -classifier dt \
                             -classifier.dt.max 5 \
                             -io.out ./images/results/modeloArbol.txt \
                             -io.confmatout ./images/results/ConfusionMatrixArbol.csv \
                             -feat band_0 band_1 band_2 band_3 band_4 band_5'

###PREDICCION
bash -c 'source ~/OTB-7.2.0-Linux64/otbenv.profile; otbcli_ImageClassifier -in ./images/results/0000000000-0000010496_evi.tif \
                       -imstat ./images/results/images_statistics_tail1.xml  \
                       -model ./images/results/modeloArbol.txt \
                       -out ./images/results/0000000000-0000010496_labeled_arbol.tif'
