#! /usr/bin/octave -qf
clear
%This file calculates distances between points, and stores them in D matrix(in sorted order) and the indexes in I matrix in D.txt and I.txt respectively
x = dlmread('image_recognition.csv',',',"B1..Q5000"); %5000 datapoints taken

warning ("off", "Octave:broadcast");

%feature scaling with standard deviation, this gave bad results, hence min-max scaling is used instead
%mu_x = mean(x);
%sigma_x = std(x);
%x = (x-mu_x)./sigma_x;

%feature scaling of second type with min ,max
min_x = min(x);
max_x = max(x);
diff_x = max(x) - min(x);
x = (x-min_x)./diff_x; 

%calculating the distance matrix D
for i = 1:5000
	v = x-x(i,:);
	v = v.^2;
	v = sum(v,2);
	v = v.^(0.5);
	[s,j] = sort(v); %sorting according to distances
	D(:,i) = s;
	I(:,i) = j;
endfor

save D.txt D -ascii %storing distances in D.txt
save I.txt I -ascii %storing indexes of sorted distance points in I.txt 
warning ("error", "Octave:broadcast");