function w1 = Relaxation( classOne, classTwo, model )
    % �ɳ��㷨Ȩ��wѧϰ����
    Y = [[classOne(:,1:end-1), ones(size(classOne, 1), 1)]; [classTwo(:,1:end-1), -1*ones(size(classTwo, 1), 1)]];
    dim = size(Y(:,1:end-1), 2);
    w0 = [0.5; zeros(dim, 1)]; % ��ʼ��w
    [delta, error_num] = getDelta(w0, Y, model);    
    iter = 0;
    while iter <= model.iterSize
        iter = iter + 1;
        if error_num == 0 
            break;
        end
        w1 = w0 + model.lamda*(delta);
        [delta, error_num]= getDelta(w1, Y, model);
        w0 = w1;
    end
end

function [delta, error_num] = getDelta(w, Y, model)
    feature = Y(:,1:end-1);
    label = Y(:,end);
    I = ones(size(Y,1),1);
    Y_hat = [I, feature];    
    temp = Y_hat*w.*label;
    temp_I = ones(1,size(Y_hat,2));
    error_i = find(temp<model.b); % ���������index
    error_num = length(error_i); % �������������
    
    y = (label(error_i)*temp_I).*Y_hat(error_i,:); % ����*���
    yy = sum(y.^2,2);
    delta = sum((((model.b-y*w)./yy)*temp_I).*y)';
end

