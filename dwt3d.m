
 function[LLL,LLH,HLL,HLH,LHL,LHH,HHL,HHH]=dwt3d(s)
[L,H]=xdwt3(s);
[LL,LH]=ydwt3(L);
[HL,HH]=ydwt3(H);
[LLL,LLH]=zdwt3(LL);
[LHL,LHH]=zdwt3(LH);
[HLL,HLH]=zdwt3(HL);
[HHL,HHH]=zdwt3(HH);

function[L,H]=xdwt3(s)
x=size(s);
for i=1:x(2)
for j=1:x(3)
m=s(:,i,j);
[s1,w1]=dwt(m,'db1');
y=size(s1);
for k=1:length(s1)
n=s1(k);
L(k,i,j)=n;
w=w1(k);
H(k,i,j)=w;
end
end
end

 function[L,H]=ydwt3(s)
x=size(s);
for i=1:x(1)
for j=1:x(3)
m=s(i,:,j);
[s1,w1]=dwt(m,'db1');
y=size(s1);
for k=1:length(s1)
n=s1(k);
L(i,k,j)=n;
w=w1(k);
H(i,k,j)=w;
end
end
end


function[L,H]=zdwt3(s)
x=size(s);
for i=1:x(1)
for j=1:x(2)
m=s(i,j,:);
m=m(:);
[s1,w1]=dwt(m,'db1');
y=size(s1);
for k=1:length(s1)
n=s1(k);
L(i,j,k)=n;
w=w1(k);
H(i,j,k)=w;
end
end
end
