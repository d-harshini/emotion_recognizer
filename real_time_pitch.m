%Pitch
function pitch_hz = real_time_pitch(Sig,fs)
FrameLen = 960;
FrameInc = 480;
M=floor(length(Sig)/FrameLen);
fSig=enframe(Sig,hamming(FrameLen,'periodic'),FrameInc);
for i = 1 : M
    x = fSig(i,:);
    auto_corr_y = xcorr(x);
    [pks,locs] = findpeaks(auto_corr_y);
    [mm,peak1_ind] = max(pks);
    k  = length(locs);
    if(peak1_ind < k)
         period = locs(peak1_ind+1) - locs(peak1_ind);
         if( period~=0)
             pitch_hz(i) = fs./period;
         end
    end 
end
end
