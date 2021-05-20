clc;
close all;
clear all;
mode{1}='CC';
mode{2}='MLO';
fname{1}='shape';
fname{2}='statistics';
fname{3}='glcm';
fname{4}='glrl';
fname{5}='glszm';
fname{6}='ngtdm';
fname{7}='wld';
fname{8}='gabor';

data_1=[];data_0=[];
for k=[1:2]
for i_feature=[1:8]
object={1,1:4,1:4,1:4,1:4,1:4,[1,3],1:4};
decomposition={1,1:5,1:5,1:5,1:5,1:5,1:5,1:5,};
for j=object{i_feature}
     if j==1
file{1}='Mp',file{2}='Mp£¨LL£©',file{3}='Mp£¨LH£©',file{4}='Mp£¨HL£©',file{5}='Mp£¨HH£©';
elseif j==2
file{1}='Mn',file{2}='Mn£¨LL£©',file{3}='Mn£¨LH£©',file{4}='Mn£¨HL£©',file{5}='Mn£¨HH£©';
elseif j==3
file{1}='Zp',file{2}='Zp£¨LL£©',file{3}='Zp£¨LH£©',file{4}='Zp£¨HL£©',file{5}='Zp£¨HH£©';
elseif j==4
file{1}='Zn',file{2}='Zn£¨LL£©';file{3}='Zn£¨LH£©',file{4}='Zn£¨HL£©',file{5}='Zn£¨HH£©';
     end
for i1=decomposition{i_feature}
    load([ 'E:\',mode{k},'\',fname{i_feature},'\',file{i1},'\1\zong1'])
    data_1=real(data_1);
    data_1=[data_1,f];
    load([ 'E:\',mode{k},'\',fname{i_feature},'\',file{i1},'\0\zong1'])
    data_0=real(data_0);
    data_0=[data_0,f];
end
end
end
end
 save([ 'E:\data_1'],'data_1');
 save([ 'E:\data_0'],'data_0');