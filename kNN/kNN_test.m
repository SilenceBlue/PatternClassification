function [vec_res] = kNN_test(test_all, train_all, k)


% kNN�Ĳ��Թ��̣���Ҫѵ�����ݲ���
% train_all��һ��һ�����������һ���������
% test_all��һ��һ�����������һ���������
% k�����ڸ���


% Ԥ����
train_num = size(train_all,1); % ѵ����������
test_num = size(test_all,1); % ������������
c = length(unique(train_all(:,end))); % �������
label_train = train_all(:,end); % ѵ����������� 
label_test = test_all(:,end); % �������������
label_pre = [];

for i_test = 1:test_num
    vec_dist = get_dist(train_all(:,1:end-1),test_all(i_test,1:end-1),train_num,1); % ����һ��test,���������������train�ľ���
    mat_dist = [vec_dist,label_train]; % ��һ���Ǻ�ѡ�����ľ��룬�ڶ����Ǻ�ѡ�����������
    pre_now = get_k_neighbor(mat_dist,c,k); % ����ѵ��ʱ�õ������ݺ������Ԥ�⵱ǰ���������������
    label_pre = [label_pre;pre_now];
end%for_i_test

cmp_label = label_pre - label_test;
cmp_label(find(cmp_label~=0)) = 1; % ��Ԥ��������������Ϊ1����ȷ��Ϊ0

res_temp = [];
for i_c = 1:c 
    cmp_now = cmp_label(find(label_test ==  i_c));
    AA_now = 1 - sum(cmp_now)/length(cmp_now); % ��i_c�����Ԥ����ȷ��
    res_temp = [res_temp;AA_now];
end%for_i_c
Acc = (1 - sum(cmp_label)/test_num)*100; % �ܷ��ྫȷ��
AA = mean(res_temp)*100; % ����ƽ����ȷ��
GM = prod(res_temp).^(1/c)*100;%����ƽ����ȷ��
All = 0.5*(Acc+AA); % Acc��AA��ֵ

vec_res = [-1,-1,-1,-1,Acc,AA,GM,All];

end%function


