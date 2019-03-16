%SVM Classifier

clc;
SPECTF = csvread('Train.csv'); % read a csv file
labels = SPECTF(:, 1); % labels from the 1st column
features = SPECTF(:, 2:end); 
features_sparse = sparse(features); % features must be in a sparse matrix
libsvmwrite('trainingdataset.txt', labels, features_sparse);

%!!! REPLACE real_time_test.csv TO THAT FROM DESKTOP EVERYTIME !!!
for i=0:5

SPECTF = csvread('real_time_test.csv',i,0,[i 0 i 26]); % read a csv file
labels1 = SPECTF(:, 1); % labels from the 1st column
features = SPECTF(:, 2:end); 
features_sparse = sparse(features); % features must be in a sparse matrix
libsvmwrite('testingdataset.txt',labels1, features_sparse);

G = 0.34;
C = 100;

        [label_vector, instance_matrix] = libsvmread('trainingdataset.txt');
        [N D] = size(instance_matrix);
        cmd = ['-c ',num2str(1*C), ' -g ', num2str(1*G)];
        model = svmtrain(label_vector, instance_matrix,cmd);
        [label_v,instance_matrix1] = libsvmread('testingdataset.txt');
        [predict_label, accuracy, dec_values] = svmpredict(label_v,instance_matrix1, model); % test the training data

A={'Anger','Anxiety','Boredom','Disgust','Joy','Sad'};
emotion=string(A);
xlswrite('C:\Users\harshini\Works\CORI_sp\Codes\Final\real_time_classification.xls',[labels1,emotion(1,i+1),accuracy(1)],['A' num2str(i+1) ':' 'C' num2str(i+1)]);

end