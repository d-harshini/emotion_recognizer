function [nw, sr]=real_time_speech_rate(Sig,fs)
nSig = Sig / max(abs(Sig));
thr1=0.03;
thr2=0.3;
word=1;
v=find(abs(nSig)>thr1);
voicePart=length(v)/fs;   
w=find(abs(nSig)>thr2);
n=length(w); 
for i=1:n-1     
    if (w(i+1)-w(i)>800)
       word=word+1;
    end
end
nw=word; 
sr=voicePart/nw; 
%plot(abs(nSig)) 
end