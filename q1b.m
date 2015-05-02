#! /usr/bin/octave -qf
clear
% 5-fold Cross validation
warning ("off", "Octave:broadcast");

file = fopen("image_recognition.csv");
%only 5000 data points are used....Sampling

for i = 1:5000 
	s = substr(fgetl(file),1,1); %first column is read as the y label given for the points
	y(i,1) = s;
endfor

load I.txt I % loading sorted indexes from I.txt

%loop for cross validation for different values of k
for q = 1:100 
	k = q;

	y1 = zeros(5000,1); %y1 will hold the predicted label (average vote) from the k nearest neighbours

	for i = 1:5 
		for j = (i-1)*1000 + 1:i*1000
			count = 0;
			for p = 1:5000
				if (I(p,j) <=(i-1)*1000) | (I(p,j) > i*1000) % to check if the index doesnt belongs to the cross validation set itself
					count = count + 1;
					y1(j,1) = y1(j,1) + y(I(p,j));
				endif
				if(count == k) %this means we have taken k votes from the training set for a point
					break;
				endif
			endfor
		endfor
	endfor

	y1 = y1./k; %%average of k points , average vote
	y1 = round(y1); %% rounding off
	y1 = reshape(y1,1000,5);
	y = reshape(y,1000,5);
	individual_accuracy = sum(y1==y); % comparison with original y labels given
	individual_accuracy = individual_accuracy./1000; %as one cross validation set contains 1000 points, therefore avg is over 1000

	accuracy(1,q) = sum(individual_accuracy)/5; %overall average accuracy for a value of k

	K(1,q) = k;
endfor

accuracy = accuracy .* 100;
plot(K,accuracy,'r');
xlabel('k');
ylabel('5-fold Accuracy (%)');
title "5-fold Cross validation (KNN), datapoints:5000"
print plot1b.png;
warning ("error", "Octave:broadcast");
