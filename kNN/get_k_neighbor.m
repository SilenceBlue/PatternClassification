function [pre_label] = get_k_neighbor(mat_dist, c, k)

% ͳ��ǰk����������������������һ��ı��
% pre_label������ǣ�һ������
% mat_dist����һ���Ǻ�ѡ�����ľ��룬�ڶ����Ǻ�ѡ�����������
% c���������
% k�����ڸ���

mat_rank = sortrows(mat_dist,1); % ���յ�һ�У������У������������ʱ����n��2��
a = mat_rank(1:k,2); % ѡ��ǰk����ѡ��������𹹳�������

vec_vote = [];
for i = 1:c % ͳ��ÿһ��ĺ�ѡ����������û�г��ֵ�����Ϊ0
    if isempty(find(a == i))
        vec_vote = [vec_vote;0];
    else
        vec_vote = [vec_vote;length(find(a == i))];
    end %if
end%for_i

temp_label = find(vec_vote == max(vec_vote)); % �ҳ������
if length(temp_label) > 1 % ���ֲ�����
    pre_label = 0;
else
    pre_label = temp_label;
end%if

end% function