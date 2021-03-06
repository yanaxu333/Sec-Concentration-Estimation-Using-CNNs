#this code include create train_all.txt file and test_all.txt file
#and convert the image data to the lmdb format
#and compute the mean file of two version(py and other)

#NOTE::::
#before executing this file, you need to configure the convert_mean.py  create_lmdb.sh
V=argu_par_ic/1fold_2013_parIC
path=/home/lein/yan/caffe/finetunning_thesis/$V
path2=finetunning_thesis/$V


cd $path/train
rm -rf train_all.txt
cat  *.txt > $path/temp2/train_all1.txt

cd $path/train2
rm -rf train_all.txt
cat  *.txt > $path/temp2/train_all2.txt

cd $path/temp2
cat *.txt > $path/train_all.txt


cd $path/test
rm -rf test_all.txt
cat *.txt > $path/test_all.txt



cd ~/yan/caffe
sudo sh $path2/create_lmdb.sh 

echo 'Done, converting data'

cd ~/yan/caffe
sudo build/tools/compute_image_mean $path2/img_train_lmdb $path2/mean.binaryproto

cd $path
python convert_mean.py mean.binaryproto mean.npy
# configure the sovler, tra_val and deploy files
# then, let's train model  execute train_code.sh to train the model
