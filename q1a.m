#! /usr/bin/octave -qf
clear
%leave one out cross validation
warning ("off", "Octave:broadcast");

file = fopen("image_recognition.csv");
%only 5000 data points are used ...sampling

for i = 1:5000
	s = substr(fgetl(file),1,1); %first column is read as the given y labels
	y(i,1) = s;
endfor

load D.txt D %loading sorted distance matrix
load I.txt I %loading indexes of points corresponding to those distances

%loop for varying k, from 1 to 100
for q = 1:100
	k = q;

	D1 = resize(D,k+1,5000); %extracting k+1 points from the sorted distances matrix, k+1 because the point itself is contained as the min distances point
	I1 = resize(I,k+1,5000);

	y1 = zeros(5000,1);

	for i = 1:5000
		for j = 1:k+1
			if I1(j,i) ~= i
				y1(i,1) = y1(i,1) + y(I1(j,i));
			endif
		endfor
	endfor

	y1 = y1./k; %%average of k points
	y1 = round(y1); %% rounding off

	accuracy(1,q) = sum(y1==y)/5000; %comparing between orginal label and predicted label
	K(1,q) = k;
endfor

accuracy = accuracy .* 100;
plot(K,accuracy,'r');
xlabel('k');
ylabel('LOOCV Accuracy(%)');
title "Leave one out Cross validation (KNN), Datapoints:5000"
print plot1a.png;
warning ("error", "Octave:broadcast");
