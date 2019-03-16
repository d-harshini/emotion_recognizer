% Real time Emotion Recognition System 1. Dataset -> Feature extraction ->
% Training data, Testing data -> SVM classifier -> Record -> Feature exraction -> Normalize -> Classify

recObj = audiorecorder;

disp('Start speaking.')
recordblocking(recObj, 5);
disp('End of Recording.');

y = getaudiodata(recObj); 
plot(y);

en = real_time_energy(y);
disp('Energy: ');
disp(en);

mFormant = real_time_formant(y,8000);
meF = mean(mFormant); 
vF = var(mFormant);
disp('Mean of formants:');
disp(meF);
disp('Variance of formants:');
disp(vF);

cc=real_time_mfcc(y);
men=mean(cc);
disp('Mean of MFCC:');
disp(men);

pitch_hz=real_time_pitch(y,8000);
mfps = pitch_hz;
mep=mean(mfps);
vp=var(mfps);
disp('Mean of pitch:');
disp(mep);
disp('Variance of pitch:');
disp(vp);

[nw, sr] = real_time_speech_rate(y ,8000);
disp('Speech rate: ');
disp(sr);

xlswrite('C:\Users\harshini\Works\CORI_sp\Codes\Final\real_time_features.xls',[mep vp sr meF vF en men],['A' num2str(1) ':' 'Z' num2str(1)]);
data = xlsread('C:\Users\harshini\Works\CORI_sp\Codes\Final\real_time_features.xls','A1:Z1');
nor = normalize(data,'range');
for i=1:6
xlswrite('C:\Users\harshini\Works\CORI_sp\Codes\Final\real_time_test.xls',[i,nor],['A' num2str(i) ':' 'AA' num2str(i)]) ;
end

play(recObj);







