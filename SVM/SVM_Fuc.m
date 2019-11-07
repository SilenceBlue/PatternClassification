function [Acc, t_train] = SVM_Fuc(trainSet, testSet, sigma, C)
    totalClass = size(trainSet , 2) ;
    [lenTest , dim] = size(testSet) ;
    testLabel = testSet(:,dim) ;
    resultMat = zeros(lenTest , totalClass) ; %��Ž���ľ���Ϊ���Լ����ȣ��������   
    t_train = 0 ;
    model.iterSize = 100;
    model.termination = 1e-3;
    
    
    for i = 1:totalClass-1
        classOne = trainSet{i};
        for j = i+1:totalClass          
            classTwo = trainSet{j};
            tic;    
            train_data = [classOne(:,1:end-1);classTwo(:,1:end-1)];
            train_label = [ones(size(classOne,1),1);-1*ones(size(classTwo,1),1)];
            option = statset('MaxIter',30000);
            svmStruct = svmtrain(train_data, train_label, 'kernel_function','rbf', 'rbf_sigma', sigma, 'options', option, 'boxconstraint',C); % rbf��
            temp = svmclassify(svmStruct,testSet(:,1:end-1));   
            t = toc;
            t_train = t_train + t;
            
            %resultMat��һ������������Ϊ�У������Ϊ�еľ���
            indexClassOne = find(temp == 1) ;%�ҵ��ж�Ϊ��һ���λ��
            resultMat(indexClassOne , i) = resultMat(indexClassOne , i) + 1 ;%�ж�Ϊi�࣬���Ӧi�е�����+1
            indexClassTwo = find(temp == -1) ;
            resultMat(indexClassTwo , j) = resultMat(indexClassTwo , j) + 1 ;%�ж�Ϊj�࣬���Ӧj�е�����+1
        end
    end
    [~, finalClass] = max((resultMat'));
    Acc = size(find(finalClass' == testLabel),1)/lenTest;
end



