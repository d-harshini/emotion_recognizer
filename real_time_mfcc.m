%MFCC
function cc=real_time_mfcc(Sig)
%[Sig,fs]=wavread('03-01-03-01-01-01-01.wav');
bank=melbankm(20,512,48000,0,00.5,'m');%mel space filterbank [10]
ban=full(bank);
bank=bank/max(bank(:));
for k=1:10 %DCT coefficient
n=0:19;
coef(k,:)=cos((2*n+1)*k*pi/(2*20));
end
w=1+5*sin(pi*[1:10]./10);
w=w/max(w);
x=double(Sig);
x=filter([1-0.9375],1,x);
x=enframe(x,512,256);%segementation
for i=1:size(x,1) %Calculate MFCC for each frame
y=x(i,:);
s=y'.*hamming(512);
t=abs(fft(s));
t=t.^2;
c1=coef*log(bank*t(1:257));
c2=c1.*w';
m(i,:)=c2';
end
dtm=zeros(size(m));%differential coefficient
for i=3:size(m,1)-2
dtm(i,:)=-2*m(i-2,:)-m(i-1,:)+m(i+1,:)+m(i+2,:);
end
dtm=dtm/3;
cc=[m dtm];
cc=cc(3:size(m,1)-2,:);
cc(isnan(cc))=0;
%men=mean(cc);
%disp('men');
%disp(cc);
end