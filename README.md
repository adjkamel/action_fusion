### Deep Convolutional Neural Networks for Human Action Recognition Using Depth Maps and Postures 
This repository contains code for the paper [Deep Convolutional Neural Networks for Human Action Recognition Using Depth Maps and Postures
](https://ieeexplore.ieee.org/abstract/document/8409991)

#### Requirements
- Caffe
- Python 3
- Matlab 2016a or above
#### Datasets
Links of the datasets: [MSR-Action 3D](https://www.microsoft.com/en-us/download/details.aspx?id=52315), [UTD-MHAD](https://personal.utdallas.edu/~kehtar/UTD-MHAD.html), and [MAD](http://humansensing.cs.cmu.edu/mad/download.html)

#### Preprocessing

- DMI descriptor: Use DMI.m to generate DMI descriptors from he raw data.
- Some of the DMI descriptors are shown bellow:
- ![d](https://user-images.githubusercontent.com/50513215/120083391-48a5a080-c0c0-11eb-8322-e5ecd46c38a8.PNG)

- MJD descriptor: Use MJD.m to generate DMI descriptors from he raw data.
- The order of the skeleton joints numbers in the raw data and the order used in MJD.m is shown bellow:
![skelorder](https://user-images.githubusercontent.com/50513215/120175827-827cc100-c1fe-11eb-9605-393f9e7bdced.PNG)
- Some of the MJD descriptors are shown bellow:
![s](https://user-images.githubusercontent.com/50513215/120083401-683cc900-c0c0-11eb-97d2-18bb6d072a2c.PNG)

#### Models
- The models were trained using Caffe deep learning framework.
- The folders 
#### Resullts
The pretrained model for each dataset:

- [MSR-Action 3D](https://drive.google.com/file/d/1pS1OvaIKzJdjvwwixY7SrhvWxRJUUpe_/view?usp=sharing)
- [UTD-MHAD](https://drive.google.com/file/d/1VBtGFLbaG9vsCKPurWsvtRdgJ8PA2kjK/view?usp=sharing)
- [MAD](https://drive.google.com/file/d/1zQVFCoDbr4JvEgrR5K5591iS5y5HJbyA/view?usp=sharing)

https://user-images.githubusercontent.com/50513215/120119097-be2b7280-c18d-11eb-9fc0-be5ea76e37c2.mp4

- More details can be found in the paper
