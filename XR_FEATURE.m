clc;
close all;
clear all;
benign=[257:309];
malignent=[1:256];
c_10=zeros(1,309),c_10(malignent)=1;

mode='CC'%MLO
fname{1}='shape';
fname{2}='statistics';
fname{3}='glcm';
fname{4}='glrl';
fname{5}='glszm';
fname{6}='ngtdm';
fname{7}='wld';
fname{8}='gabor';
object={1,1:4,1:4,1:4,1:4,1:4,[1,3],1:4};
decomposition={1,1:5,1:5,1:5,1:5,1:5,1:5,1:5};
for i_feature=[1,2,3,4,5,6];

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
pp=[1:309];

for p=pp 
load(['E:\',mode,'\',num2str(j),'\in_xr',num2str(p)]);
in{1}=double(in{1});

for i1=decomposition{i_feature}
   I=in{i1};
   if i_feature==1
   ff=shape1(I);
   elseif i_feature==2
   ff=statistics1(I);
   elseif i_feature==3
   ff=glcm1(I);
   elseif i_feature==4
   ff=glrl1(I);
   elseif i_feature==5
   ff=glszm1(I);
   elseif i_feature==6
   ff=ngtdm1(I);
   elseif i_feature==7
   ff=wld1(I);
   elseif i_feature==8
   ff=gabor1(I);
   end
save([ 'E:\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c_10(p)),'\',num2str(p)],'ff');
 end
end
 end


if  i_feature~=1 
for c1=[0,1]
 if c1==1
        pp=malignent;
 else
        pp=benign;
 end
 for i1=decomposition{i_feature}
    for p=pp
     file{1}='Mp',file{2}='Mp£¨LL£©',file{3}='Mp£¨LH£©',file{4}='Mp£¨HL£©',file{5}='Mp£¨HH£©';
     a1=load([ 'E:\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
   file{1}='Mn',file{2}='Mn£¨LL£©',file{3}='Mn£¨LH£©',file{4}='Mn£¨HL£©',file{5}='Mn£¨HH£©';
    a2=load([ 'E:\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
    b1=a1.ff
    b2=a2.ff
    ff=abs(b1-b2);
    file{1}='ML',file{2}='ML£¨LL£©',file{3}='ML£¨LH£©',file{4}='ML£¨HL£©',file{5}='ML£¨HH£©';
    save([ 'E:\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)],'ff');
    
    file{1}='Zp',file{2}='Zp£¨LL£©',file{3}='Zp£¨LH£©',file{4}='Zp£¨HL£©',file{5}='Zp£¨HH£©';
    a3=load([ 'E:\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
    file{1}='Zn',file{2}='Zn£¨LL£©',file{3}='Zn£¨LH£©',file{4}='Zn£¨HL£©',file{5}='Zn£¨HH£©';
    a4=load([ 'E:\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
    b1=a3.ff
    b2=a4.ff
    ff=abs(b1-b2);
    file{1}='ZL',file{2}='ZL£¨LL£©',file{3}='ZL£¨LH£©',file{4}='ZL£¨HL£©',file{5}='ZL£¨HH£©';
 save([ 'E:\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)],'ff');
   end
end   
end
end

for c1=[0,1]
if c1==1
        pp=malignent;
    else
       pp=benign;
end  
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
    f=[];
    for p=pp
    a1=load([ 'E:\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
    a=a1.ff
    f=[f;a];
   end
    save([ 'E:\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\zong1'],'f');
end   
end
end
end