%Formants

function mFormant=real_time_formant(Sig,fs);
FrameLen = fs*0.02;
FrameInc = FrameLen/2;
fSig=enframe(Sig,hamming(FrameLen,'periodic'),FrameInc);
no_frames=floor(length(Sig)/FrameLen);
for i=1:no_frames %279 frames
x=fSig(i,:);
if 1 && ~any(x)
Formant(i)=0; % for empty frame returns zero
else
pe = [1 0.95]; % preemphasis
x = filter(1,pe,x);
A = lpc(x,8); %lpc coefficient
rts = roots(A);
rts = rts(imag(rts)>=0);
ang = atan2(imag(rts),real(rts));
formants = 0;
[frq,indices] = sort(ang.*(fs/(2*pi)));
bw = -1/2*(fs/(2*pi))*log(abs(rts(indices)));
n = 1;
for k = 1:length(frq)
    if (frq(k) > 90 && bw(k) <400)
        formants(n) = frq(k);
        n = n+1;
    end
end
Formant(i)=formants(:,1);%dimension mismatch,here only take the first formant
end
end
ind=find(Formant);%find those nonzero values in fps for calculation
mFormant=Formant(ind);
end
