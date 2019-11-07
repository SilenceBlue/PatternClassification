function w1 = PseudoInverse(classOne, classTwo)
    %α�淨ֱ����Ȩ�أ�����Ҫͨ����������⣩
	Y = [[classOne(:,1:end-1), ones(size(classOne, 1), 1)]; [classTwo(:,1:end-1), -1*ones(size(classTwo, 1), 1)]];
    dim = size(Y(:,1:end-1), 2);
    w0 = [0.5; zeros(dim, 1)]; % ��ʼ��w   
    
    feature = Y(:,1:end-1);
    label = Y(:,end);       
    I = ones(size(Y,1),1);
    Y_hat = [I, feature]; 
%     w1 = (inv((Y_hat'*Y_hat))*Y_hat')*label;
%     w1 = ((Y_hat'*Y_hat)\Y_hat')*label;
    w1 = pinv(Y_hat)*label;
end

