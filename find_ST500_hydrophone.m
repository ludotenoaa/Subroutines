function hydrophone=find_ST500_hydrophone(t,recorder)

% 2021 May-Nov deployment
if t>datenum(2021,5,2,0,0,0) && t<datenum(2021,11,1,0,0,0)
    A=[5625	1182
        5618	1251
        5451	1177
        5617	1179
        5620	1180
        5464	1181
        5449	1185
        5450	1184
        5447	1249
        5623	1255
        5453	1254
        5629	1250
        5626	1253
        5462	1262];
end

I=find(recorder==A(:,1));
hydrophone=A(I,2);




