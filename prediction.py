# -*- coding: utf-8 -*-
import numpy as np
import sys, os
import types
import Image

sys.path.append('/opt/software/caffe-master/python/')
sys.path.append('/usr/local/lib/python2.7/dist-packages/')

import caffe
from skimage import io
from PIL import Image
from matplotlib import pyplot as plt
import matplotlib.image as mpimg
import scipy.io as sio



caffe.set_device(0)
caffe.set_mode_gpu()


input_photo_folderD = './testD/'
input_photo_folderS = './testS/'

#meanDa = 'meanD_test.png'
#meanSa = 'meanS_test.png'

l = ['720']


#l = ['410','420','430','440','450','480','500','510','520','530','540','550','560','570','580','590','600','700','710','720','730','740','750','760','770','780','790','800','810','820','830','840','850','860','870','880','890','900','950','1000']
#l = ['100','130','150','180','200','220','250','280','300','320','350','380','400','420','450','480','500','530','550','580','600']
#l = ['150','180','200','220','250','280','300','320','340']
#l = ['400','410','420','430','440','450','460','470','480','490','500']

#l = ['150','180','200','220','250','280','300','310','320','330','340','350','360','370','380','390','400','410','420','430','440','450','460','470','480','490','500','510','520','530','540','550','560','570','580','590','600']
#l = ['391','392','393','394','395','396','397','398','400','401','402','403','405','406','407','408','409','410']
#l = ['510','520','530','540','550','560','570','580','590','600','610','620']
#l = ['600','620','530','640','650','660','670','680','690','700','710','720','730','740','750','760','770','780','790','800','810','820','830','840','850','860','870','880','890','900','950','1000']
#l = ['1900','1910','1920','1930','1940','1950','1960','1970','1980','1990','2000','2010','2020','2030','2040','2050','2060','2070']
#l = ['150','180','200',210,'220','230','240','250','260','280','290','300','310','320','330','340','350','360','370','380','390','400','420','450','500']
#l = ['150','200','250','300','350','400','450','500','550','600','650','700','750','800','850','900']
#l = ['600','700','800','600','700','800','600','700','800','600','700','800','600','700','800']
#l = ['300','310','320','330','340','350','360','370','380','390','400','410','420','430','440','450','460','470','480','490','500','500','510','520','530','540','550','560','570','580','590','600']
#l = ['610','620','630','640','650','660','670','680','690']

testing=np.zeros(shape=(len(l), 3))
#testing=np.zeros(shape=(470, 3))

kk=0
for it in l[0:]: #range(150,630):

    net_file = './deploy.prototxt'
    caffe_model = './model/mod_iter_' + str(it) + '.caffemodel'

    net = caffe.Net(net_file, caffe_model, caffe.TEST)


    transformerd = caffe.io.Transformer({'test_photod': net.blobs['dataD'].data.shape})
    #transformer = caffe.io.Transformer({'test_photo': net.blobs['dataS'].data.shape})
    transformerd.set_transpose('test_photod', (2, 0, 1))
    #transformer.set_channel_swap('test_photo', (2,1,0)) # if using RGB instead of BGR

    transformerd.set_raw_scale('test_photod', 255)


    transformers = caffe.io.Transformer({'test_photos': net.blobs['dataS'].data.shape})
    transformers.set_transpose('test_photos', (2, 0, 1))
    transformers.set_channel_swap('test_photos', (2,1,0)) # if using RGB instead of BGR
    transformers.set_raw_scale('test_photos', 255)





    filesD =  os.listdir(input_photo_folderD)
    filesS =  os.listdir(input_photo_folderS)

    filesS.sort()
    filesD.sort()

    matrix = np.zeros(shape=(len(filesD), 28))


    for i in range(0,len(filesD)):

        filenameD = os.path.join(input_photo_folderD, filesD[i])

        filenameS = os.path.join(input_photo_folderS, filesS[i])

        strinD    = os.path.basename(filesD[i])

        strinS    = os.path.basename(filesS[i])

        strinDlabel    = strinD[1:len(strinD) - 16]

        #print filenameD
        #print filenameS
        #print strinDlabel




        #print strinDl


        #print strinDl
        #imS=mpimg.imread(filenameS)

        imD = caffe.io.load_image(filenameD, False) ################ grey image in range [0,1].
        imS = caffe.io.load_image(filenameS)   ################# grey image in range [0,1].
        #immeanD = caffe.io.load_image(meanDa, False) ################ grey image in range [0,1].
        #immeanS = caffe.io.load_image(meanSa, False)  ################# grey image in range [0,1].

        #net.blobs['dataS'].reshape(1,3,112,112)

        net.blobs['dataD'].data[...] =  transformerd.preprocess('test_photod', imD)

        net.blobs['dataS'].data[...] =  transformers.preprocess('test_photos', imS)

        #img=mpimg.imread(filenameS)
        #for r in range(0,112):
            #for t in range(0,112):
                #print img[r,t]

        net.forward()
        
        outputDS = net.blobs['prob'].data
        outputS = net.blobs['prob1'].data
        outputD = net.blobs['prob2'].data
        
        First = np.multiply(outputDS, outputS)
        
        output= np.multiply(First, outputD)*np.maximum(outputS, outputD)
        
        
        matrix[i][0]=float(strinDlabel)
        matrix[i][1:28]=output[0]
        #print output_sketch

    np.set_printoptions(threshold='nan')
    sio.savemat('action.mat', {'Matrix1':matrix})

    res=np.zeros(shape=(len(matrix), 3))

    numb=0



    for i in range(0,len(matrix)):

       y=np.argmax(matrix[i][1:28])
       mx=max(matrix[i][1:28])
       #print matrix[i][1:28]
       # print y
       #print mx



       #raw_input("Press Enter")
       res[i][0]=matrix[i][0]
       res[i][1]=mx

       if y==0 :
               res[i][2]=27
       else :
               res[i][2]= y

       if res[i][0]==res[i][2] :
               numb=numb+1


    testing[kk][0] =it
    testing[kk][1] = numb
    testing[kk][2] = (numb*100)/(len(matrix))
    kk=kk+1

print testing
