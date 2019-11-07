function [train test] = getTrainAndTest(trainSet, testSet) % train��cell���� test�Ǿ�������
    [totalClass, section] = size(trainSet);
    test=[];
    for i = 1:totalClass % ��testSet����������
        test = [test; testSet{i, 1}];
    end
    for i = 1:totalClass
        col_train = [];
        for j = 1:section
            col_train = [col_train; trainSet{i, j}];
        end
        train{1, i} = col_train;% ��trainSet����������������
    end
end