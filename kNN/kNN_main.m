function final_res = kNN_main( dataset_name, ktimes, k )
% Ԥ����
dirctory = '../dataSet/';
dataDir = strcat(dirctory,dataset_name);
load(dataDir);
n = strcat('=' , dataset_name);
fromeName = strcat(n , ';');
toName = 'dataSet';
eval([toName fromeName])% eval()������ת��Ϊָ��dataSet=iris_v;

dataname =  strcat('kNN_k',num2str(k),'_',dataset_name);%ת����ļ���
final_res = zeros(ktimes+2,8);%��¼ktimes�ֽ���ľ���,�����ڶ��д��ֵ�����һ�д�std��ÿһ�зֱ���TP,FP,TN,FN,acc,��ֵacc��gm,auc=

% ѵ�������
for i_cv = 1:ktimes    
   % ������ݼ������һ��Ϊ����ǣ�
    testSet = dataSet(:, mod(3+i_cv, ktimes) + 1);
    trainSet = dataSet;
    trainSet(:, mod(3+i_cv, ktimes) + 1) = []; 
    train_all =[];
    test_all = [];
    for i = 1:size(trainSet,1)
        for j = 1:size(trainSet,2)
            train_all = [train_all ; trainSet{i,j}];
        end
    end
    for i = 1:size(testSet,1)
        test_all = [test_all;testSet{i}];
    end
   % ����
   [vec_res] = kNN_test(test_all, train_all, k);
   %ͳ��һ�ֵĽ��
   final_res(i_cv,:) = vec_res;    
end%for_i_cv

% ͳ�ƽ��
final_res(ktimes+1,:) = mean(final_res(1:ktimes,:));
final_res(ktimes+2,:) = std(final_res(1:ktimes,:));

% ������
saveMatName = strcat('.\report\' , dataname);
save([saveMatName,'.mat'],'final_res');
end

