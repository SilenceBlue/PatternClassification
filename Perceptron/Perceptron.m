function  w1 = Perceptron(classOne, classTwo, model)
    %��֪��Ȩ��ѧϰ����
    Y = [[classOne(:,1:end-1), ones(size(classOne, 1), 1)]; [classTwo(:,1:end-1), -1*ones(size(classTwo, 1), 1)]];
    dim = size(Y(:,1:end-1), 2);
    w0 = [0.5; zeros(dim, 1)]; % ��ʼ��w
    delta = getLoss(w0,Y);    
    iter = 0;
    while iter <= model.iterSize
        iter = iter + 1;
        if sum(abs(model.lamda*delta)) <= model.termination 
            break;
        end
        w1 = w0 + model.lamda*(delta);
        delta = getLoss(w1, Y);
        w0 = w1;
    end
    
end

function delta = getLoss(w, Y)
    feature = Y(:,1:end-1);
    label = Y(:,end);
    I = ones(size(Y,1),1);
    Y_hat = [I, feature];    
    temp = Y_hat*w.*label;
    temp_I = ones(1,size(Y_hat,2));
    error_i = find(temp<0); % ���������index  
    y = (label(error_i)*temp_I).*Y_hat(error_i,:); % ����*���
    delta = sum(y)';
end
