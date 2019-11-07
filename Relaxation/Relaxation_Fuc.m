function [Acc, t_train] = Relaxation_Fuc(trainSet, testSet)
    totalClass = size(trainSet , 2) ;
    [lenTest , dim] = size(testSet) ;
    testLable = testSet(:,dim) ;
    resultMat = zeros(lenTest , totalClass) ; %��Ž���ľ���Ϊ���Լ����ȣ��������   
    t_train = 0 ;
    model.iterSize = 100;
    model.termination = 1e-3;
    model.lamda = 0.01; % ѧϰ�������˹�С��Ҫ��Ȼѧϰ��������
    model.b = 0.7; % �ɳڱ����������ɳڱ���b������Ϊ[0,1]��������acc��������С��
    for i = 1:totalClass-1
        classOne = trainSet{i};
        for j = i+1:totalClass          
            classTwo = trainSet{j};
            tic;
            w = Relaxation(classOne, classTwo, model);
            t = toc;
            t_train = t_train + t;
            
            temp = class4test(w, testSet, lenTest);
            %resultMat��һ������������Ϊ�У������Ϊ�еľ���
            indexClassOne = find(temp == 1) ;%�ҵ��ж�Ϊ��һ���λ��
            resultMat(indexClassOne , i) = resultMat(indexClassOne , i) + 1 ;%�ж�Ϊi�࣬���Ӧi�е�����+1
            indexClassTwo = find(temp == -1) ;
            resultMat(indexClassTwo , j) = resultMat(indexClassTwo , j) + 1 ;%�ж�Ϊj�࣬���Ӧj�е�����+1
        end
    end
    [C, finalClass] = max((resultMat'));
    Acc = size(find(finalClass' == testLable),1)/lenTest;
end

function temp = class4test(w, testData,lenTest)
    test_set = zeros(lenTest, 1);
    I = ones(lenTest,1);
    data = [I, testData(:,1:end-1)];
    test_set = test_set + data*w;
    temp = sign(test_set);
    temp(find(temp == 0)) = 1;
end

